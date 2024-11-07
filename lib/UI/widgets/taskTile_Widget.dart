import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';

class TasktileWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final String? date;
  final String chipText;
  final Function() callback;
  const TasktileWidget(
      {super.key,
      this.title,
      this.description,
      this.date,
      required this.chipText,
      required this.callback});

  @override
  State<TasktileWidget> createState() => _TasktileWidgetState();
}

class _TasktileWidgetState extends State<TasktileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorsUtils.backGroundColor,
      title: Text(
        widget.title!,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.description!,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
          ),
          const SizedBox(
            height: 8,
          ),
          // date
          Text(
            "date: ${widget.date}",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text(
                  widget.chipText,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorsUtils.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _editStatus();
                        },
                        icon: const Icon(
                          Icons.edit_document,
                          color: ColorsUtils.primaryColor,
                        )),
                    IconButton(
                        onPressed: () {
                          widget.callback();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: ColorsUtils.pinkColor,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editStatus() {
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
                return ListTile(
                  title: Text(e),
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }
}
