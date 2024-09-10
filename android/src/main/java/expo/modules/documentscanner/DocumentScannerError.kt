package expo.modules.documentscanner

import expo.modules.kotlin.exception.CodedException

sealed class DocumentScannerError(
    override val code: String = unknownError,
    override val message: String? = null,
    override val cause: Throwable? = null
) : CodedException(message, cause) {

    class NoPagesException() :
        DocumentScannerError(noPagesErrorCode, "No pages scanned", null)

    class GetStartScanIntentException(cause: Throwable) :
        DocumentScannerError(getStartScanIntentErrorCode, "Get start scan intent failure", cause)

    companion object {
        const val unknownError = "E_UNKNOWN_ERROR"
        const val noPagesErrorCode = "E_NO_PAGES_ERROR"
        const val getStartScanIntentErrorCode = "E_GET_START_SCAN_INTENT_ERROR"
    }
}