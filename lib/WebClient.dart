import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class  WebClient{

  Future getJsonQuizLogin( String username, String password) async {
    //set up log in url with username and password variables
    var urlMain = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=$username&pin=$password';
    var body = '{"user": "$username", "pin": "$password"}';
    print(body);

    //check for response from URl using password and username
      try {
        var response = await http.post(Uri.parse(urlMain), body: body);
        print("response is $response");
        var jsonD = jsonDecode(response.body);
        print(jsonD);

        //if the response is a response return the json response
        if (jsonD["response"] == true) {
          print(jsonD['response']);
          return jsonD['response'];
        }
        else{
          return null;
        }
      }
      catch (e) {
        print(e.toString());
      }

    print("Error: Couldn't get info from server");
    return null;
  }

  Future getJsonQuiz(int numQuiz) async {
    final response = await http
        .get(Uri.parse(
        'http://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=quiz0${numQuiz}'));
    Map mapDecode = json.decode(response.body);
    //check for response
    if (mapDecode['response'] == true) {
      return mapDecode;
    } else {
      return null;
    }
  }

}