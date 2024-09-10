//
//  DocumentScannerPermissionsImpl.swift
//  ExpoDocumentScanner
//
//  Created by Maciej Budzinski on 16/09/2024.
//

import AVFoundation

class DocumentScannerPermissionsImpl {
    func checkCameraPermission() -> String {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        var statusString = "UNKNOWN"
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            statusString = "NOT_DETERMINED"
        case .restricted:
            statusString = "RESTRICTED"
        case .denied:
            statusString = "DENIED"
        case .authorized:
            statusString = "AUTHORIZED"
        @unknown default:
            statusString = "UNKNOWN"
        }
        
        return statusString
    }
    
    func checkAndRequestCameraPermission(completion: @escaping (Bool) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            // Camera access has already been granted
            completion(true)
            
        case .notDetermined:
            // Camera access has not been requested yet, request permission
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            }
            
        case .denied:
            // Camera access has been denied
            completion(false)
            
        case .restricted:
            // Camera access is restricted, possibly due to parental controls
            completion(false)
            
        @unknown default:
            // Handle any future cases (e.g., new statuses introduced by Apple)
            completion(false)
        }
    }
}
