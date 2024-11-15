import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/model/new_task_list.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class ProgressScrennController extends GetxController {
  bool deletedTask = false;
  bool fetchingTask = false;
  List<NewTaskList> allNewTaskList = [];
  String? erroMessage;
  bool taskFetchedSuccessfully = false;
  // FETCH TASK
  Future<bool> fetchTask() async {
    fetchingTask = true;
    update();
    allNewTaskList.clear();
    Map<String, String> head = {
      'Content-Type': 'application/json',
      'token': Auth.myToken.toString()
    };
    NetworkModel response = await NetworkCaller.getRequest(
      url: Urls.progressTaskUrl,
      headers: head,
    );

    if (response.isSuccess) {
      List data = response.message;
      taskFetchedSuccessfully = true;
      for (var i in data) {
        allNewTaskList.add(NewTaskList.fromJson(i));
      }
      fetchingTask = false;
      update();
      return taskFetchedSuccessfully;
    } else {
      erroMessage = response.errorMessage;
    }
    fetchingTask = false;
    update();
    return taskFetchedSuccessfully;
  }

  // DELETE TASK
  Future<bool> deleteTask(String? id) async {
    Map<String, String> head = {
      'Content-Type': 'application/json',
      'token': Auth.myToken.toString()
    };

    NetworkModel response = await NetworkCaller.getRequest(
      url: '${Urls.deleteTaskUrl}/${id}',
      headers: head,
    );
    if (response.isSuccess) {
      fetchTask();
      deletedTask = true;
      return deletedTask;
    } else {
      erroMessage = response.errorMessage;
    }
    return deletedTask;
  }
}
