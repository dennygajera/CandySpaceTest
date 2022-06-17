//
//  ExtensionImageView.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromUrl(url : String) {
        guard let url = URL(string: url) else {
            self.image = UIImage(named: "ic_placeholder")
            return
        }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }

    }
}
