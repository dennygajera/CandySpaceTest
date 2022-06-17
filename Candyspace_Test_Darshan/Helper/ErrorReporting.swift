//
//  ErrorReporting.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import Foundation
import UIKit

class ErrorReporting {
    static let shared = ErrorReporting()
    func showAlertMessage(msg : String) {
        let alert = UIAlertController(title: "Candyspace", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
