import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { ExpoDocumentScannerViewProps } from './ExpoDocumentScanner.types';

const NativeView: React.ComponentType<ExpoDocumentScannerViewProps> =
  requireNativeViewManager('ExpoDocumentScanner');

export default function ExpoDocumentScannerView(props: ExpoDocumentScannerViewProps) {
  return <NativeView {...props} />;
}
