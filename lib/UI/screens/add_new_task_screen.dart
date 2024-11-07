import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _scontroller = TextEditingController();
  final TextEditingController _dcontroller = TextEditingController();
  bool _assnewTask = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _scontroller.dispose();
    _dcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        backgroundColor: ColorsUtils.primaryColor,
        title: Text(
          "Add new task",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ColorsUtils.backGroundColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: ColorsUtils.backGroundColor),
      ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                // ADD NEW TASK TITLE
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsUtils.primaryColor),
                ),

                // SUBJECT TEXT FIELD
                const SizedBox(
                  height: 30,
                ),
                Textfieldwidget(
                  fillColor: ColorsUtils.fieldPrimaryColor,
                  controller: _scontroller,
                  hintText: "Subject",
                  Borderradias: BorderRadius.circular(10),
                  validatorFunction: (p0) => _nameValidator(p0),
                ),

                // DESCRIPTION TEXT FIELD
                const SizedBox(
                  height: 20,
                ),
                Textfieldwidget(
                  fillColor: ColorsUtils.fieldPrimaryColor,
                  controller: _dcontroller,
                  hintText: "Description",
                  Borderradias: BorderRadius.circular(10),
                  maxlength: 1000,
                  maxline: 7,
                  validatorFunction: (p0) => _nameValidator(p0),
                ),

                // BUTTON
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: !_assnewTask,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Custombutton(
                    ButtonName: "Add Task",
                    ontap: () {
                      if (_formkey.currentState!.validate()) {
                        _addtask();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }

  //TODO ONTAP ADD TASK
  Future<void> _addtask() async {
    _assnewTask = true;
    setState(() {});
    Map<String, dynamic> data = {
      "title": _scontroller.text,
      "description": _dcontroller.text,
      "status": "New"
    };

    Map<String, String> head = {
      'Content-Type': 'application/json',
      'token': Auth.myToken.toString()
    };

    NetworkModel response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: data, header: head);

    if (response.isSuccess) {
      _clearText();
      showSnackBar(context, "Task created successfully");
    } else {
      showSnackBar(context, response.errorMessage.toString(), true);
    }
    _assnewTask = false;
    setState(() {});
  }

  void _clearText() {
    _scontroller.clear();
    _dcontroller.clear();
  }
}
