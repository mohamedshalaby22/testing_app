import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:testing_app/Services/extra_request.dart';
import 'package:testing_app/Services/api_services.dart';
import 'Model/product_model.dart';

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
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Product> products = [];
  bool isLoaded = false;

  void getData() async {
    await ExtraRequest.get(
      path: '/products',
      onSuccess: (response) {
        products = allProductsFromJson(response);
      },
      onLoadChange: (isLoading) {
        isLoaded = !isLoading;
        setState(() {});
      },
    );
  }

  late final AnimationController _controller;

  @override
  void initState() {
    getData();
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie.network(
              //     'https://lottie.host/4da99558-2be8-418a-b3b8-4dacf0a7f11f/LddFXtDhJB.json'),
              Lottie.asset('assets/images/success.json',
                  repeat: false, controller: _controller),
              // Lottie.asset('assets/images/image404.json'),
              // Expanded(
              //   child: Center(
              //     child: Visibility(
              //         visible: isLoaded,
              //         replacement: const CupertinoActivityIndicator(
              //           radius: 13,
              //         ),
              //         child: ListView.builder(
              //             itemCount: products.length,
              //             itemBuilder: (context, index) {
              //               return ProductItem(product: products[index]);
              //             })),
              //   ),
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.reset();
          _controller
            ..duration = const Duration(milliseconds: 1500)
            ..forward();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.image,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${product.price} USD',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          )
        ],
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
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      message =
          'The request was successfully received, understood, and accepted';
      return response.data;
    } else if (response.statusCode! >= 300 && response.statusCode! < 400) {
      message =
          'Redirection: further action needs to be taken in order to complete the request';
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      message =
          'Client error - the request contains bad syntax or cannot be fulfilled';
    } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
      message =
          'Server error - the server failed to fulfil an apparently valid request';
    } else {
      message =
          'A response with a status code that is not within the range of inclusive 100 to exclusive 600'
          'is a non-standard response, possibly due to the server\'s software';
    }
  } on DioException catch (error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'connection timeout';
      case DioExceptionType.sendTimeout:
        return 'send timeout';
      case DioExceptionType.receiveTimeout:
        return 'receive timeout';
      case DioExceptionType.badCertificate:
        return 'bad certificate';
      case DioExceptionType.badResponse:
        return 'bad response';
      case DioExceptionType.cancel:
        return 'request cancelled';
      case DioExceptionType.connectionError:
        return 'connection error';
      case DioExceptionType.unknown:
        return 'unknown';
    }
  }
}
/*

 */
