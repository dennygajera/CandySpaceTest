//
//  ImageDataViewModel.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import Foundation
import UIKit
class ImageDataViewModel {
    weak var imageListVC : ImageListVC!
    var imageDataResponse : ImageModel?
    var requestManager = NetworkRequestManager()
    
    
    func GetSearchedResult(searchedText : String, CompletionHandler : @escaping (() -> ())) {
        requestManager.getSearchedImages(searchedText: searchedText) { [weak self] responseData, respnseError in
            guard let weakSelf = self else { return }
            if respnseError == nil {
                if responseData?.hits?.count == 0 {
                    ErrorReporting.shared.showAlertMessage(msg: "You have searched for *\(searchedText)* which doesn't match with our database, Please try to search *yellow+flowes*")
                    CompletionHandler()
                }
                weakSelf.imageDataResponse = responseData
                CompletionHandler()
            } else {
                ErrorReporting.shared.showAlertMessage(msg: respnseError?.localizedDescription ?? "")
            }
            
        }
    }
    
    
    
}
