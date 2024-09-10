//
//  DocumentPickerError.swift
//  ExpoDocumentScanner
//
//  Created by Maciej Budzinski on 17/09/2024.
//

import Foundation

enum DocumentScannerError: Error, CustomStringConvertible {
    static let noViewControllerCode = "E_NO_VIEW_CONTROLLER"
    static let documentCameraViewControllereErrorCode = "E_DOCUMENT_CAMERA_VIEW_CONTROLLER_ERROR"
    
    case noViewController
    case documentCameraViewControllerError(originalError: Error)
    
    public var code: String {
        switch self {
        case .noViewController:
            return DocumentScannerError.noViewControllerCode
        case .documentCameraViewControllerError:
            return DocumentScannerError.documentCameraViewControllereErrorCode
        }
    }
    
    public var description: String {
        switch self {
        case .noViewController:
            return "Could not found view controller."
        case .documentCameraViewControllerError:
            return "Native document camera view controller error."
        }
    }
    
    var underlyingError: Error? {
        switch self {
        case .documentCameraViewControllerError(let originalError):
            return originalError
        default:
            return nil
        }
    }
}
