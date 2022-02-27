import 'package:flutter/material.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget widget;

  const InputField({Key key, @required this.title,@required this.hint, this.controller, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,top: 5,bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: Themes().headingStyle,),
          TextField(
            controller: controller,

            readOnly: widget!=null?true:false,
            style: Themes().subTitleStyle,
            decoration: InputDecoration(
              hintText: hint,
                suffixIcon:widget!=null?widget:null ,
                hintStyle:Themes().subTitleStyle ,

                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:  BorderSide(color:Colors.grey)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color:Colors.white))
            ),

          ),
        ],
      )
    );
  }
}
