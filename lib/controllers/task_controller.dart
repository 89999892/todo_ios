import 'package:get/get.dart';
import 'package:todome/db/db_helper.dart';
import 'package:todome/models/task.dart';

class TaskController extends GetxController{

final  tasksList=<Task>[].obs;
 Future<int> AddTask(Task task){
return DBHelper.insertToDb(task);
}
void DeleteTask({Task task})async{
 await DBHelper.deletFromDb(task);
 getTasks();
}
void markAsCompleted({Task task})async{
  await DBHelper.updateTaskDb(task.id);
  getTasks();
}
Future<void> getTasks()async{
  final List<Map<String,dynamic> >tasks=await  DBHelper.quaryTasksDb();
  tasksList.assignAll(tasks.map((element) {
    return Task.fromJson(element);
  }).toList());
}
}
