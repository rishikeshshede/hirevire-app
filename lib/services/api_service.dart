import 'dart:convert';
import 'dart:io';
import 'package:hirevire_app/constants/persistence_keys.dart';
import 'package:hirevire_app/utils/log_handler.dart';
import 'package:hirevire_app/utils/persistence_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiClient {
  // Live
  // static const String _baseUrl =
  //     'https://sea-turtle-app-cpepq.ondigitalocean.app/api/v1/';

  // Wifi
  static const String _baseUrl = 'http://192.168.29.243:5000/api/v1/';

  // Mobile hotspot
  // static const String _baseUrl = 'http://192.168.11.29:5000/api/v1/';

  static const Duration timeoutDuration = Duration(seconds: 30);

  ApiClient._();
  static ApiClient? _instance;

  factory ApiClient() {
    _instance ??= ApiClient._();
    return _instance!;
  }

  Future<String?> getToken() async {
    String? token =
        await PersistenceHandler.getString(PersistenceKeys.authToken);
    // LogHandler.debug("Token: $token");
    return token;
  }

  Map<String, String> setHeaders(String? authToken) {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": authToken ?? '',
    };
    return headers;
  }

  Future<dynamic> get(String endpoint) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    String? token = await getToken();
    Map<String, String> headers = setHeaders(token);

    LogHandler.info('GET: $url');
    try {
      final http.Response response = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(timeoutDuration);

      return handleResponse(url, response);
    } catch (error) {
      handleError(url, error);
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    String? token = await getToken();
    Map<String, String> headers = setHeaders(token);

    LogHandler.info('POST: $url');
    try {
      final http.Response response = await http
          .post(
            url,
            headers: headers,
            body: json.encode(body),
          )
          .timeout(timeoutDuration);

      return handleResponse(url, response);
    } catch (error) {
      handleError(url, error);
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    String? token = await getToken();
    Map<String, String> headers = setHeaders(token);

    try {
      LogHandler.info('PUT: $url');
      final http.Response response = await http
          .put(
            url,
            headers: headers,
            body: json.encode(body),
          )
          .timeout(timeoutDuration);

      return handleResponse(url, response);
    } catch (error) {
      handleError(url, error);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    String? token = await getToken();
    Map<String, String> headers = setHeaders(token);

    try {
      LogHandler.info('DELETE: $url');
      final http.Response response = await http
          .delete(
            url,
            headers: headers,
          )
          .timeout(timeoutDuration);

      return handleResponse(url, response);
    } catch (error) {
      handleError(url, error);
    }
  }

  static Map<String, dynamic> handleResponse(url, response) {
    final int statusCode = response.statusCode;
    final String responseBody = response.body;

    final dynamic body = jsonDecode(responseBody);
    if (statusCode == 200 || statusCode == 201) {
      return {
        'success': true,
        'statusCode': statusCode,
        'url': url,
        'body': body,
      };
    }
    LogHandler.error('ERROR $statusCode; ($url): $body');
    return {
      'success': false,
      'statusCode': statusCode,
      'url': url,
      'error': body,
    };
  }

  static Map<String, dynamic> handleError(url, error) {
    LogHandler.error('ERROR ($url): $error');
    return {
      'success': false,
      'statusCode': null,
      'url': url,
      'error': error.toString(),
    };
  }

  Future<Map<String, dynamic>> uploadVideoWithThumbnail(
      String endpoint, File videoFile, File thumbnailFile) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    var request = http.MultipartRequest('POST', url);

    LogHandler.info('Upload Video with Thumbnail: $url');
    try {
      // Adding the video file
      request.files.add(await http.MultipartFile.fromPath(
        'media',
        videoFile.path,
        contentType:
            MediaType.parse(lookupMimeType(videoFile.path) ?? 'video/mp4'),
      ));

      // Adding the thumbnail image
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnail',
        thumbnailFile.path,
        contentType:
            MediaType.parse(lookupMimeType(thumbnailFile.path) ?? 'image/jpeg'),
      ));

      var response = await request.send();
      var statusCode = response.statusCode;

      var responseString = await response.stream.bytesToString();
      var responseBody = jsonDecode(responseString);
      return {
        'success': true,
        'statusCode': statusCode,
        'url': url,
        'body': responseBody,
      };
    } catch (error) {
      handleError(url, error);
      return {
        'success': false,
        'error': error.toString(),
      };
    }
  }

  dynamic uploadImageOrVideo(String endpoint, File imageFile) async {
    final Uri url = Uri.parse(endpoint);
    var request = http.MultipartRequest('POST', url);

    LogHandler.info('Upload Image Or Video: $url');
    try {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType:
            MediaType.parse(lookupMimeType(imageFile.path) ?? 'image/jpeg'),
      ));
      var response = await request.send();
      var statusCode = response.statusCode;

      var responseString = await response.stream.bytesToString();
      var responseBody = jsonDecode(responseString);
      return {
        'success': true,
        'statusCode': statusCode,
        'url': url,
        'body': responseBody,
      };
    } catch (error) {
      handleError(url, error);
    }
  }

  dynamic uploadFile(String url, File file) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile('file', fileStream, length,
        filename: file.path.split('/').last);

    request.files.add(multipartFile);

    LogHandler.info('Upload File: $url');
    try {
      var response = await request.send();
      var statusCode = response.statusCode;

      var responseString = await response.stream.bytesToString();
      var responseBody = jsonDecode(responseString);
      return {
        'success': true,
        'statusCode': statusCode,
        'url': url,
        'body': responseBody,
      };
    } catch (error) {
      handleError(url, error);
    }
  }
}
