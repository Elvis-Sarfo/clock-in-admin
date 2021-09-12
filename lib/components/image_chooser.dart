import 'dart:io';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;

class ImageChooser extends StatefulWidget {
  final double width;
  final Function(dynamic) onImageSelected;
  final String? defaultNetworkImage;
  ImageChooser({
    Key? key,
    this.width = 150,
    required this.onImageSelected,
    this.defaultNetworkImage,
  }) : super(key: key);

  @override
  _ImageChooserState createState() => _ImageChooserState();
}

class _ImageChooserState extends State<ImageChooser> {
  final picker = ImagePicker();
  // variable to hold image to be displayed
  var uploadedImage;

  var _imageUrl;
  var _image;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.defaultNetworkImage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Styles.primaryDarkColor.withOpacity(0.30),
        ),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            (kIsWeb) ? _startFilePicker() : _showPicker(context);
          },
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: _image != null || _imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: _imageUrl != null
                        ? Image.network(
                            _imageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.fill,
                          )
                        : (kIsWeb)
                            ? Image.memory(
                                _image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                _image,
                                // File.fromRawPath(uploadedImage),
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 150,
                    height: 150,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black38,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 25),
                            child: Text(
                              'Upload photo',
                              style: TextStyle(color: Styles.primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future _showPicker(context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
          content: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () => getImageFromGallery(),
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    // getImageFromCamera();
                    setState(() {
                      getImageFromCamera();
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getImageFromGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.of(context).pop();
    } else {
      print('No _image selected.');
    }
    Navigator.of(context).pop();
  }

//method to load image and update `uploadedImage`
  _startFilePicker() async {
    var uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        html.FileReader? reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((e) {
          setState(() {
            // reader.readAsDataUrl(file);
            uploadedImage = reader.result ?? null;
            _image = uploadedImage;
            widget.onImageSelected(file);
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            // option1Text = "Some Error occured while reading the file";
          });
        });
      }
    });
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No _image selected.');
    }
    Navigator.of(context).pop();
  }
}
