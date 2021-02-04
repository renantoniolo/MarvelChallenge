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
    @IBOutlet weak var btnAddFavorite: UIButton!
    var hero: Hero!
    var marvelManagerStored = MarvelManagerStored.shared
    var heros: [MarvelStorage]!
    
    func prepareCell(character: Hero, characters: [MarvelStorage] ){
        
        hero = character
        heros = characters
        
        if checkHero(id: hero.id) {
            btnAddFavorite.setImage(UIImage(named: "starHero"), for: .normal)
        }

        viewBack.layer.cornerRadius = 5
        lbCharacter.text = character.name
        
        if let url = URL(string: hero.thumbnail.url){
            imgCharacter.kf.indicatorType = .activity
            imgCharacter.kf.setImage(with: url)
            imgCharacter.layer.cornerRadius = 5
        }
        
    }
    
    func checkHero(id: Int) -> Bool {
        
        for fav in heros{
            if hero.id == fav.idCharacter{
                return true
            }
        }
        
        return false
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        
        if !checkHero(id: hero.id) {
        
            let ret = marvelManagerStored.insertCharacter(hero: hero, context: context)
            
            if !ret {
                print("erro ao gravar")
            }
        }
        
    }
}
