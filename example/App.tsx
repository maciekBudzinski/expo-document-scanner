import * as ExpoDocumentScanner from "expo-document-scanner";
import { useState } from "react";
import { Button, FlatList, Image, StyleSheet, Text, View } from "react-native";

export default function App() {
  const [permission, requestPermission] =
    ExpoDocumentScanner.useDocumentScannerPermissions();

  const [images, setImages] = useState<string[]>([]);

  const permissionStatusText = `Permission status: ${permission}`;

  const handleDocumentScan = async () => {
    const scanResult = await ExpoDocumentScanner.scanDocument();
    setImages(scanResult.images);
  };

  return (
    <View style={styles.container}>
      <Text>{permissionStatusText}</Text>

      {permission === "AUTHORIZED" ? (
        <Button title="📷 Scan Documents" onPress={handleDocumentScan} />
      ) : (
        <Button title="👉 Request Permissions" onPress={requestPermission} />
      )}
      <FlatList
        style={{
          flexGrow: 0,
        }}
        horizontal
        data={images}
        keyExtractor={(item) => item}
        renderItem={({ item }) => (
          <Image source={{ uri: item }} style={{ width: 200, height: 200 }} />
        )}
        ItemSeparatorComponent={() => <View style={{ width: 10 }} />}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    gap: 10,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});
