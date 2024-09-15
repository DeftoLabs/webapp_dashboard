import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:web_dashboard/services/local_storage.dart';



class CafeApi {

  static final Dio _dio = Dio();

  static void configureDio() {

    // URL Base
    // _dio.options.baseUrl = 'http://localhost:8080/api';
     _dio.options.baseUrl = 'https://bozz-test-backend-55b9e4133740.herokuapp.com/api';
    

    // Header Config
    _dio.options.headers = {
    'x-token': LocalStorage.prefs.getString('token') ?? ''
    };

  }

  

  // HTTP Get
  static Future httpGet ( String path) async {
    try {

      final resp = await _dio.get(path);
      return resp.data;
      
    } catch (e) {
      throw('Error in the GET HTTP');
      
    }
  }

    static Future post ( String path, Map<String, dynamic> data ) async {

      final formData = FormData.fromMap(data);

    try {

      final resp = await _dio.post(path, data: formData);
      return resp.data;
      
    } catch (e) {
      throw('Error in the POST');
      
    }
  }

    static Future put ( String path, Map<String, dynamic> data ) async {

      final formData = FormData.fromMap(data);

    try {

      final resp = await _dio.put(path, data: formData);
      return resp.data;
      
    }  catch (e) {
      throw('Error in the PUT');
      
    }
  }

  static Future putJson(String path, Map<String, dynamic> data) async {
  try {
    // Enviar los datos como JSON, sin usar FormData
    final resp = await _dio.put(
      path,
      data: data, // Enviar el map directamente
      options: Options(
        headers: {
          'Content-Type': 'application/json', // Especifica que estás enviando JSON
        },
      ),
    );
    
    return resp.data; // Retorna los datos de la respuesta
  } catch (e) {
    throw('Error in the PUT');
  }
}

   static Future delete ( String path, Map<String, dynamic> data ) async {

      final formData = FormData.fromMap(data);

    try {

      final resp = await _dio.delete(path, data: formData);
      return resp.data;
      
    } catch (e) {
      throw('Error in the DELETE');
      
    }
  }

      static Future uploadFile ( String path, Uint8List bytes ) async {

      final formData = FormData.fromMap({
        'archivo': MultipartFile.fromBytes(bytes)
      });

    try {

      final resp = await _dio.put(
        path, 
        data: formData
        );
      return resp.data;
      
    }  catch (e) {
      throw('Error in the PUT Image');
      
    }
  }

  static Future<void> validateEmailBackend(String email) async {
    try {
      final response = await _dio.post('/validate-email', data: {'email': email});
      if (response.statusCode != 200) {
        final responseData = response.data;
        throw Exception(responseData['message'] ?? 'Error validating email');
      }
    } catch (e) {
      throw Exception('Error validating email: $e');
    }
  }

// Error del Product Provider


static Future<Map<String, dynamic>> uploadImage(String path, Uint8List bytes) async {
  final formData = FormData.fromMap({
    'archivo': MultipartFile.fromBytes(bytes)
  });

  try {
    final resp = await _dio.put(path, data: formData);
    if (resp.statusCode == 200) {
      return resp.data is Map<String, dynamic> 
        ? resp.data as Map<String, dynamic> 
        : json.decode(resp.data);
    }else {
      throw Exception('Failed to upload image: ${resp.statusCode}');
    } 
  } catch (e) {
    throw Exception('Error in the PUT image: $e');
  }
}

}
