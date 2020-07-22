import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(
    File pickedImage,
  ) imagePickFn;

  const UserImagePicker({Key key, this.imagePickFn}) : super(key: key);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: MediaQuery.of(context).size.width * 0.15,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(
      File(pickedImageFile.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          radius: MediaQuery.of(context).size.height * 0.04,
        ),
        FlatButton.icon(
          textColor: kIconColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
