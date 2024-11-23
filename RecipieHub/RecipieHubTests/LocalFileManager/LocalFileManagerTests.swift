//
//  LocalFileManagerTests.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/23/24.
//


import XCTest
import UIKit

@testable import RecipieHub

@MainActor
final class LocalFileManagerTests: XCTestCase {
    var fileManager: LocalFileManager!
    var testFolderName: String!
    var testImageName: String!
    var testImage: UIImage!
    
    override func setUpWithError() throws {
        fileManager = LocalFileManager.instance
        
        testFolderName = "test_recipe_images"
        testImageName = "test_recipeImage"
        
        // Creating a mock image
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        testImage = renderer.image { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 100, height: 100))
        }
    }
    
    override func tearDownWithError() throws {
        // Delete the folder after tests
        Task{
            if let folderURL = await fileManager.getURLForFolder(folderName: testFolderName) {
                try? FileManager.default.removeItem(at: folderURL)
            }
        }
        
    }
    
    // Check image is save without throwing error
    func testSaveImageSuccessfully() throws {
        
        XCTAssertNoThrow(Task{try await fileManager.saveImage(image: testImage, imageName: testImageName, folderName: testFolderName)})
        
        Task{
            let savedImage = await fileManager.getImage(imageName: testImageName, folderName: testFolderName)
            XCTAssertNotNil(savedImage, "The saved image should not be nil.")
        }
    }
    
    // Check invalid image not being fetched
    func testGetImageWhenImageDoesNotExist() {
        Task{
            let invalidImage = await fileManager.getImage(imageName: "invalid_image", folderName: testFolderName)
            XCTAssertNil(invalidImage, "The fetched image should be nil for a non-existent image.")
        }
        
    }
    
    // Check folder does exist
    func testGetURLForFolder() {
        Task {
            let folderURL = await fileManager.getURLForFolder(folderName: testFolderName)
            XCTAssertNotNil(folderURL, "The folder URL should not be nil.")
            XCTAssertTrue(folderURL!.path.contains(testFolderName), "The folder URL should contain the folder name.")
        }
    }
    
}
