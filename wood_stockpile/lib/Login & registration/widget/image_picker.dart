import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class image_picker extends StatefulWidget {
  image_picker({
    super.key,
    required this.onpicedImage,
  });
  final void Function(XFile pickedImage) onpicedImage;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _uimage();
  }
}

class _uimage extends State<image_picker> {
  var img = true;
  XFile? pickedimagefile;
  void imagepic() async {
    final pimage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pimage == null) {
      setState(() {
        img = true;
      });
      return;
    }
    setState(() {
      pickedimagefile = XFile(pimage.path);
    });
    widget.onpicedImage(pickedimagefile!);
  }

  void imagepic1() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pimage == null) {
      setState(() {
        img = true;
      });
      return;
    }
    setState(() {
      pickedimagefile = XFile(pimage.path);
    });
    widget.onpicedImage(pickedimagefile!);
  }

  Future<void> _showImageSourceDialog() async {
    setState(() {
      img = false;
    });
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    imagepic();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    imagepic1();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration:
          const BoxDecoration(color: const Color.fromARGB(255, 237, 235, 235)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          // decoration: BoxDecoration(image:DecorationImage(image: pickedimagefile != null ? FileImage(pickedimagefile!) : null,),) ,
          //   foregroundImage) :
          //       pickedimagefile != null ? FileImage(pickedimagefile!) : null,
          // ),
          // OutlinedButton.icon(
          //     onPressed: _showImageSourceDialog,
          //     icon: Icon(Icons.image),
          //     label: Text("image pic"))
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: pickedimagefile == null
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              onPressed: _showImageSourceDialog,
                              icon: Icon(
                                Icons.add,
                                size: 50,
                              ),
                            ),
                          ),
                          if (img)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Please enter the certificate",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.file(
                              File(pickedimagefile!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            onPressed: _showImageSourceDialog,
                            icon: const Icon(
                              Icons.add,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
