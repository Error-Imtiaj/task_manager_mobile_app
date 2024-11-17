import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/controller/progress_screnn_controller.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_widget.dart';


class ProgressTaskScreens extends StatefulWidget {
  const ProgressTaskScreens({super.key});

  @override
  State<ProgressTaskScreens> createState() => _ProgressTaskScreensState();
}

class _ProgressTaskScreensState extends State<ProgressTaskScreens> {
  final progressScreenController = Get.find<ProgressScrennController>();

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
          // TASK ITEMS
          GetBuilder<ProgressScrennController>(
            init: ProgressScrennController(),
            initState: (_) {},
            builder: (data) {
              return Visibility(
                visible: !data.fetchingTask,
                replacement: Center(
                  child: const CircularProgressIndicator(),
                ),
                child: Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.separated(
                    itemCount: data.allNewTaskList.length,
                    itemBuilder: (context, index) {
                      return TasktileWidget(
                        title: data.allNewTaskList[index].title,
                        description: data.allNewTaskList[index].description,
                        date: data.allNewTaskList[index].createdDate,
                        chipText: data.allNewTaskList[index].status!,
                        callback: () =>
                            data.deleteTask(data.allNewTaskList[index].id),
                        id: data.allNewTaskList[index].id,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  ),
                )),
              );
            },
          )
        ],
      ),
    );
  }

  // FETCH TASK
  Future<void> fetchTask() async {
    bool result = await progressScreenController.fetchTask();
    if (!result) {
      showSnackBar(context, progressScreenController.erroMessage!, true);
    }
  }

  // DELETE TASK
  Future<void> deleteTask(String? id) async {
    bool result = await progressScreenController.deleteTask(id);
    if (result) {
      showSnackBar(context, "Task Successfully Deleted");
    } else {
      showSnackBar(context, progressScreenController.erroMessage!, true);
    }
  }
}
