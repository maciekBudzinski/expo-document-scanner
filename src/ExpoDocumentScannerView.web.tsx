import * as React from 'react';

import { ExpoDocumentScannerViewProps } from './ExpoDocumentScanner.types';

export default function ExpoDocumentScannerView(props: ExpoDocumentScannerViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
