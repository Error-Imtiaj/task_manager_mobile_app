import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/screens/add_new_task_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';

import 'package:task_manager_mobile_app/UI/widgets/card_widget.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_widget.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/model/new_task_list.dart';
import 'package:task_manager_mobile_app/data/model/task_ststus_count_model.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class NewTaskScreens extends StatefulWidget {
  const NewTaskScreens({super.key});

  @override
  State<NewTaskScreens> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreens> {
  List<NewTaskList> allNewTaskList = [];
  List<TaskStstusCountModel> taskStatusLists = [];
  bool _fetchingTask = false;
  bool _fetchingTaskstatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTask();
    fetchTaskstatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // CARD DETAILS
          Visibility(
            visible: !_fetchingTaskstatus,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _heroSection(),
              ),
            ),
          ),

          // TASK ITEMS
          Visibility(
            visible: !_fetchingTask,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.separated(
                itemCount: allNewTaskList.length,
                itemBuilder: (context, index) {
                  return TasktileWidget(
                    title: allNewTaskList[index].title,
                    description: allNewTaskList[index].description,
                    date: allNewTaskList[index].createdDate,
                    chipText: allNewTaskList[index].status!,
                    callback: () => deleteTask(allNewTaskList[index].id),
                    id: allNewTaskList[index].id,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              ),
            )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsUtils.primaryColor,
        onPressed: () {
          _navigateToAddNewTaskScreen();
        },
        child: const Icon(
          Icons.add,
          color: ColorsUtils.backGroundColor,
        ),
      ),
    );
  }

  void _navigateToAddNewTaskScreen() async {
    bool shouldRefresh = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
    if (shouldRefresh) {
      fetchTask();
      fetchTaskstatus();
    }
  }

  // FETCH TASK STATUS COUNT
  Future<void> fetchTaskstatus() async {
    _fetchingTaskstatus = true;
    setState(() {});
    taskStatusLists.clear();

    Map<String, String> head = {
      'Content-Type': 'application/json',
      'token': Auth.myToken.toString()
    };

    NetworkModel response = await NetworkCaller.getRequest(
      url: Urls.tastStatusCountUrl,
      headers: head,
    );

    if (response.isSuccess) {
      for (var element in response.message) {
        taskStatusLists.add(TaskStstusCountModel.fromJson(element));
      }
    } else {
      showSnackBar(context, response.errorMessage, true);
    }

    _fetchingTaskstatus = false;
    setState(() {});
  }

  // Hero sections
  Widget _heroSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardWidget(
          count: taskStatusLists.isNotEmpty && taskStatusLists.length > 2
              ? taskStatusLists[2].sum.toString()
              : '0', // Default or placeholder
          title: taskStatusLists.isNotEmpty && taskStatusLists.length > 2
              ? taskStatusLists[2].id.toString()
              : 'New', // Default or placeholder
        ),
        CardWidget(
          count: taskStatusLists.isNotEmpty && taskStatusLists.length > 3
              ? taskStatusLists[3].sum.toString()
              : '0',
          title: taskStatusLists.isNotEmpty && taskStatusLists.length > 3
              ? taskStatusLists[3].id.toString()
              : 'Unknown',
        ),
        CardWidget(
          count: taskStatusLists.isNotEmpty && taskStatusLists.length > 0
              ? taskStatusLists[0].sum.toString()
              : '0',
          title: taskStatusLists.isNotEmpty && taskStatusLists.length > 0
              ? taskStatusLists[0].id.toString()
              : 'Progress',
        ),
        CardWidget(
          count: taskStatusLists.isNotEmpty && taskStatusLists.length > 1
              ? taskStatusLists[1].sum.toString()
              : '0',
          title: taskStatusLists.isNotEmpty && taskStatusLists.length > 1
              ? taskStatusLists[1].id.toString()
              : 'Canceled',
        ),
      ],
    );
  }

  // FETCH TASK
  Future<void> fetchTask() async {
    _fetchingTask = true;
    setState(() {});
    allNewTaskList.clear();
    Map<String, String> head = {
      'Content-Type': 'application/json',
      'token': Auth.myToken.toString()
    };

    NetworkModel response = await NetworkCaller.getRequest(
      url: Urls.newTaskUrl,
      headers: head,
    );

    if (response.isSuccess) {
      List data = response.message;
      for (var i in data) {
        allNewTaskList.add(NewTaskList.fromJson(i));
      }
    } else {
      showSnackBar(context, response.errorMessage, true);
    }
    _fetchingTask = false;
    setState(() {});
  }

  // DELETE TASK
  Future<void> deleteTask(String? id) async {
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
      showSnackBar(context, "Task Successfully Deleted");
    } else {
      showSnackBar(context, response.errorMessage, true);
    }
  }
}
