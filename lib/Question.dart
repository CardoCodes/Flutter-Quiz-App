import 'dart:io';

class Question {
  var _answer;
  var _userAnswer;
  var _stem;

  dynamic get stem => _stem;
  set stem(value) {
    _stem = value;
  }

  get answer => _answer;
  set answer(value) {
    _answer = value;
  }

  get userAnswer => _userAnswer;
  set userAnswer(value) {
    _userAnswer = value;
  }


  bool isCorrect() {
    return answer == userAnswer;
  }

  String? promptUserAnswer(){
    print(_stem);
    var userIn = stdin.readLineSync();
    return userIn;
  }
}

class MultipleChoiceQuestion extends Question{
  var _options = [];

  MultipleChoiceQuestion(this._options);
  List get options => _options;

  set options(value) {
    _options = value;
  }

  void displayOptions(){
    for(var i = 0; i < options.length; i++){
      print(options[i].toString());
    }
  }

  @override
  String? promptUserAnswer(){
    stdout.write(stem);
    displayOptions();
    stdout.write('Enter answer: ');
    var userIn = stdin.readLineSync();
    return userIn;
  }
}

class FillInTheBlankQuestion extends Question {

  @override
  bool isCorrect() {
    //get rid of [] in the answer
    var answer = userAnswer.replaceAll('[', '');
    answer = answer.replaceAll(']', '');
    List answerList = answer.split(',');

    for (var i = 0; i < answerList.length; i++) {
      if (answerList[i].toLowerCase() ==
          userAnswer.toString().toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}

