import 'package:dio/dio.dart';
import 'package:mime_type/mime_type.dart';
import 'package:pokemon/data/model/post_response.dart';
import 'package:pokemon/data/model/upload_image_response.dart';

class UploadImageService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl:
          'https://photo-sharing-api-bootcamp.do.dibimbing.id', // Replace with your API base URL
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        //'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'apikey':
            'c7b411cc-0e7c-4ad1-aa3f-822b00e7734b', // Replace with your actual API key
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pZnRhaGZhcmhhbjJAZ21haWwuY29tIiwidXNlcklkIjoiMDQ3YWNhMzgtODc2Zi00ZWQwLWIwZDItYjAzM2JkYWM2YjhkIiwicm9sZSI6ImdlbmVyYWwiLCJpYXQiOjE3NTkyMTY0OTN9.AVDwZY7XSTh6JBUDXMVQKSKZM8pN_ufRjtwcxLBqtYI', // Replace with your actual token,
      },
    ),
  );

  Future<UploadImageResponse> uploadImage(String imageFilePath) async {
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

  Future<PostResponse> fetchPost() async {
    try {
      Response response = await dio.get(
        //'/api/v1/users-post/a54c59e7-a1b6-4ac4-ae7b-9885a98ed869?size=10&page=1',
        '/api/v1/explore-post?size=10&page=1',
        // Replace with your actual API endpoint
      );

      print('${response.data}');

      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("Get Data failed: ${e.message}");

      throw Exception('Failed to upload image: ${e.message}');
    }
  }
}
