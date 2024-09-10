import VisionKit
import Vision
import ExpoModulesCore

//@objc(DocumentScannerModuleDelegate)
public protocol DocumentScannerModuleDelegate: AnyObject {
    func onCancel(_ result: [String: Any])
    func onError(_ error: Error)
    func onSuccess(_ result: [String: Any])
}
/**
 * Native module's shared implementation
 */
public class DocumentScannerImpl : NSObject {
    public weak var delegate: DocumentScannerModuleDelegate? = nil
    
    static let INVALID_PATH_ERROR_MESSAGE = "Invalid path"
    static let NO_VIEW_CONTROLLER_ERROR_MESSAGE = "No viewcontroller"
    
    public func scanDocument() {
        guard let presentedViewController = RCTPresentedViewController() else {
            let error = DocumentScannerError.noViewController
            delegate?.onError(error)
            return
        }
        
        let documentPicker = VNDocumentCameraViewController()
        documentPicker.delegate = self
        presentedViewController.present(documentPicker, animated: true)
    }
}

extension DocumentScannerImpl : VNDocumentCameraViewControllerDelegate {
    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true, completion: nil)
        
        let images = DocumentUtils.convertToImages(scan: scan)
        
        delegate?.onSuccess(["canceled": false, "images": images])
    }
    
    public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true, completion: nil)
        delegate?.onCancel(["canceled": true, "images": []])
    }
    
    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true, completion: nil)
        let error = DocumentScannerError.documentCameraViewControllerError(originalError: error)
        delegate?.onError(error)
    }
}
