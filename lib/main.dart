import 'dart:math';

import 'package:flutter/material.dart';

import 'game.dart';
import 'guess_number.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // callback method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class _HomePageState extends State<HomePage> {

  var ran = Rd();
  String _number = '';
  String _status = 'ทายตัวเลขที่สุ่มจาก1ถึง100';
  int count = 0 ;





    @override
    Widget build(BuildContext context) {


      var gamerandom = game(ran.answers);
      var rrr = ran.answers.toString();
      print('เฉลย: ' + rrr.toString());


      return Scaffold(
        appBar: AppBar(
          title: const Text('GUESS THE NUMBER'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.orangeAccent,
                  offset: Offset(5.0, 5.0),
                  spreadRadius: 2.0,
                  blurRadius: 5.0,
                )
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/guess_logo.png', width: 90.0),
                      SizedBox(width: 8.0),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('GUESS',
                              style: TextStyle(
                                  fontSize: 36.0,
                                  color: Colors.orange,)),
                          Text(
                            'THE NUMBER',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_number',
                    style: TextStyle(fontSize: 50.0, color: Colors.redAccent),
                  ),
                ),
                //บอกสถานะ//
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Text(


                    '$_status',

                    style: TextStyle(fontSize: 25.0, color: Colors.pinkAccent),
                  ),
                ),
                 Padding(
                        padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 1; i <= 3; i++) buildButton(num: i),
                  ],
                )),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         for (var i = 4; i <= 6; i++) buildButton(num: i),
                       ],
                     )),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           for (var i = 7; i <= 9; i++) buildButton(num: i),
                         ],
                       )),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                            onPressed: () {
                              print('close');
                              setState(() {
                                _number = _number.substring(0, 0);
                              });
                            },
                            child: Icon(
                              Icons.disabled_by_default, // รูปไอคอน
                              size: 25.0,
                            )),
                      ),
                      buildButton(num: 0),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: OutlinedButton(
                            onPressed: () {
                              print('backspace');
                              setState(() {
                                _number = _number.substring(
                                    0, _number.length - 1);
                              });
                            },
                            child: Icon(
                              Icons.backspace,
                              // รูปไอคอน
                              size: 25.0,
                            )),
                      ),
                    ],
                  ),
                ),





                Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: ElevatedButton(

                    child: Text('GUESS'),
                    onPressed: () {

                      var guess = int.tryParse(_number);


                      if (guess == null) {
                        setState(() {
                          _status =
                          'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น';
                          _number = _number.substring(0, 0);
                        });

                        return;
                      }
                      else {
                        var result = gamerandom.doGuess(guess);
                        if (result == 1) {
                          setState(() {
                            _status = '$guess : มากเกินไป กรุณาลองใหม่!';
                            _number = _number.substring(0, 0);
                          });
                          print('$guess มากเกินไป กรุณาลองใหม่!');
                          count++;
                        } else if (result == -1) {
                          setState(() {
                            _status = '$guess : น้อยเกินไป กรุณาลองใหม่!';
                            _number = _number.substring(0, 0);
                          });
                          print('$guess น้อยเกินไป กรุณาลองใหม่!');
                          count++;
                        } else if (result == 0) {
                          setState(() {
                            count++;
                            _status =
                            'ถูกต้องแล้วครับ🎉 คุณทายทั้งหมด $count ครั้ง';


                          });
                          print(


                              '$guess ถูกต้องแล้วครับ \n คุยทายทั้งหมด $count ครั้ง');



                        }
                      }// by siwat


                      //_showOkDialog(context, 'RESULT', message);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }


  Widget buildButton({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
          onPressed: () {
           setState((){
             _number = ' $_number$num';
           });
          },
          child: Text('$num')),
    );
  }
}
