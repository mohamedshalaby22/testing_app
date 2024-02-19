import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:testing_app/Services/storage.dart';
import 'Test/animation_page.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: AnimationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = [];
  bool isLoaded = false;
  void getData() async {
    setState(() {
      isLoaded = false;
    });
    data = await fetchDataFromApi();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    // getData();
    SecureStorage.readSecureName();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                color: Colors.cyan,
                size: 80,
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Input Your  Name'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  SecureStorage.writeSecureName(nameController.text);
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Save Name',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  SecureStorage.readSecureName();
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Show Name',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Text(
                SecureStorage.myName,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.cyan,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: fetchDataFromApi,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// Future fetchDataFromApi() async {
//   const apiUrl = 'https://fakestoreapi.com/products';
//   try {
//     final response = await http.get(Uri.parse(apiUrl));
//
//     switch (response.response.statusCode) {
//       case 200:
//         final result = jsonDecode(response.body);
//         return result;
//       case 404:
//         final result = jsonDecode(response.body);
//         print(' :Request Error');
//         return '$result :Request Error';
//       case 500:
//       case 501:
//       case 502:
//         print(':Server Error');
//         final result = jsonDecode(response.body);
//         return '$result :Server Error';
//       default:
//         final result = jsonDecode(response.body);
//         return '$result :Server Error';
//     }
//   } on SocketException {
//     print(' No Connection');
//     return 'No Connection';
//   } on FormatException {
//     print('Bad Request Error');
//     return 'Bad Request Error';
//   } on HttpException {
//     print('Server not responding');
//     return 'Server not responding';
//   } on TimeoutException catch (e) {
//     print("message:" "Connection timeout");
//   } catch (e) {
//     print('Error: ${e.toString()}');
//   }
// }
String message = '';
Future fetchDataFromApi() async {
  const apiUrl = 'https://fakestoreapi.com/products';

  final dio = Dio();
  try {
    final response = await dio.get(apiUrl);
    if (response.statusCode! >= 100 && response.statusCode! < 200) {
      message =
          'This is an informational response - the request was received, continuing processing';
      print(message);
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      message =
          'The request was successfully received, understood, and accepted';
      print(message);
      return response.data;
    } else if (response.statusCode! >= 300 && response.statusCode! < 400) {
      message =
          'Redirection: further action needs to be taken in order to complete the request';
      print(message);
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      message =
          'Client error - the request contains bad syntax or cannot be fulfilled';
      print(message);
    } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
      message =
          'Server error - the server failed to fulfil an apparently valid request';
      print(message);
    } else {
      message =
          'A response with a status code that is not within the range of inclusive 100 to exclusive 600'
          'is a non-standard response, possibly due to the server\'s software';
      print(message);
    }
  } on DioException catch (error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        print(error.type);
        return 'connection timeout';
      case DioExceptionType.sendTimeout:
        print(error.type);

        return 'send timeout';
      case DioExceptionType.receiveTimeout:
        print(error.type);

        return 'receive timeout';
      case DioExceptionType.badCertificate:
        print(error.type);

        return 'bad certificate';
      case DioExceptionType.badResponse:
        print(error.type);

        return 'bad response';
      case DioExceptionType.cancel:
        print(error.type);

        return 'request cancelled';
      case DioExceptionType.connectionError:
        print(error.type);

        return 'connection error';
      case DioExceptionType.unknown:
        print(error.type);

        return 'unknown';
    }
  }
}
/*

 */
