//
//  ImageDataCell.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import UIKit

class ImageDataCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageDataCell"
    
    @IBOutlet weak var imgData : ImageLoader?
    var configureCell : Hit? {
        didSet {
            if let strUrl = configureCell?.userImageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
               let imgUrl = URL(string: strUrl) {
                imgData?.loadImageWithUrl(imgUrl)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
