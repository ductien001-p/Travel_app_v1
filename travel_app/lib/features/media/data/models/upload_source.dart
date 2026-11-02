import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class UploadSource {
  const UploadSource({
    required this.file,
    required this.mimeType,
    required this.size,
  });

  final XFile file;

  final String mimeType;

  final int size;

  String get fileName {
    return file.name;
  }

  static Future<UploadSource> fromXFile(XFile file) async {
    final size = await file.length();

    final mimeType = file.mimeType ?? lookupMimeType(file.name);

    if (mimeType == null || mimeType.isEmpty) {
      throw UnsupportedError('Cannot determine MIME type for ${file.name}.');
    }

    if (size <= 0) {
      throw StateError('File ${file.name} is empty.');
    }

    return UploadSource(file: file, mimeType: mimeType, size: size);
  }
}
