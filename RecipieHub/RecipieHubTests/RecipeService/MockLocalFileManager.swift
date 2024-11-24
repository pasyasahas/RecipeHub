//
//  MockLocalFileManager.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/24/24.
//

import XCTest
@testable import RecipieHub

class MockLocalFileManager: LocalFileManagerProtocol {
    func getURLForFolder(folderName: String) async -> URL? {
        return nil
    }
    
    func getURLForImage(imageName: String, folderName: String) async -> URL? {
        return nil
    }
    
    var mockImages: [String: UIImage] = [:]
    var savedImages: [String: UIImage] = [:]
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        return mockImages[imageName]
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) throws {
        savedImages[imageName] = image
    }
}
