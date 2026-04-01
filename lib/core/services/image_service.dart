import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final _imagePicker = ImagePicker();

  static Future<String?> pickImage() async {
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    return picked?.path;
  }

  static Future<String?> cropImage(
    String sourcePath, {
    required CropAspectRatio aspectRatio,
    required CropStyle cropStyle,
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      final cropped = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatio: aspectRatio,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        compressQuality: 85,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            statusBarLight: false,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: Colors.black,
            dimmedLayerColor: Colors.black54,
            lockAspectRatio: true,
            hideBottomControls: false,
            cropStyle: cropStyle,
          ),
        ],
      );
      return cropped?.path;
    } catch (e) {
      debugPrint('Crop error: $e');
      return null;
    }
  }
}
