import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:testing_app/Services/request_type.dart';
import 'package:testing_app/Services/StatusCode.dart';

class ExtraRequest {
  static String baseLink = 'fakestoreapi.com';
  static Map<String, String> headers = {'113': '21'};

  static get({
    required String path,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Map<String, dynamic>? queryParameters,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
    bool decodeResponse = true,
  }) =>
      _handle(
        type: RequestType.GET,
        path: path,
        baseUrl: baseUrl,
        onSuccess: onSuccess,
        queryParameters: queryParameters,
        onFailed: onFailed,
        onLoadChange: onLoadChange,
        decodeResponse: decodeResponse,
      );

  static post({
    required String path,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Map<String, dynamic>? queryParameters,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
    bool decodeResponse = true,
    Map<String, dynamic>? data,
    Map<String, File>? files,
    bool isMultiPart = false,
  }) =>
      _handle(
        type: RequestType.POST,
        path: path,
        baseUrl: baseUrl,
        onSuccess: onSuccess,
        queryParameters: queryParameters,
        onFailed: onFailed,
        onLoadChange: onLoadChange,
        decodeResponse: decodeResponse,
        data: data,
        files: files,
        isMultiPart: isMultiPart,
      );

  static put({
    required String path,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Map<String, dynamic>? queryParameters,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
    bool decodeResponse = true,
    Map<String, dynamic>? data,
    Map<String, File>? files,
    bool isMultiPart = false,
  }) =>
      _handle(
        type: RequestType.PUT,
        path: path,
        baseUrl: baseUrl,
        onSuccess: onSuccess,
        queryParameters: queryParameters,
        onFailed: onFailed,
        onLoadChange: onLoadChange,
        decodeResponse: decodeResponse,
        data: data,
        files: files,
        isMultiPart: isMultiPart,
      );

  static delete({
    required String path,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Map<String, dynamic>? queryParameters,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
    bool decodeResponse = true,
  }) =>
      _handle(
        type: RequestType.DELETE,
        path: path,
        baseUrl: baseUrl,
        onSuccess: onSuccess,
        queryParameters: queryParameters,
        onFailed: onFailed,
        onLoadChange: onLoadChange,
        decodeResponse: decodeResponse,
      );

  static _handle({
    required String type,
    required String path,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Map<String, dynamic>? queryParameters,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
    bool decodeResponse = true,
    Map<String, dynamic>? data,
    Map<String, File>? files,
    bool isMultiPart = false,
  }) async {
    // prepare uri
    Uri uri = Uri.https(baseUrl ?? baseLink, path, queryParameters);

    // loading started
    if (onLoadChange != null) onLoadChange(true);

    // sending request
    http.Response response = await _sendRequest(
      type: type,
      uri: uri,
      data: data,
      files: files,
      isMultiPart: isMultiPart,
    );

    // check for response
    await _checkStatusCode(response.statusCode);

    if (response.statusCode == StatusCode.OK && onSuccess != null) {
      decodeResponse
          ? onSuccess(jsonDecode(response.body))
          : onSuccess(response.body);
    } else {
      if (onFailed != null) {
        onFailed(response.body);
      }
    }

    // loading stopped
    if (onLoadChange != null) onLoadChange(false);
  }

  static Future<Response> _sendRequest({
    required String type,
    required Uri uri,
    Map<String, dynamic>? data,
    Map<String, File>? files,
    bool isMultiPart = false,
  }) async {
    if (files != null) isMultiPart = true;

    switch (type) {
      case RequestType.POST:
        if (isMultiPart) {
          return await _sendMultiPart(
            type: RequestType.POST,
            uri: uri,
            fields: data,
            files: files,
          );
        } else {
          return await http.post(uri, headers: headers, body: data);
        }
      case RequestType.PUT:
        if (isMultiPart) {
          return await _sendMultiPart(
            type: RequestType.PUT,
            uri: uri,
            fields: data,
            files: files,
          );
        } else {
          return await http.put(uri, headers: headers, body: data);
        }
      case RequestType.DELETE:
        return await http.delete(uri, headers: headers);
      default:
        return await http.get(uri, headers: headers);
    }
  }

  static _checkStatusCode(int statusCode) {
    if (statusCode == StatusCode.UNAUTHORIZED) {
      //   logout
    } else if (statusCode == StatusCode.NOT_FOUND) {
      //page not found
    } else if (statusCode == StatusCode.FORBIDDEN) {
      //show dialog don't have access
    } else if (statusCode == StatusCode.MAINTENANCECODE) {
      //on app update
    } else {}
  }

  static Future<Response> _sendMultiPart({
    required Uri uri,
    required String type,
    Map<String, dynamic>? fields,
    Map<String, File>? files,
  }) async {
    // init request
    http.MultipartRequest request = http.MultipartRequest(type, uri);
    // add headers to request
    request.headers.addAll(headers);
    // add fields to request
    if (fields != null) {
      Map<String, String> data = {};
      fields.forEach((key, value) {
        data.addAll({key: value.toString()});
      });
      request.fields.addAll(data);
    }
    // add files to request
    if (files != null) {
      files.forEach((key, file) async {
        request.files.add(await http.MultipartFile.fromPath(key, file.path));
      });
    }
    // send request
    final responseStream = await request.send();
    return await http.Response.fromStream(responseStream);
  }
}
