import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:http/http.dart' as http;

const _cloudName = 'dz2axybcz';
const _uploadPreset = 'rms_dental_unsigned';

/// Uploads [file] to Cloudinary and returns the secure URL.
/// Throws on network error or non-200 response.
Future<String> uploadToCloudinary(File file, {String? folder}) async {
  final uri = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');
  final request = http.MultipartRequest('POST', uri)
    ..fields['upload_preset'] = _uploadPreset
    ..fields['folder'] = folder ?? 'rms_dental'
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  dev.log('Uploading to Cloudinary: ${file.path} → folder=${folder ?? "rms_dental"}', name: 'Cloudinary');

  final streamed = await request.send();
  final body = await streamed.stream.bytesToString();

  if (streamed.statusCode != 200) {
    final errMsg = (jsonDecode(body)['error']?['message'] as String?) ?? body;
    dev.log('Cloudinary upload failed [${streamed.statusCode}]: $errMsg', name: 'Cloudinary', level: 1000);
    throw Exception('Image upload failed: $errMsg');
  }

  final url = (jsonDecode(body)['secure_url'] as String);
  dev.log('Cloudinary upload success: $url', name: 'Cloudinary');
  return url;
}
