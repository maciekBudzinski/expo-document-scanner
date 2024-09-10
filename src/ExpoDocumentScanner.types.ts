export type CameraPermissionStatus =
  | "UNKNOWN"
  | "NOT_DETERMINED"
  | "RESTRICTED"
  | "DENIED"
  | "AUTHORIZED";

export type DocumentScannerResult = {
  canceled: boolean;
  images: string[];
};
