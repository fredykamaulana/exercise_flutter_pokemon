import 'package:dio/dio.dart';
import 'package:mime_type/mime_type.dart';
import 'package:pokemon/data/model/upload_image_response.dart';

class UploadImageService {
  Future<UploadImageResponse> uploadImage(String imageFilePath) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://example.com', // Replace with your API base URL
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          //'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'apikey': 'your_api_key', // Replace with your actual API key
          'Authorization':
              'Bearer your_api_token', // Replace with your actual token,
        },
      ),
    );

    String fileName = imageFilePath.split('/').last;

    // Optional: Get mime type for better content type setting
    String? mimeType = mime(fileName);
    String mimee = mimeType?.split('/')[0] ?? 'image';
    String type = mimeType?.split('/')[1] ?? 'jpeg';

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        imageFilePath,
        filename: fileName,
        contentType: DioMediaType(mimee, type), // Optional, but good practice
      ),
      // Add other form fields if necessary
      //"description": "User uploaded image",
    });

    try {
      Response response = await dio.post(
        '/api/v1/upload-image', // Replace with your actual API endpoint
        data: formData,
        onSendProgress: (int sent, int total) {
          // Optional: Track upload progress
          print('Upload progress: ${(sent / total * 100).toStringAsFixed(0)}%');
        },
      );

      print("Upload successful: ${response.data}");

      return UploadImageResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("Upload failed: ${e.message}");

      throw Exception('Failed to upload image: ${e.message}');
    }
  }
}
