import ExpoModulesCore
import VisionKit
import Vision

public class ExpoDocumentScannerModule: Module, DocumentScannerModuleDelegate {
    private var promise: Promise?
    
    public func onCancel(_ result: [String: Any]) {
        promise?.resolve(result)
        promise = nil
    }
    
    public func onError(_ error: any Error) {
        promise?.reject(error)
        promise = nil
    }
    
    public func onSuccess(_ result: [String: Any]) {
        promise?.resolve(result)
        promise = nil
    }
    
    let documentScannerImpl = DocumentScannerImpl()
    let documentScannerPermissionsImpl = DocumentScannerPermissionsImpl()
    
    public func definition() -> ModuleDefinition {
        Name("ExpoDocumentScanner")
        
        OnCreate {
            documentScannerImpl.delegate = self
        }
        
        Function("checkCameraPermissions") {
            return documentScannerPermissionsImpl.checkCameraPermission()
        }
        
        AsyncFunction("requestCameraPermissions") { (promise: Promise) in
            documentScannerPermissionsImpl.checkAndRequestCameraPermission { granted in
                promise.resolve(granted)
            }
        }
        
        AsyncFunction("scanDocument") { (promise: Promise) in
            self.promise = promise
            documentScannerImpl.scanDocument()
        }.runOnQueue(.main)
    }
}
