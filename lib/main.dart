import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todome/db/db_helper.dart';

import 'package:todome/services/theme_services.dart';
import 'package:todome/ui/pages/add_task_page.dart';
import 'package:todome/ui/pages/notification_screen.dart';

import 'package:todome/ui/theme.dart';

import 'notifyhelper/notification_services.dart';
import 'ui/pages/home_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
 await DBHelper.initDB();
 await GetStorage.init();
  runApp(const MyApp());
  NotifyHelper().initializeNotification();
}

class MyApp extends StatelessWidget {
  const MyApp() ;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:Themes.light,
      getPages: [
        GetPage(name: 'homePage', page:()=> HomePage()),
        GetPage(name: 'addTaskPage', page:()=> AddTaskPage()),
        GetPage(name: 'notificationPage', page:()=> NotificationScreen('')),
      ],
      darkTheme: Themes.dark,
      themeMode: ThemeServices().Theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}
