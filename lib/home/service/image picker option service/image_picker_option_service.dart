import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOptionService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> showImagePickerOption(
      BuildContext context, Function(List<XFile>) onImagesPicked) async {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      List<XFile>? pickedFiles =
                          await _imagePicker.pickMultiImage();
                      if (pickedFiles.isNotEmpty) {
                        onImagesPicked(pickedFiles);
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.photo,
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff1e1e1a),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      XFile? pickedFile = await _imagePicker.pickImage(
                          source: ImageSource.camera);
                      if (pickedFile != null) {
                        onImagesPicked([pickedFile]);
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff1e1e1a),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
