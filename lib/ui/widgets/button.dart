import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final Function onTap;
  final String lable;

  const MyButton({Key key, @required this.onTap, @required this.lable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        child: Container(

          alignment: Alignment.center,
      width: 120,
      height: 50,
      decoration: BoxDecoration(

        color: primaryClr,
        borderRadius: BorderRadius.circular(15),
      ),
          child:Text(lable,  style: TextStyle(
              fontSize: 20, color: white ,fontWeight: FontWeight.bold))) ,
    );
  }
}
