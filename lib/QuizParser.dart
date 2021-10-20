
import '../Question.dart';

class QuizParser {
  ///generates a pre-built quiz using response from getJsonQuiz.
  Future generateQuiz(response) async {
    var questionList = [];
    var quizLength = response['quiz']['question'].length;


    for (var i = 0; i < quizLength; i++) {
      var type = response['quiz']['question'][i]['type'];
      dynamic question;
      if (type == 1) {
        question =
            MultipleChoiceQuestion(response['quiz']['question'][i]['option']);
        question.stem = (response['quiz']['question'][i]['stem']);
        question.answer =
        (response['quiz']['question'][i]['answer'].toString());
        questionList.add(question);
      } else {
        question =
            FillInTheBlankQuestion();
        question.stem = (response['quiz']['question'][i]['stem']);
        question.answer =
        (response['quiz']['question'][i]['answer'].toString());
        questionList.add(question);
      }
    }
    return (questionList);
  }


  ///generates a random quiz of quizSize using response from getJsonAllQuiz().
  Future generatePracticeQuiz(response, quizSize) async {
    var questionList = [];
    var randomPicker = [];

    ///generate a list with 1-50 with random order.
    randomPicker = List<int>.generate(50, (j) => j + 1)
      ..shuffle();

    ///create List with questions.
    for (var i = 0; i < quizSize; i++) {
      var randomItem = (randomPicker.toList()
        ..shuffle()).first;
      var type = response[randomItem]['type'];
      dynamic question;

      ///check and assign type MCQ or FITB.
      if (type == 1) {
        question =
            MultipleChoiceQuestion(response[randomItem]['option']);
        question.stem = (response[randomItem]['stem']);
        question.answer =
        (response[randomItem]['answer'].toString());
        questionList.add(question);
      } else {
        question =
            FillInTheBlankQuestion();
        question.stem = (response[randomItem]['stem']);
        question.answer =
        (response[randomItem]['answer'].toString());
        questionList.add(question);
      }
    }
    return(questionList);
  }
}

