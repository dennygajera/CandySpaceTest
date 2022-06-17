//
//  ExtensionViewController.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//
import Foundation
import UIKit

extension UINavigationController {
    func pop(_ animated: Bool) {
        _ = self.popViewController(animated: animated)
    }

    func popToRoot(_ animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }

}

extension UIViewController {

    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard : AppStoryboard) -> Self {
        return appStoryboard.viewController(self)
    }
}

enum AppStoryboard : String {
    case Main
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T : UIViewController>(_ viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UINavigationController {
  func getReference<ViewController: UIViewController>(to viewController: ViewController.Type) -> ViewController? {
        return viewControllers.first { $0 is ViewController } as? ViewController
    }
}



