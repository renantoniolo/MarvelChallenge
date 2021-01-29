//
//  BaseExtensionViewController.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 28/01/21.
//

import UIKit
import CoreData

extension UIViewController{
    
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func showAlertView(title: String, textMessage: String, titleButton: String, style: UIAlertAction.Style){
        
        let alert = UIAlertController(title: title, message: textMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleButton, style: style, handler: nil))
        
        present(alert,animated: true,completion: nil)
    }
}

extension UICollectionViewCell{
    
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
