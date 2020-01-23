
import 'dart:math';

import 'package:brainswing/core/models/question.dart';

class QuestionUtils {

  /*
  * Bagian ini berfungsi untuk generate random number
  * kemudian membentuk menjadi sebuah pertanyaan random
  * dan operator random
  */
  static Question generate() {
    Random rnd = new Random();
    int firstNumber = rnd.nextInt(10);
    int secondNumber = rnd.nextInt(10);
    int _operators = rnd.nextInt(2);

    int answer = 0;
    String operators = "";

    //Generate random operator
    switch(_operators) {
      case 0:
        answer = firstNumber + secondNumber;
        operators = "+";
        break;
      case 1:
        answer = firstNumber - secondNumber;
        operators = "-";
        break;
    }

    return Question(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      operators: operators,
      answer: answer
    );
  }

  /*
  * Mengkonversi bilangan angka yang 
  * hanya punya 1 digit menjadi 2 digit.
  * misalnya 5 menjadi 05
  */
  static String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}