const withExpoDocumentScanner = (config) => {
  // Ensure the objects exist
  if (!config.ios) {
    config.ios = {};
  }
  if (!config.ios.infoPlist) {
    config.ios.infoPlist = {};
  }

  config.ios.infoPlist["NSCameraUsageDescription"] =
    "Needs Permission for Document Scanner";
  return config;
};

exports.default = withExpoDocumentScanner;
