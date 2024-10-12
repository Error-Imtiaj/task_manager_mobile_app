import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/card_widget.dart';

class NewTaskScreens extends StatefulWidget {
  const NewTaskScreens({super.key});

  @override
  State<NewTaskScreens> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // CARD DETAILS
            _heroSection(),
            // TASK ITEMS
            Expanded(
                child: ListView.separated(
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: ColorsUtils.backGroundColor,
                  title: Text(
                    "Lorem Ipsum Title Text",
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor e ere grgehg ukhueru ",
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Date
                      Text(
                        "Date: 16/11/2003",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12, fontWeight: FontWeight.bold),
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
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 8,
                );
              },
            ))
          ],
        ),
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
}
