import { Platform } from "react-native";

import {
  CameraPermissionStatus,
  DocumentScannerResult,
} from "./ExpoDocumentScanner.types";
import ExpoDocumentScannerModule from "./ExpoDocumentScannerModule";

export async function scanDocument(): Promise<DocumentScannerResult> {
  return ExpoDocumentScannerModule.scanDocument();
}

export function checkCameraPermissionsStatus(): CameraPermissionStatus {
  if (Platform.OS === "android") {
    return "AUTHORIZED";
  }
  return ExpoDocumentScannerModule.checkCameraPermissions();
}

export async function requestPermissions(): Promise<boolean> {
  if (Platform.OS === "android") {
    return true;
  }

  return await ExpoDocumentScannerModule.requestCameraPermissions();
}

export const useDocumentScannerPermissions = () => {
  return [checkCameraPermissionsStatus(), requestPermissions] as const;
};
