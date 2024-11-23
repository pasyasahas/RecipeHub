//
//  LocalFileManager.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//


import Foundation
import SwiftUI

protocol LocalFileManagerProtocol {
    func saveImage(image: UIImage, imageName: String, folderName: String) async throws
    
    func getImage(imageName: String, folderName: String) async -> UIImage?
    
    func getURLForFolder(folderName: String) async -> URL?
    
    func getURLForImage(imageName: String, folderName: String) async -> URL?
}

actor LocalFileManager: LocalFileManagerProtocol {
    
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) throws {
        
        try createFolderIfNeeded(folderName: folderName)
        
        // Get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // Save image to path
        do {
            try data.write(to: url)
        } catch let error {
            throw FileManagerError.errorSavingImage(imageName: imageName, error: error)
        }
    }
    
    // Fetche image from URL
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    // Create folder
    private func createFolderIfNeeded(folderName: String) throws {
        
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                throw FileManagerError.errorCreatingDirectory(folderName: folderName, error: error)
            }
        }
    }
    
    // Fetche URL for folder
    internal func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    // Fetche URL for Image
    internal func getURLForImage(imageName: String, folderName: String) -> URL? {
        
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
    
    
}


extension LocalFileManager {
    
    // Custom errors for FileManager operations
    enum FileManagerError: LocalizedError {
        case errorSavingImage(imageName: String, error: Error)
        case errorCreatingDirectory(folderName: String, error: Error)
        
        var errorDescription: String? {
            switch self {
            case .errorSavingImage(imageName: let imageName, error: let error): return "[❌] Error saving image: \(imageName) ERROR: \(error)"
            case .errorCreatingDirectory(folderName: let folderName, error: let error): return "[❌] Error creating directory: \(folderName) ERROR: \(error)"
                
            }
        }
        
    }
    
}
