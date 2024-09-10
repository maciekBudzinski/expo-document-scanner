package expo.modules.documentscanner

import android.app.Activity
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.Promise

class DocumentScannerImpl(private val appContext: AppContext) {
    private lateinit var scannerLauncher: ActivityResultLauncher<IntentSenderRequest>

    fun scanDocuments(promise: Promise) {
        val options = GmsDocumentScannerOptions.Builder()
            .setGalleryImportAllowed(false)
            .setResultFormats(GmsDocumentScannerOptions.RESULT_FORMAT_JPEG)
            .setScannerMode(GmsDocumentScannerOptions.SCANNER_MODE_FULL)
            .build()

        val scanner = GmsDocumentScanning.getClient(options)

        val scannerLauncher =
            (appContext.currentActivity as ComponentActivity).activityResultRegistry.register(
                "document-scanner",
                ActivityResultContracts.StartIntentSenderForResult()
            ) { activityResult ->
                run {
                    if (activityResult.resultCode == Activity.RESULT_CANCELED) {
                        promise.resolve(DocumentScannerResult().apply { cancelled = true })
                    }

                    if (activityResult.resultCode == Activity.RESULT_OK) {
                        val documentScanningResult =
                            GmsDocumentScanningResult.fromActivityResultIntent(activityResult.data)

                        documentScanningResult?.pages?.let { pages ->
                            val result = DocumentScannerResult()
                            for (page in pages) {
                                result.images.add(page.imageUri.toString())
                            }
                            promise.resolve(result)
                        } ?: promise.reject(DocumentScannerError.NoPagesException())
                    }
                }
            }


        scanner.getStartScanIntent(appContext.currentActivity as ComponentActivity)
            .addOnSuccessListener { intentSender ->
                scannerLauncher.launch(IntentSenderRequest.Builder(intentSender).build())
            }
            .addOnFailureListener {
                promise.reject(DocumentScannerError.GetStartScanIntentException(it))
            }
    }

    fun unregisterDocumentScanner() {
        scannerLauncher.unregister()
    }
}