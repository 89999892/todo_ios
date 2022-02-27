import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  final String payload;
  const NotificationScreen(@required this.payload);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        
        title: Center(
            child: Text(
          '${widget.payload.toString().split('|')[0]}',
          style: TextStyle(
            color: Get.isDarkMode? white:darkGreyClr,
            fontSize: 20,
          ),
          overflow: TextOverflow.fade,
        )),
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('hello monty ',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600, color: Get.isDarkMode? white:darkGreyClr)),
                Text('you have a new reminder.',style: TextStyle(fontSize: 15,color: Get.isDarkMode? white:darkHeaderClr)),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                  margin: EdgeInsets.only(left: 20,right: 20),

                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: bluishClr),
                    child: SingleChildScrollView(
                      child: Column(
                       crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,top: 10),
                            child: Row(

                              children: [
                                Icon(Icons.text_format_outlined,color: Colors.white,size: 30,),
                                SizedBox(width: 10,),
                                Text('Title :',style: TextStyle(color: Colors.white,fontSize: 30),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('${_payload.toString().split('|')[0]}',style: TextStyle(fontSize: 20,color: Colors.white),),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left:0,top: 10),
                            child: Row(

                              children: [
                                Icon(Icons.description,color: Colors.white,size: 30,),
                                SizedBox(width: 10,),
                                Text('Description :',style: TextStyle(color: Colors.white,fontSize: 30),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('${_payload.toString().split('|')[1]}',style: TextStyle(fontSize: 20,color: Colors.white),),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 0,top: 10),
                            child: Row(

                              children: [
                                Icon(Icons.calendar_today,color: Colors.white,size: 30,),
                                SizedBox(width: 10,),
                                Text('Date :',style: TextStyle(color: Colors.white,fontSize: 30),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('${_payload.toString().split('|')[2]}',style: TextStyle(fontSize: 20,color: Colors.white),),
                        ],
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
