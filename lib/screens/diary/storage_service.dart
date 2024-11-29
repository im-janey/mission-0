// import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class StorageService {
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(Uint8List imageData, String fileName) async {
    try {
      // Firebase 관련 코드를 주석 처리하고 대신 시뮬레이션 코드 추가
      print('Simulating image upload...');
      print('File name: $fileName');
      print('Image data length: ${imageData.length} bytes');

      // 시뮬레이션으로 반환할 URL
      return 'https://example.com/simulated_image/$fileName';
    } catch (e) {
      print('Simulated image upload failed: $e');
      throw e;
    }
  }
}
