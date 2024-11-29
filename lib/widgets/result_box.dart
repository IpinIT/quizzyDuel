import 'package:flutter/material.dart';
import '../constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  }) : super(key: key);

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: neutral, fontSize: 30.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              child: Text(
                '$result/$questionLength',
                style: const TextStyle(fontSize: 30.0,),
              ),
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow //when the result is half of the questions
                  : result < questionLength / 2
                      ? incorrect //when the result is less than half
                      : correct, //when the result is more than half
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              result == questionLength / 2
                  ? 'leh uga' //when the result is half of the questions
                  : result < questionLength / 2
                      ? 'Noob!' //when the result is less than half
                      : 'KEREN..', //when the result is more than half
              style: const TextStyle(color: neutral, fontSize: 20.0),
            ),
            const SizedBox(
              height: 25.0,
            ),
            GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar belakang putih
                  borderRadius: BorderRadius.circular(10.0), // Sudut membulat
                ),
                child: const Text(
                  'Main Lagi!',
                  style: TextStyle(
                    color: background, // Warna teks biru
                    fontSize: 20.0,
                     fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
