import 'package:dio/dio.dart';
import 'package:web_dashboard/services/local_storage.dart';



class CafeApi {

  static Dio _dio = Dio();

  static void configureDio() {

    // URL Base
    _dio.options.baseUrl = 'http://localhost:8080/api';

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

}