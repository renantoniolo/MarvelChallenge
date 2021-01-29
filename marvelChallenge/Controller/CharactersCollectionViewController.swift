//
//  CharactersCollectionViewController.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 27/01/21.
//

import UIKit

private let reuseIdentifier = "Cell"

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class CharactersCollectionViewController: UICollectionViewController {
    
    // label status/erro
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // Variaveis Globais
    var characters: [Hero] = []
    var checkConnection = NetworkConnection.shared
    var page: Int = 0
    var total: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCharacters()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    func loadCharacters(){
        
        if(checkConnection.checkConnection()){
            label.text = "searching characters..."
            MarvelRest.loadMarvelAPI(name: "", page: page) { (marvel) in
                
                if(marvel != nil){
                    
                    self.characters += (marvel?.data.results)!
                    self.total = (marvel?.data.total)!
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.label.text = self.total < 1 ? "not found character." : ""
                    }
                }
                else{
                    self.label.text = "error!"
                }
            }
        }
        else{
            self.label.text = "not connection internet!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cv = sender as! CharacterCollectionViewCell
        let vc = segue.destination as! DetailsViewController
        vc.character = cv.hero
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        collectionView.backgroundView = characters.count < 1 ? label : nil
        
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCollectionViewCell
    
        // Configure the cell
        let hero = characters[indexPath.row]
        cell.prepareCell(character: hero)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.item == characters.count - 5 && characters.count != total){
            page += 1
            loadCharacters()
            print("carregando mais...")
        }
    }

}
