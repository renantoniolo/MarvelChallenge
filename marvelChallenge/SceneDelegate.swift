//
//  SceneDelegate.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 27/01/21.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    // List of known shortcut actions.
    enum ActionType: String {
        case favoriteAction = "FavoriteAction"
        
    }
    
    var window: UIWindow?
    var savedShortCutItem: UIApplicationShortcutItem!

    /// - Tag: willConnectTo
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        window?.tintColor = .black
        
        if let shortcutItem = connectionOptions.shortcutItem {
            // Save it off for later when we become active.
            savedShortCutItem = shortcutItem
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Quick Action", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func openView() {
        
        if let navController = window?.rootViewController as? UINavigationController {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let favoritesCollectionViewController =
                   storyboard.instantiateViewController(identifier: "TabBar") as? FavoritesCollectionViewController {
                   // Pass the contact to the detail view controller and push it.
                favoritesCollectionViewController.
                   //navController.pushViewController(detailsViewController, animated: false)
               }
        }

         
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        if let actionTypeValue = ActionType(rawValue: shortcutItem.type) {
            switch actionTypeValue {
               case .favoriteAction:
                openView()//showAlert(message: "Favoritos")
            }
        }
        return true
    }
    
    func windowScene(_ windowScene: UIWindowScene,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        
        let handled = handleShortCutItem(shortcutItem: shortcutItem)
        completionHandler(handled)
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        if savedShortCutItem != nil {
            _ = handleShortCutItem(shortcutItem: savedShortCutItem)
        }
    }
    
    // Busca na base de dados os herois cadastrados
    func sceneWillResignActive(_ scene: UIScene) {

        let application = UIApplication.shared
        application.shortcutItems = MarvelManagerStored.shared.characters.map { contact -> UIApplicationShortcutItem in
            return UIApplicationShortcutItem(type: ActionType.favoriteAction.rawValue,
                                             localizedTitle: contact.nameCharacter! as String,
                                             localizedSubtitle: contact.nameCharacter! as String,
                                             icon: UIApplicationShortcutIcon(systemImageName: "star.fill")
                                             )
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

