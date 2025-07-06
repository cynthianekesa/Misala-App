import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function(File) onImagePicked;

  const ImageInput(this.onImagePicked, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
  source: source,
  imageQuality: 80,
);

    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    setState(() {
      _storedImage = imageFile;
    });
    widget.onImagePicked(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_storedImage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(_storedImage!, height: 150),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Gallery'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ],
    );
  }
}
