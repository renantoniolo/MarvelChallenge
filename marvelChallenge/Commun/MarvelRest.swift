//
//  MarvelRest.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 27/01/21.
//

import Foundation
import SwiftHash

class MarvelRest {
    
    static private let basePath = "https://gateway.marvel.com/v1/public/characters?" //"http://gateway.marvel.com/v1/public/characters?"
    static private let privateKey = "641e6d301a882637358569ac26a83927b7695147"
    static private let publicKey = "708af22fc92ea375d92b2b4af71da46a"
    static private let limit = 20
    
    private static let configuration: URLSessionConfiguration = {
        
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadMarvelAPI(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void){
        
        let offset = page * limit
        let nameStartsWith: String
        if let name = name, !name.isEmpty{
            nameStartsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        }
        else{
            nameStartsWith = ""
        }
        
        let urlstring = basePath + "offset=\(offset)&limit=\(limit)&" + nameStartsWith + getCredentials()
        print(urlstring)
        
        guard let url = URL(string: urlstring) else { return }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if(error == nil){

                guard let response = response as? HTTPURLResponse else {return}
                if(response.statusCode == 200){
                    print("Recebemos da api")
                    guard let data = data else {return}
                    
                    do{
                        let heros =  try JSONDecoder().decode(MarvelInfo.self, from: data)
                        for hero in heros.data.results{
                            print(hero.name)
                        }
                        onComplete(heros)
                        
                    }catch{
                        print("Erro a receber: \(error.localizedDescription)")
                        onComplete(nil)
                    }
                }
            }
            else{
                print(error!)
                onComplete(nil)
            }
        }
        dataTask.resume()
        
    }
    
    private class func getCredentials() -> String {
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
