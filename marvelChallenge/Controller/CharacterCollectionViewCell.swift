//
//  CharacterCollectionViewCell.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 27/01/21.
//

import UIKit
import Kingfisher

@available(iOS 13.0, *)
class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lbCharacter: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    var hero: Hero!
    var marvelManagerStored = MarvelManagerStored.shared
    
    func prepareCell(character: Hero){
        
        hero = character
        
        viewBack.layer.cornerRadius = 5
        lbCharacter.text = character.name
        
        if let url = URL(string: hero.thumbnail.url){
            imgCharacter.kf.indicatorType = .activity
            imgCharacter.kf.setImage(with: url)
            imgCharacter.layer.cornerRadius = 5
        }
        
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        
        let ret = marvelManagerStored.insertCharacter(hero: hero, context: context)
        
        if !ret {
            print("erro ao gravar")
        }
        
    }
}
