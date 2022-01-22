//
//  NavigationManager.swift
//  Movies App
//
//  Created by aleksandre on 16.01.22.
//

import Foundation
import UIKit

class NavigationManager {
    
    enum TargetView {
        case SearchScreen
        case DetailsScreen
        case SettingsScreen
    }
    
    enum TransferStyle {
        case push
        case present
    }
    
    public static func changeScene(from currentScreen: UIViewController, to chosenScreen: TargetView, with transferStyle: TransferStyle) {
        
        var targetVC: UIViewController!
        
        switch chosenScreen {
        case .SearchScreen:
            targetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SearchViewController.identifier) as!
            SearchViewController
        case .DetailsScreen:
            targetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
        case .SettingsScreen:
            targetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SettingsViewController.identifier) as!
            SettingsViewController
        }
        
        switch transferStyle {
        case .present: currentScreen.navigationController?.present(targetVC, animated: true, completion: nil)
        case .push: currentScreen.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}
