import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecurityFilePage extends StatefulWidget {
  const SecurityFilePage({Key? key}) : super(key: key);

  @override
  State<SecurityFilePage> createState() => _SecurityFilePageState();
}

class _SecurityFilePageState extends State<SecurityFilePage> {
  final String? appName = dotenv.env['APP_NAME'];
  final String? secretKey = dotenv.env['APP_Secret_key'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Name: $appName',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Secret Key: $secretKey',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
