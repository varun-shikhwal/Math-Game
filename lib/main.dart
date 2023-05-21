import 'dart:math';

import 'package:calculator/const.dart';
import 'package:calculator/utils/key_buttons.dart';
import 'package:calculator/utils/result_message.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
void main(){
  return runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         debugShowCheckedModeBanner: false,

      home: calcii(),
    );
  }

}
class calcii extends StatefulWidget{
  @override
  State<calcii> createState() => _calciiState();
}

class _calciiState extends State<calcii> {

  // number pad
  List<String> numberPad=[
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',

  ];

  //number A, number B
  int numberA=1;
  int numberB=1;


  // user answer
   String userAnswer='';

   void buttonTapped(String button){
     setState(() {
       if(button=='='){
         // calculate if user is correct or incorrect
           checkResult();

       }
       else if(button=='C'){
         userAnswer='';
       }
       else if(button=='DEL') {
         if (userAnswer.isNotEmpty) {
           userAnswer = userAnswer.substring(0, userAnswer.length - 1);
         }
       }
       else if(userAnswer.length<3){
         userAnswer +=button;
       }

     });
   }

   void checkResult(){
     if(numberA+numberB==int.parse(userAnswer)){
      showDialog(context: context, builder: (context) {
        return resultMessage(
          message: 'Correct!',
          onTap: gotoNextQuestion,
          icon: Icons.arrow_forward,);
      },);
     }
     else{
       showDialog(context: context, builder: (context) {
         return resultMessage(
           message: 'Sorry try again',
           onTap: goBackToQuestion,
           icon: FontAwesome.rotate_left ,);
       },);
     }
   }
   var randomNumber=Random();

   //Go to next question
   void gotoNextQuestion(){
     Navigator.of(context).pop();
     setState(() {
       userAnswer='';

     });

     //create new question
     numberA=randomNumber.nextInt(10);
     numberB=randomNumber.nextInt(10);
   }

   // go back to question
  void goBackToQuestion(){
     Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: Center(child: Text('MATH GAME',style: whiteTextStyle,)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // level progress, player needs 5 correct answers in a row

          Container(
            height: 100,
            color: Colors.deepPurple,
            child: Center(child:Image.asset('assets/icons/icon_1.png')),

          ),

          // questions

           Expanded(child: Container(
             child: Center(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   //question
                   Text(
                     numberA.toString() + ' + ' + numberB.toString() + ' = ',
                     style: whiteTextStyle,
                   ),
                   
                   // answer text
                   Container(
                     height: 60,
                     width: 130,

                     decoration: BoxDecoration(
                       color: Colors.deepPurple,
                       borderRadius: BorderRadius.circular(14),
                     ),
                     child: Center(
                       child: Text(
                         userAnswer,
                         style: whiteTextStyle,
                       ),
                     ) ,
                   ),
                 ],
               ),
             ),
           )),
          Expanded(
              flex:2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  itemCount: numberPad.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ), itemBuilder:(context, index) {
                  return MyButtons(child: numberPad[index],
                  onTap:() => buttonTapped(numberPad[index]),
                  );
                }, ),
              )
          ),

        ],
      ),
    );
  }
}