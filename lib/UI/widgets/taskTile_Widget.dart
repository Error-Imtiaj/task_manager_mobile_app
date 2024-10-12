import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';

class TasktileWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? Date;
  const TasktileWidget({super.key, this.title, this.description, this.Date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorsUtils.backGroundColor,
      title: Text(
        title!,
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
            description!,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
          ),
          SizedBox(
            height: 8,
          ),
          // Date
          Text(
            "Date: $Date",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Show More",
              style: GoogleFonts.poppins(
                  fontSize: 12, color: ColorsUtils.backGroundColor),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: ColorsUtils.primaryColor),
          )
        ],
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit_document,
                  color: ColorsUtils.primaryColor,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: ColorsUtils.pinkColor,
                )),
          ],
        ),
      ),
    );
  }
}
