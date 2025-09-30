import 'package:dio/dio.dart';
import 'package:pokemon/data/model/login_response.dart';

class AuthenticationService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl:
          'https://photo-sharing-api-bootcamp.do.dibimbing.id', // Replace with your API base URL
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'apikey':
            'c7b411cc-0e7c-4ad1-aa3f-822b00e7734b', // Replace with your actual API key
      },
    ),
  );

  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/api/v1/login',
        data: {'username': username, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> register(String email, String userName, String password) async {}
}
