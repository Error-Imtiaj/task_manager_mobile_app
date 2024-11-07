import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';

import 'package:task_manager_mobile_app/UI/widgets/card_widget.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_widget.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/model/new_task_list.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class NewTaskScreens extends StatefulWidget {
  const NewTaskScreens({super.key});

  @override
  State<NewTaskScreens> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreens> {
  List<NewTaskList> allNewTaskList = [];
  bool _fetchingTask = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // CARD DETAILS
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _heroSection(),
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
    );
  }

  // TASK HERO ECTION
  Widget _heroSection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardWidget(
          count: '09',
          title: 'New Task',
        ),
        CardWidget(
          count: '09',
          title: 'Completed',
        ),
        CardWidget(
          count: '09',
          title: 'Cancelled',
        ),
        CardWidget(
          count: '09',
          title: 'Progress',
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
