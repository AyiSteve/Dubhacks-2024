
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _selectedFile;
  String? _uploadStatus;
  String? _downloadUrl;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _uploadStatus = null; 
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      setState(() {
        _uploadStatus = 'Uploading...';
      });

      try {
        String fileName = _selectedFile!.path.split('/').last;
        Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
        UploadTask uploadTask = storageRef.putFile(_selectedFile!);

        await uploadTask;
        _downloadUrl = await storageRef.getDownloadURL();

        setState(() {
          _uploadStatus = 'File uploaded successfully!';
        });
      } catch (e) {
        setState(() {
          _uploadStatus = 'Upload failed: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload_file, size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    _selectedFile != null
                        ? "File Selected: ${_selectedFile!.path.split('/').last}"
                        : "Upload Your File Here",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _uploadFile,
            child: const Text("Upload File"),
          ),
          const SizedBox(height: 20),
          if (_uploadStatus != null)
            Column(
              children: [
                Text(
                  _uploadStatus!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if (_downloadUrl != null) ...[
                  const SizedBox(height: 10),
                  Text("Download URL:"),
                  Text(
                    _downloadUrl!,
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
