// ignore_for_file: unused_local_variable

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  Uint8List? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: url != null
            ? Container(
                height: 200,
                width: 200,
                child: Image.memory(url!),
              )
            : GestureDetector(
                onTap: () async {
                  var picked = await FilePicker.platform.pickFiles();

                  if (picked != null) {
                    print(picked.files.first.name);
                    final uploadFile = picked.files.first.bytes;

                    setState(() {
                      url = picked.files.first.bytes;
                    });

                    // upload file to firebase storage

                    // final refresend = await FirebaseStorage.instance
                    //     .ref('uploads')
                    //     .child(DateTime.now().microsecondsSinceEpoch.toString())
                    //     .putData(uploadFile!);

                    // final url = await refresend.ref.getDownloadURL();
                    // log("==========>>");
                    // print(url);
                  }
                },
                child: Text('Pick image')),
      ),
    );
  }
}
