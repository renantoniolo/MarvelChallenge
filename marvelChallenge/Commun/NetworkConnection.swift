//
//  NetworkConnection.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 28/01/21.
//

import Network


class NetworkConnection{
    
    static let shared = NetworkConnection()
    
    func checkConnection() -> Bool{
        
        let status = Reach().connectionStatus()

        switch status {
        case .unknown, .offline:
            // Not connected
            return false
        case .online(.wwan):
            // Connected via WWAN
            return true
        case .online(.wiFi):
            // Connected via WiFi
            return true
        }
        
    }
    
}
