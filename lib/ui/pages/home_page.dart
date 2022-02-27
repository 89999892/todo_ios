//import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todome/controllers/task_controller.dart';
import 'package:todome/models/task.dart';
import 'package:todome/notifyhelper/notification_services.dart';
//import 'package:todome/services/notification_services.dart';
import 'package:todome/services/theme_services.dart';
import 'package:todome/ui/pages/add_task_page.dart';
import 'package:todome/ui/size_config.dart';
import 'package:todome/ui/theme.dart';
import 'package:todome/ui/widgets/button.dart';

import 'package:intl/intl.dart';
import 'package:todome/ui/widgets/task_tile.dart';



class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotifyHelper notifyHelper;
  final TaskController _taskController = Get.put(TaskController());
  final DateTime selectedDate=DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 15),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/person.jpeg'),
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
              Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              color: Get.isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            ThemeServices().SwitchTheme();
            notifyHelper.displayNotification(
                title: 'hello', body: 'sdedfwefwefwefwef');
            // notifyHelper.sheduledNotification();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _addTaskBar(),
                SizedBox(
                  height: 20,
                ),
                _addDateBar(),

                 Obx(
                   ()=> Expanded(
                     child: Container(
                       //height:SizeConfig.orientation==Orientation.landscape?MediaQuery.of(context).size.width*.1:MediaQuery.of(context).size.height*.7,
                         width: MediaQuery.of(context).size.width,
                         child:_taskController.tasksList.isEmpty?_NoTaskmsg(): _showAllTasks()),
                   ),
                 )

                // _NoTaskmsg()
              ],
            ),
        ),

    );
  }

  Widget _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: Themes().subheadingStyle,
            ),
            Text(
              'Today',
              style: Themes().headingStyle,
            )
          ],
        ),
        MyButton(
          lable: '+ Add Task',
          onTap: ()=> Get.to(()=>AddTaskPage())
          // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddTaskPage()));
         //  _taskController.getTasks();
          ,
        )
      ],
    );
  }

  Widget _addDateBar() {
    return DatePicker(
      selectedDate,
      height: 105,
      width: 80,
      selectionColor: primaryClr,
      dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 24, color: Colors.grey, fontWeight: FontWeight.w400)),
      monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400)),
      dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400)),
    );
  }

  Widget _NoTaskmsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(seconds: 2),
          child: RefreshIndicator(
            onRefresh: _Refresh,
           // color: bluishClr,
            backgroundColor: bluishClr,
            child: SingleChildScrollView(
              child: Wrap(
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 220,
                        ),
                  SvgPicture.asset(
                    'assets/images/task.svg',
                    color: primaryClr.withOpacity(.5),
                    width: 150,
                    height: 150,
                    semanticsLabel: 'Task',
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Text(
                      'you don\'t have any tasks yet!\nAdd new tasks to make your days productive',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 180,
                        ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _showTask(Task task, int index) {
    return AnimationConfiguration.staggeredList(
      duration: Duration(seconds: 2),
      position: index,
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              _showBottomSheet(task);
            },
            child:  TaskTile(task),
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetButton(
      {@required String lable,
      @required Function onTap,
      @required Color clr,
      bool isClose = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: onTap,
        child: SizedBox(
            height: 65,
            width: MediaQuery.of(context).size.width * .85,
            child: Center(
                child: Text(
              lable,
              style: Themes().titleStyle.copyWith(color: Colors.white),
            ))),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                width: 2,
                color: isClose
                    ? Get.isDarkMode
                        ? Colors.grey[600]
                        : Colors.grey[300]
                    : clr)),
        color: clr,
      ),
    );
  }

  _showBottomSheet(Task _task) {
    Get.bottomSheet(
      Expanded(
        child: Container(
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  if(_task.isCompleted==0)
                     _bottomSheetButton(
                      lable: 'Task Completed', onTap: () {
                        _taskController.markAsCompleted(task: _task);
                        Get.back();
                        }, clr: primaryClr),
                  _bottomSheetButton(
                      lable: 'Delete Task', onTap: () {
                    _taskController.DeleteTask(task: _task);
                    Get.back();
                  }, clr: Colors.red[300]),
                  Divider(
                    color: Colors.grey,
                  ),
                  _bottomSheetButton(
                      lable: 'Cancle',
                      onTap: () => Get.back(),
                      clr: primaryClr),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showAllTasks() {
    return RefreshIndicator(
      onRefresh: _Refresh,
      backgroundColor: bluishClr,
      child: ListView.builder(
         shrinkWrap: true,
             // physics: NeverScrollableScrollPhysics(),
              itemCount: _taskController.tasksList.length,
              scrollDirection: SizeConfig.orientation==Orientation.landscape?Axis.horizontal:Axis.vertical,//,
              itemBuilder: (BuildContext ctx, index) {
                Task task = _taskController.tasksList[index];
                var date=DateFormat.jm().parse(task.startTime);
                var myTime=DateFormat('HH:mm').format(date);
                notifyHelper.scheduledNotification(int.parse(myTime.toString().split(':')[0]), int.parse(myTime.toString().split(':')[1]), task);


                if(task.repeat=='Daily'||task.date==DateFormat.yMd().format(selectedDate)){
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:   Container(
                          width:400,child: _showTask(task, index)));

                }else
                return Container();



              }),
    );
  }

 Future<void> _Refresh() async{
     _taskController.getTasks();
  }
}
