
import 'package:brainswing/core/models/question.dart';
import 'package:brainswing/core/models/result.dart';
import 'package:brainswing/core/utils/question_utils.dart';
import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {

  Duration _duration;
  Duration get duration => _duration;

  bool _start = false;
  bool get start => _start;

  bool _finish = false;
  bool get finish => _finish;

  bool _change = false;

  Question _question;
  Question get question => _question;

  Result _result;
  Result get result => _result;

  //Inisialisasi dan reset data
  void setStart() {
    _start = true;
    _result = new Result();
    _question = new Question();
    _duration = new Duration();
    notifyListeners();
  }

  /*
  * Menjalankan timer, menginisialisasi variable
  * dan generate pertanyaan
  */
  void startTimer() {
    setStart();
    generate();

    CountDown cd = CountDown(Duration(seconds : 60));
    var sub = cd.stream.listen((Duration d) {
      //
    });

    // Countdown listener
    sub.onData((Duration d) async {

      // Saat timer berjalan setiap 5 detik
      // akan otomatis generate soal baru
      // jika belum terjawab dan wrong + 1
      if (d.inSeconds % 5 == 0) {
        _change = true;
        generate();
      } else {
        if (_change == true) {
          _change = false;
          _result.wrong += 1;
        }
      }
      
      _duration = d;
      notifyListeners();
    });

    // Ketika countdown telah selesai
    sub.onDone(() {
      _finish = true;
      notifyListeners();
    });

    notifyListeners();
  }

  //Generate pertanyaan
  void generate() async {
    _question= QuestionUtils.generate();
    notifyListeners();
  }

  /* 
  * Mengulang kembali permainan
  */
  void replay() {
    _finish = false;
    _start = false;

    startTimer();
    notifyListeners();
  }

  //Ketika seseorang submit jawaban
  void submit(int answ) {
    //Membandingkan jika
    //jawaban benar
    if (answ == _question.answer) {
      _result.correct += 1;
    } else {
      _result.wrong += 1;
    }

    //Generate soal ulang
    generate();
    notifyListeners();
  }
}