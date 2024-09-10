package expo.modules.documentscanner

import expo.modules.kotlin.Promise
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ExpoDocumentScannerModule : Module() {

  override fun definition() = ModuleDefinition {

    val documentScannerImpl = DocumentScannerImpl(appContext)


    Name("ExpoDocumentScanner")

    OnDestroy {
      documentScannerImpl.unregisterDocumentScanner()
    }

      AsyncFunction("scanDocument") { promise: Promise ->
        documentScannerImpl.scanDocuments(promise)
    }
  }
}
