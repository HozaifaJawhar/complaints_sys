import 'dart:convert';
import 'package:complaints_sys/core/errors/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class Api {
  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      var errorData = jsonDecode(response.body);
      throw ServerException(errorData['message'] ?? 'حدث خطأ ما');
    }
  }

  Future<dynamic> post({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      final message = errorData['message'] ?? 'حدث خطأ غير معروف من السيرفر';
      throw ServerException(message);
    }
  }

  Future<dynamic> postMultipart({
    required String url,
    required Map<String, String> fields,
    required List<String> filePaths,
    required String filesKey, // "attachments"
    @required String? token,
    bool useIndex = true,
  }) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    if (token != null) {
      request.headers.addAll({'Authorization': 'Bearer $token'});
    }
    request.headers.addAll({'Accept': 'application/json'});

    request.fields.addAll(fields);

    for (int i = 0; i < filePaths.length; i++) {
      final path = filePaths[i];
      final extension = path.split('.').last.toLowerCase();

      MediaType? contentType;
      if (extension == 'pdf') {
        contentType = MediaType('application', 'pdf');
      } else if (['jpg', 'jpeg', 'png'].contains(extension)) {
        contentType =
            MediaType('image', extension == 'jpg' ? 'jpeg' : extension);
      }

      // Sanitize filename: remove spaces and special characters to avoid server issues
      final sanitizedFilename =
          basename(path).replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');

      var file = await http.MultipartFile.fromPath(
        useIndex
            ? '${filesKey}[$i]'
            : '${filesKey}[]', // Revert to indexed keys: attachments[0], attachments[1]
        path,
        filename: sanitizedFilename,
        contentType: contentType,
      );
      request.files.add(file);
    }

    print("DEBUG: Multipart Request Fields: ${request.fields}");
    print(
        "DEBUG: Multipart Request Files: ${request.files.map((f) => '${f.field}: ${f.filename}').toList()}");

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseData;
    } else {
      final message = responseData['message'] ?? 'حدث خطأ غير معروف من السيرفر';
      throw ServerException(message);
    }
  }

  Future<dynamic> put({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/json'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }
}
