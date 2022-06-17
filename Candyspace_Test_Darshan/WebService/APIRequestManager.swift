//
//  APIRequestManager.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import Foundation

protocol NetworkRequestable {
    func getSearchedImages(searchedText : String,completionHandler: @escaping (_ result:ImageModel?, _ error: Error?) -> Void)
}

class NetworkRequestManager: NetworkRequestable {
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    static  let shared = NetworkRequestManager()
    
    func getSearchedImages(searchedText : String, completionHandler: @escaping (_ result:ImageModel?, _ error: Error?) -> Void) {
        
        guard let url = RequestBuilder.searchForImage(for: searchedText) else { return }
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.dataTask = nil }
            
            if let error = error { return completionHandler(nil, error) }
            
            if let response = response as? HTTPURLResponse, let data = data {
                
                switch response.statusCode {
                    
                case 200...299:
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let resultdata = try decoder.decode(ImageModel.self, from: data)
                        
                        completionHandler(resultdata, nil)
                    } catch {
                        completionHandler(nil, error)
                    }
                    
                default:
                    print("Invalid State Code: \(response.statusCode)")
                    completionHandler(nil, error)
                }
            }
        }
        dataTask?.resume()
    }
}

class RequestBuilder {
    
    static func searchForImage(for searchText: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pixabay.com"
        urlComponents.path = "/api/"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "13197033-03eec42c293d2323112b4cca6"),
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "image_type", value: "photo"),
            URLQueryItem(name: "pretty", value: "true")
        ]
        return urlComponents.url
    }
}
