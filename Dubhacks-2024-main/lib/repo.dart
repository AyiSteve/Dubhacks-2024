
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:path/path.dart'; // For file name extraction

class FileRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Upload a file to Firebase Storage
  Future<String?> uploadFile(File file) async {
    try {
      String fileName = basename(file.path); // Extract file name
      Reference storageRef = _firebaseStorage.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);

      // Wait for the upload to complete and return the download URL
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      if (snapshot.state == TaskState.success) {
        String downloadUrl = await storageRef.getDownloadURL();
        return downloadUrl; // Return the download URL of the uploaded file
      } else {
        throw Exception('File upload failed.');
      }
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  // Get the list of files from Firebase Storage
  Future<List<Reference>> listFiles() async {
    try {
      ListResult result = await _firebaseStorage.ref('uploads').listAll();
      return result.items; // Return the list of file references
    } catch (e) {
      print('Error fetching files: $e');
      return [];
    }
  }

  // Download file content from Firebase Storage and save it locally
  Future<File?> downloadFile(String downloadUrl, String fileName) async {
    try {
      Reference ref = _firebaseStorage.refFromURL(downloadUrl); // Get reference from the download URL
      Directory systemTempDir = Directory.systemTemp;
      File tempFile = File('${systemTempDir.path}/$fileName');

      // Delete the file if it exists before downloading
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      // Download the file to a temporary location
      await ref.writeToFile(tempFile);
      return tempFile; // Return the downloaded file
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }
}
