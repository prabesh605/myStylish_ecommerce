import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageService {
  final String cloudName = 'dndihenwf';
  final String uploadPreset = 'stylish';
  final ImagePicker picker = ImagePicker();
  File? image;
  Future<File?> pickImageFromGallery() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      image = File(picked.path);
      // print(image);
      return image;
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      image = File(picked.path);
      print(image);
      // return image;
    }
    return null;
  }

  Future<String> uploadImage(File? file) async {
    try {
      final String url =
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', file!.path));
      var response = await request.send();
      var res = await http.Response.fromStream(response);
      var data = jsonDecode(res.body);
      final String imageUrl = data['secure_url'];
      return imageUrl;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
