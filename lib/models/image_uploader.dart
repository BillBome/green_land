import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploader extends StatefulWidget {
  final Function(String?) onImagePicked;

  const ImageUploader({Key? key, required this.onImagePicked})
      : super(key: key);

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  XFile? _image;
  bool _uploading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      setState(() {
        _uploading = true;
      });

      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) {
        return; // User canceled image picking
      }

      final path = 'item_images/${pickedImage.name}';

      // Upload the image to Firebase Storage
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(path);

      final UploadTask uploadTask =
          storageReference.putFile(File(pickedImage.path));

      await uploadTask.whenComplete(() async {
        final String downloadUrl = await storageReference.getDownloadURL();
        setState(() {
          _image = pickedImage;
          widget.onImagePicked(downloadUrl);
          _uploading = false;
        });
      });
    } catch (e) {
      print('Error picking/uploading image: $e');
      // Handle error, show a snackbar, etc.
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.file(
                    File(_image!.path),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: _uploading
                      ? CircularProgressIndicator()
                      : Text(
                          'Image Uploader',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _uploading ? null : _pickImage,
          child: Text('Pick Image'),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
