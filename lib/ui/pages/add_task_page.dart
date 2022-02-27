import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todome/controllers/task_controller.dart';
import 'package:todome/models/task.dart';
import 'package:todome/services/theme_services.dart';
import 'package:todome/ui/widgets/button.dart';
import 'package:todome/ui/widgets/input_field.dart';

import '../theme.dart';

class AddTaskPage extends StatefulWidget {
   AddTaskPage();
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
 var formkey = GlobalKey<FormState>();
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _startime = DateFormat('hh:mm a').format(DateTime.now());
  String _endtime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  List<int> remindList = [5, 10, 15, 20];
  int _selectedRemind = 5;
  String _selectedRepeat = 'None';
  List<String> repeatlist = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _selectedRemind=remindList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
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
          onPressed: () => ThemeServices().SwitchTheme(),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: MyButton(
          onTap: () {
            if (formkey.currentState.validate()) {
              _AddTaskToDb();
              Get.back();
            } else {
              Get.snackbar(
                  'Required',
                  'you should fill empty fields',
                  backgroundColor: Colors.white,
                  snackPosition:SnackPosition.BOTTOM ,
                  colorText: pinkClr,
                  icon: Icon(Icons.warning_amber_rounded, color: Colors.red,)

              );
            }
          },
          lable: 'Create task',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Add Task',
                style: Themes().headingStyle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key:formkey ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Title',
                      style: Themes().headingStyle,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                           hintText: 'enter a task title'),


                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your Task title';
                        } else {
                          return null;
                        }
                      },
                      controller: _titleController,
                    ),
                  //  Text('Note',style: Theme.of(context).textTheme.headline4.copyWith(),),
                    Text(
                      'Note',
                      style: Themes().headingStyle,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                          , hintText: 'enter your note'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your note';
                        } else {
                          return null;
                        }
                      },
                      controller: _noteController,
                    ),
                  ],
                ),
              ),
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(selectedDate),
              widget: IconButton(icon: Icon(
                Icons.calendar_today_outlined,
                color: Colors.grey,
              ), onPressed:  ()=>_getDateFromUser()),
            ),
            Row(
              children: [
                Expanded(
                    child: InputField(
                        title: 'Start Time',
                        hint: _startime,
                        widget: IconButton(icon: Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ), onPressed:()=> _getTimeFromUser(isStart: true)))),
                Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endtime,
                      widget: IconButton(icon: Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ), onPressed:()=> _getTimeFromUser(isStart: false))
                    ))
              ],
            ),
            InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.grey,
                    ),
                    // value:_selectedRemind,
                    elevation: 6,
                    underline: Container(
                      height: 0,
                    ),
                    items: remindList
                        .map((e) =>
                        DropdownMenuItem<int>(
                            value: e,
                            child: Text(
                              '$e ',
                              style: TextStyle(color: Colors.white),
                            )))
                        .toList(),
                    onChanged: (newval) {
                      setState(() {
                        _selectedRemind = newval;
                      });
                    })),
            InputField(
              title: 'Repeat',
              hint: _selectedRepeat,
              widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.grey,
                  ),
                  // value:_selectedRemind,
                  elevation: 6,
                  underline: Container(
                    height: 0,
                  ),
                  items: repeatlist
                      .map((e) =>
                      DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            '$e ',
                            style: TextStyle(color: Colors.white),
                          )))
                      .toList(),
                  onChanged: (newval) {
                    setState(() {
                      _selectedRepeat = newval;
                    });
                  }),
            ),
            _buildColorPallete(),
          ],
        ),
      ),
    );
  }

  _AddTaskToDb() async {
    int value = await _taskController.AddTask(
         Task(
          title: _titleController.text,
          note: _noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(selectedDate),
          startTime: _startime,
          endTime: _endtime,
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ));
    print('Task is created And it\'id = $value دخلت التاسك الجديد');
  }

  Widget _buildColorPallete() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: Themes().headingStyle,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(
                3,
                    (index) =>
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          backgroundColor: index == 0
                              ? primaryClr
                              : index == 1
                              ? pinkClr
                              : orangeClr,
                          child:
                          _selectedColor == index ? Icon(Icons.done) : null,
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime _pickedDate = await showDatePicker(context:context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2105));
    if (_pickedDate != null) {
      setState(() {
        selectedDate = _pickedDate;
      });
    } else {
      print('errrrrrrrrrror in date');
    }
  }

  _getTimeFromUser({bool isStart}) async {
    TimeOfDay _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: isStart
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
            DateTime.now().add(const Duration(minutes: 15))));
    String _formatedtime= _pickedTime.format(context);
    if(isStart) {
      setState(() {
        _startime=_formatedtime;
      });
    }
    if(!isStart) {
      setState(() {
        _endtime=_formatedtime;
      });
    }
    }



}
