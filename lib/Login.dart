import 'package:flutter/material.dart';
import '../WebClient.dart';
import '../QuizParser.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

//create a class for log in data
class LoginData {
  String username = "";
  String password = "";
}
//call web client to sign in using LoginData
Future<bool> signIn(String username, String password) async {
  var webClient = WebClient();
  var response =  await webClient.getJsonQuizLogin(username, password);
  if(response != null){
    return true;
  }
  return false;
}




//sign in screen
class _LoginPageState extends State<LoginPage> {

  LoginData _loginData = new LoginData();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(home: Scaffold(
        body: Container(
            padding: EdgeInsets.all(50.0),
            child: Form(
                key: this._formKey,
                child: Column(
                    children: [
                      //TextFormField for log in information
                      TextFormField(
                          keyboardType:
                          TextInputType.emailAddress,
                          validator: (inValue) {
                            if (inValue!.length == 0) {
                              return "Please enter username";
                            }
                            return null;
                          },
                          onSaved: (inValue) {
                            this._loginData.username = inValue!;
                          },
                          decoration: InputDecoration(
                              labelText: "Username"
                          )
                      ),
                      TextFormField(
                          obscureText: true,
                          validator: (inValue) {
                            if (inValue!.length < 3) {
                              return "Length of password has to be 4";
                            }
                            return null;
                          },
                          onSaved: (inValue) {
                            this._loginData.password = inValue!;
                          },
                          decoration: InputDecoration(
                              labelText: "Password"
                          )
                      ),
                      //Log in button sends in data
                      ElevatedButton(
                          child: Text("Log In!"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var response = signIn(
                                  _loginData.username, _loginData.password)
                                  .then((onValue) {
                              });
                            }
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));

                          }
                      )
                    ]

                )
            )
        )
    ));
  }
}

quizInfo() async {
  var quizMaker = QuizParser();
  var response = WebClient().getJsonQuiz(1);
  var quiz = quizMaker.generateQuiz(response);
  return quiz;
}

//seconds screen, table
class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: const Text('Navigate to a new screen on Button click'),
          backgroundColor: Colors.blueAccent),
      body: Center(
          child: Column(
              children: [
                DataTable(
                    sortColumnIndex: 1,
                    columns: [
                      DataColumn(label: Text('Question')),
                      DataColumn(label: Text('Answer'))
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Leia')),
                        DataCell(Text('Organa'), showEditIcon: true)
                      ]),
                      DataRow(cells: [DataCell(Text('Luke')),
                        DataCell(Text('Skywalker'))
                      ]),
                    ]
                ),
                ElevatedButton(
                    child: Text("Load Tables"),
                    onPressed: () {
                      var response = quizInfo();
                      print(response);
                    }
                ),
                //Log in button sends in data
                ElevatedButton(
                    child: Text("Go Back To Log In"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                    }
                )
              ]

          )
      ),
    );
  }
}
