import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:image_picker/image_picker.dart'; // For Mobile
import 'package:file_picker/file_picker.dart'; // For Desktop/Web

class FileUploadUtility {
  /// Picks an image from the appropriate source depending on the platform.
  /// Returns a `File` if successful, otherwise null.
  static Future<File?> pickImage() async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Desktop/Web: Use file_picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    } else {
      // Mobile: Use image_picker
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return File(image.path);
      }
    }
    return null;
  }
}
