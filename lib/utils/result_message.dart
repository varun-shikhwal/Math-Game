import 'package:flutter/material.dart';

import '../const.dart';
class resultMessage extends StatelessWidget {

  final String message;
  final VoidCallback onTap;
  final icon;
  const resultMessage({
    Key? key, required this.message, required this.onTap, this.icon

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message,style: whiteTextStyle,),

              Container(padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                   icon,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

