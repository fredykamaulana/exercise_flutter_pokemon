import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageMedia extends StatefulWidget {
  const ImageMedia({super.key});

  @override
  State<ImageMedia> createState() => _ImageMediaState();
}

class _ImageMediaState extends State<ImageMedia> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final path = _image!.path;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future showOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Gallery'),
            onTap: () {
              getImageFromGallery();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              getImageFromCamera();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget imageView() {
    return Column(
      children: [
        Center(
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Image'),
            onTap: () {
              setState(() {
                _image = null;
              });
            },
          ),
        ),
        Image.file(_image!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Picker Example')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: _image == null ? Text('No image selected.') : imageView(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showOptions,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
