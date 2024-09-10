import { NativeModulesProxy, EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to ExpoDocumentScanner.web.ts
// and on native platforms to ExpoDocumentScanner.ts
import ExpoDocumentScannerModule from './ExpoDocumentScannerModule';
import ExpoDocumentScannerView from './ExpoDocumentScannerView';
import { ChangeEventPayload, ExpoDocumentScannerViewProps } from './ExpoDocumentScanner.types';

// Get the native constant value.
export const PI = ExpoDocumentScannerModule.PI;

export function hello(): string {
  return ExpoDocumentScannerModule.hello();
}

export async function setValueAsync(value: string) {
  return await ExpoDocumentScannerModule.setValueAsync(value);
}

const emitter = new EventEmitter(ExpoDocumentScannerModule ?? NativeModulesProxy.ExpoDocumentScanner);

export function addChangeListener(listener: (event: ChangeEventPayload) => void): Subscription {
  return emitter.addListener<ChangeEventPayload>('onChange', listener);
}

export { ExpoDocumentScannerView, ExpoDocumentScannerViewProps, ChangeEventPayload };
