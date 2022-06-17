//
//  ViewModelTests.swift
//  Candyspace_Test_DarshanTests
//
//  Created by Darshan Gajera
//

import Foundation
import XCTest

@testable import Candyspace_Test_Darshan

class MockNetworkRequestManager: NetworkRequestable {
    enum ResponseType {
        case error
        case success
    }
    
    var responseType: ResponseType = .error
    
    func getSearchedImages(searchedText : String,completionHandler: @escaping (ImageModel?, Error?) -> Void) {
        
        switch responseType {
        case .error:
            completionHandler(nil, NSError(domain: "testing", code: 0, userInfo: [NSLocalizedDescriptionKey:"Testing Error"]) )
        case .success:
            let t = type(of: self)
            let bundle = Bundle(for: t.self)
            let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
            let data = try! Data(contentsOf: path)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try! decoder.decode(ImageModel.self, from: data)
            completionHandler(json, nil)
        }
        
    }
}

class ViewModelTests: XCTestCase {
    
    var systemUnderTest: ImageDataViewModel!
    var mockRequestManager: MockNetworkRequestManager!
    
    override func setUpWithError() throws {
        mockRequestManager = MockNetworkRequestManager()
        systemUnderTest = ImageDataViewModel()
        prepareMockData()
    }
    
    override func tearDownWithError() throws {
        mockRequestManager = nil
        systemUnderTest = nil
    }
    
    func prepareMockData() {
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let json = try decoder.decode(ImageModel.self, from: data)
            systemUnderTest.imageDataResponse = json
        } catch let err {
            print("Error while converting data into model", err.localizedDescription)
        }
    }
    
    func testNetworkRequest_Success() throws {
        mockRequestManager.responseType = .success
        mockRequestManager.getSearchedImages(searchedText: "Test") { respData, respError in
            XCTAssertNotNil(respData)
        }
        
    }
    
    func testNetworkRequest_Failuer() throws {
        mockRequestManager.responseType = .error
        mockRequestManager.getSearchedImages(searchedText: "yellow+flowers") { respData, respError in
            XCTAssertNil(respData)
        }
    }
    
    func testNetworkRequest_With_UnwantedSearch() throws {
        mockRequestManager.responseType = .success
        mockRequestManager.getSearchedImages(searchedText: "asfasfasewqe") { respData, respError in
            XCTAssertNotEqual(respData?.hits?.count, 0)
        }
    }
    func testNetworkRequest_With_Blank() throws {
        mockRequestManager.responseType = .error
        mockRequestManager.getSearchedImages(searchedText: "") { respData, respError in
            XCTAssertNotEqual(respData?.hits?.count, 0)
        }
    }
    

}
