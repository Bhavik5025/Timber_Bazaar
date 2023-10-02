import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PicImages extends StatefulWidget {
  PicImages({
    Key? key,
    required this.onPickedImages,
  }) : super(key: key);

  final void Function(List<XFile> pickedImages) onPickedImages;

  @override
  State<StatefulWidget> createState() {
    return _PicImagesState();
  }
}

class _PicImagesState extends State<PicImages> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imageFileList = selectedImages;
      });
      widget.onPickedImages(imageFileList);
    }
  }

  void removeImage(int index) {
    setState(() {
      imageFileList.removeAt(index);
    });
    widget.onPickedImages(imageFileList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: selectImages,
            child: Text('Select Images'),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  removeImage(index);
                },
                child: Image.file(
                  File(imageFileList[index].path),
                  fit: BoxFit.cover,
                ),
              );
            },
            itemCount: imageFileList.length,
          ),
        ),
      ],
    );
  }
}
