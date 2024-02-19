import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class TestEncryptedPage extends StatefulWidget {
  const TestEncryptedPage({Key? key}) : super(key: key);

  @override
  State<TestEncryptedPage> createState() => _TestEncryptedPageState();
}

class _TestEncryptedPageState extends State<TestEncryptedPage> {
  TextEditingController textController = TextEditingController();
  String encryptedText = '';
  String decryptedText = '';
  var encrypted;
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 0.5,
                  color: Colors.black,
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    cursorColor: Colors.grey[500]!,
                    controller: textController,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey[500]!,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Encrypt Text'),
                  ),
                ),
              ),
              Visibility(
                visible: encryptedText.isNotEmpty,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      encryptedText,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: decryptedText.isNotEmpty,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      decryptedText,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    encrypted = encrypter.encrypt(textController.text, iv: iv);
                    encryptedText = encrypted.base64;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 56,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                    child: Text(
                      'Encrypt Text',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    decryptedText = encrypter.decrypt(encrypted, iv: iv);
                  });
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                    child: Text(
                      'Decrypt Text',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
