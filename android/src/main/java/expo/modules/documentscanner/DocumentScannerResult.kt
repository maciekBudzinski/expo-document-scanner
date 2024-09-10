package expo.modules.documentscanner

import expo.modules.kotlin.records.Field
import expo.modules.kotlin.records.Record

class DocumentScannerResult : Record {
    @Field
    var cancelled: Boolean = false

    @Field
    val images: MutableList<String> = mutableListOf()
}