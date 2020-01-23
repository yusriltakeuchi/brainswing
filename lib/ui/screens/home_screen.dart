import 'package:brainswing/core/utils/question_utils.dart';
import 'package:brainswing/core/viewmodels/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brainswing"),
        centerTitle: true,
        leading: Icon(Icons.all_inclusive),
      ),
      body: SingleChildScrollView(
        child: HomeBody(),
      )
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  var answerController = TextEditingController();
  void submitData() {

    final questionProv = Provider.of<QuestionProvider>(context);
    if (questionProv.finish == false && questionProv.start == true) {
      questionProv.submit(int.parse(answerController.text));
      answerController.text = "";
    } else if (questionProv.start == false) {
      questionProv.startTimer();
    } else {
      questionProv.replay();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<QuestionProvider>(
      builder: (context, questionProv, _) {

        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              
              questionProv.finish == true ? Column(
                children: <Widget>[
                  Text(
                    "HASIL AKHIR",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "BENAR ${questionProv.result.correct.toString()} | SALAH ${questionProv.result.wrong.toString()}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                ],
              ) : SizedBox(),

              questionProv.start == true ? Text(
                "${QuestionUtils.twoDigits(questionProv.duration.inMinutes.remainder(60))}:${QuestionUtils.twoDigits(questionProv.duration.inSeconds.remainder(60))}",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ) : SizedBox(),

              questionProv.start == true ? Divider(color: Colors.black87.withOpacity(0.4)) : SizedBox(),
              SizedBox(height: questionProv.finish == false ? 20 : 0),

              questionProv.finish == false && questionProv.start == true ? Text(
                "${questionProv.question.firstNumber.toString()} ${questionProv.question.operators} ${questionProv.question.secondNumber.toString()} = ?",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ) : SizedBox(),

              SizedBox(height: questionProv.finish == false && questionProv.start == true ? 20 : 0),
              questionProv.finish == false && questionProv.start == true ? TextField(
                controller: answerController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black87
                ),
                onSubmitted: (String value) => submitData(),
                decoration: InputDecoration(
                  hintText: "Masukkan jawaban",
                  hintStyle: TextStyle(
                    color: Colors.black54
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)
                  ),
                ),
              ) : SizedBox(),

              SizedBox(height: questionProv.finish == false && questionProv.start == true ? 20 : 0),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: RaisedButton(
                  onPressed: () => submitData(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                  ),
                  color: Colors.blue,
                  child: Text(
                    questionProv.finish == false && questionProv.start == true ? "KIRIM JAWABAN" : "MULAI PERMAINAN",
                    style: TextStyle(
                      color: Colors.white
                    )
                  )
                )
              )
            ],
          )
        );
      },
    );
  }
}