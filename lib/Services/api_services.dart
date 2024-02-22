import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:testing_app/Services/request_type.dart';
import 'package:testing_app/Services/StatusCode.dart';

class HttpRequest {
  static String baseLink = 'fakestoreapi.com';
  static Map<String, String> headers = {'113': '21'};

  static Future get({
    required String path,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Map<String, dynamic>? queryParameters,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
    bool decodeResponse = true,
  }) async {
    Uri uri = Uri.https(baseUrl ?? baseLink, path, queryParameters);
    print(uri);
    // loading started
    if (onLoadChange != null) onLoadChange(true);

    // send the request
    Response response = await http.get(
      uri,
      headers: headers,
    );

    // check for response
    await checkStatusCode(response.statusCode);

    if (response.statusCode == StatusCode.OK) {
      if (onSuccess != null) {
        if (decodeResponse) {
          onSuccess(jsonDecode(response.body));
        } else {
          onSuccess(response.body);
        }
      }
    } else {
      if (onFailed != null) {
        onFailed(response.body);
      }
    }

    // loading stopped
    if (onLoadChange != null) onLoadChange(false);
  }

  static Future post({
    required String path,
    String? baseUrl,
    Function(bool isLoading)? onLoadChange,
    Function(dynamic reponse)? onSuccess,
    Function(String error)? onFailed,
    Map<String, dynamic>? queryParameters,
    bool decodeResponse = true,
    Map<String, dynamic>? body,
    Map<String, File>? files,
  }) async {
    // prepare uri
    Uri uri = Uri.https(baseUrl ?? baseLink, path, queryParameters);
    // loading started
    if (onLoadChange != null) onLoadChange(true);
    // sending request
    http.Response response;
    if (files != null) {
      response = await sendMultiPart(
        type: RequestType.POST,
        uri: uri,
        fields: body,
        files: files,
      );
    } else {
      response = await http.post(uri, headers: headers, body: body);
    }
    // global status check
    await checkStatusCode(response.statusCode);
    if (response.statusCode == StatusCode.OK) {
      if (onSuccess != null) {
        if (decodeResponse) {
          onSuccess(jsonDecode(response.body));
        } else {
          onSuccess(response.body);
        }
      }
    } else {
      if (onFailed != null) {
        onFailed(response.body);
      }
    }
    // loading stopped
    if (onLoadChange != null) onLoadChange(false);
  }

  static Future multipartRequest({
    required String path,
    String? baseUrl,
    Function(bool isLoading)? onLoadChange,
    Function(dynamic reponse)? onSuccess,
    Function(String error)? onFailed,
    bool decodeResponse = true,
    Map<String, dynamic>? fields,
    required File file,
  }) async {
    Uri uri = Uri.https(baseUrl ?? baseLink, path);
    if (onLoadChange != null) onLoadChange(true);
    Map<String, String> object = {};
    fields!.forEach((key, value) {
      object.addAll({key: value.toString()});
    });
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields.addAll(object);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    await checkStatusCode(response.statusCode);
    if (response.statusCode == StatusCode.OK) {
      if (onSuccess != null) {
        if (decodeResponse) {
          onSuccess(jsonDecode(response.body));
        } else {
          onSuccess(response.body);
        }
      }
    } else {
      if (onFailed != null) {
        onFailed(response.body);
      }
    }

    if (onLoadChange != null) onLoadChange(false);
  }

  static Future<Response> sendMultiPart({
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

  static checkStatusCode(int statusCode) {
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

//   Future makePostRequest(
//       {required Map<String, dynamic> body,
//       required Function onSuccess,
//       required Function onFailed}) async {
//     try {
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return onFailed();
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   Future makeGetRequest(
//       {required Function onSuccess,
//       required Function onFailed,
//       required dynamic responseFromJson}) async {
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//       );
//
//       if (response.statusCode == 200) {
//         onSuccess();
//         return responseFromJson(response.body);
//       } else {
//         return onFailed();
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
/*
 static Future post({
    required String path,
    required String body,
    String? baseUrl,
    Function(dynamic reponse)? onSuccess,
    Function(String error)? onFailed,
    Function(bool isLoading)? onLoadChange,
  }) async {
    Uri uri = Uri.https(baseUrl ?? baseLink, path);

    // loading started
    if (onLoadChange != null) onLoadChange(true);

    // send the request
    Response response = await http.post(uri, headers: headers, body: body);

    // check for response
    if (response.statusCode == StatusCode.UNAUTHORIZED) {
      //   logout
    } else if (response.statusCode == StatusCode.OK) {
      if (onSuccess != null) {
        onSuccess(response);
      }
    } else {
      if (onFailed != null) {
        onFailed(jsonDecode(response.body));
      }
    }

    print('end loading..');
    // loading stopped
    if (onLoadChange != null) onLoadChange(false);
  }

 */
}
