import 'package:flutter/material.dart';
import 'package:todome/models/task.dart';
import 'package:todome/ui/size_config.dart';

import '../theme.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile(this.task) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,),
      child: Container(
        width: SizeConfig.orientation==Orientation.landscape?MediaQuery.of(context).size.width*.5:MediaQuery.of(context).size.width*.9,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
        color: _getTaskColor(task.color)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(task.title,style: TextStyle(fontSize: 18,color: Colors.white),),
                    SizedBox(height: 12,),
                    Row(children: [
                      Icon(Icons.access_time,size: 18,color: Colors.grey[300],),
                      SizedBox(width: 10,),
                     Text('${task.startTime}-${task.endTime}',style: TextStyle(fontSize: 15,color: Colors.white),),

                    ],),
                    SizedBox(height: 12,),
                    Text(task.note,style: TextStyle(fontSize: 14,color: Colors.white,),)

                  ],

                ),
              )),
          SizedBox(width: 3,),

          Container(height: 100,width: .5,color: Colors.grey[300],),

              RotatedBox(quarterTurns:3,child: Text('${task.isCompleted==0?'TODO':'Completed'}'), )
            ],
          ),
        ),
      ),
    );
  }

 Color _getTaskColor(int color) {
    if(color==0)
        return primaryClr;
    else if(color==1)
      return pinkClr;
    else
      return orangeClr;
  }
}
