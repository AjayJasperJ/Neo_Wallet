import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/text_styles.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(ImageSource) onImagePicked;

  const ImageSourceSheet({Key? key, required this.onImagePicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displaysize = MediaQuery.of(context).size;

    return Container(
      height: displaysize.height * 0.25,
      padding: EdgeInsets.symmetric(
        horizontal: displaysize.width * .04,
        vertical: displaysize.height * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(displaysize.width * .04),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: displaysize.height * .01,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Image",
              style: CustomTextStyler()
                  .styler(size: .024, color: neo_theme_blue3, type: 'M'),
            ),
            SizedBox(height: displaysize.height * .01),
            ListTile(
              leading: Icon(Icons.camera_alt, color: neo_theme_blue0),
              title: Text(
                "Take a Photo",
                style: CustomTextStyler()
                    .styler(size: .018, color: neo_theme_blue3, type: 'M'),
              ),
              onTap: () => onImagePicked(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: neo_theme_blue0),
              title: Text(
                "Choose from Gallery",
                style: CustomTextStyler()
                    .styler(size: .018, color: neo_theme_blue3, type: 'M'),
              ),
              onTap: () => onImagePicked(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

class FilePickerSheet extends StatelessWidget {
  final Function(File?) onFilePicked;
  final List<String> allowedExtensions;

  const FilePickerSheet({
    Key? key,
    required this.onFilePicked,
    this.allowedExtensions = const [
      'pdf',
      'doc',
      'txt',
      'png',
      'jpg',
      'jpeg'
    ],
  }) : super(key: key);

  Future<void> _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        onFilePicked(file);
      }
    } catch (e) {
      print("Error picking file: $e");
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final displaysize = MediaQuery.of(context).size;

    return Container(
      height: displaysize.height * 0.18, 
      padding: EdgeInsets.symmetric(
        horizontal: displaysize.width * .04,
        vertical: displaysize.height * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(displaysize.width * .04),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: displaysize.height * .01,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select a File",
              style: CustomTextStyler()
                  .styler(size: .024, color: neo_theme_blue3, type: 'M'),
            ),
            SizedBox(height: displaysize.height * .01),
            Center(
              child: ListTile(
                leading: Icon(Icons.attach_file, color: neo_theme_blue0),
                title: Text("Pick a File",
                    style: CustomTextStyler()
                        .styler(size: .018, color: neo_theme_blue3, type: 'M')),
                onTap: () => _pickFile(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
