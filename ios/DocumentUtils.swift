//
//  DocumentUtils.swift
//  ExpoDocumentScanner
//
//  Created by Maciej Budzinski on 16/09/2024.
//

import Foundation
import VisionKit

class DocumentUtils {
    static func convertToImages(scan: VNDocumentCameraScan) -> [String] {
        var imageUris: [String] = []
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        for pageIndex in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageIndex)
            
            // Convert the image to JPEG data
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                continue
            }
            
            // Create a unique file name for the image
            let fileName = UUID().uuidString + ".jpg"
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            // Save the image to the document directory
            do {
                try imageData.write(to: fileURL)
                // Append the URI of the saved image
                imageUris.append(fileURL.absoluteString)
            } catch {
                // Handle the error appropriately
                print("Error saving image: \(error)")
            }
        }
        return imageUris
    }
}
