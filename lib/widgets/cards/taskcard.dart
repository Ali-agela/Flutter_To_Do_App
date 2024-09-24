import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/task_models.dart';
import 'package:flutter_to_do_app/providers/dark_mode_provider.dart';
import 'package:flutter_to_do_app/screens/task_deatails_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskCard extends StatelessWidget {
  TaskCard(
      {super.key,
      required this.taskModel,
      required this.onTapForCheck,
      required this.onTapForDelete, required this.onTapForEdite});
  final TaskModel taskModel;
  final Function onTapForCheck;
  final Function onTapForDelete;
  final Function onTapForEdite;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context,darkModeProvider,_) {
        var language = AppLocalizations.of(context)!;
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:(context) => TaskDetailsScreen(taskModel: taskModel)));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: darkModeProvider.isDark?Colors.white :Colors.blue.withOpacity(0.2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskModel.title,
                          style: TaskCartTextStyle(18, darkModeProvider),
                        ),
                        Text(
                          taskModel.subTitle ?? "",
                          style: TaskCartTextStyle(14, darkModeProvider),),
                        Text(
                          TaskCardFormatDate(taskModel),
                          style: TaskCartTextStyle(13,darkModeProvider),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){ 
                              onTapForEdite();
                              },
                              icon: Icon(Icons.edit,color: Colors.yellow[400],)),
                        IconButton(
                            onPressed: () {
                              onTapForDelete();
                            },
                            icon: const Icon(Icons.delete,color: Colors.red,)),
                        Checkbox(
                            value: taskModel.status,
                            onChanged: (check) {
                              onTapForCheck();
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

TextStyle TaskCartTextStyle(double fontSize,DarkModeProvider darkModeProvider,
    {FontWeight fontWeight = FontWeight.bold,}) {
  return TextStyle(
      fontSize: fontSize, fontWeight: fontWeight,
      color: darkModeProvider.isDark?Colors.black:Colors.blueGrey);
}

String TaskCardFormatDate(TaskModel taskmodel) {
  if (taskmodel.status) {
    return DateFormat("EEE-dd-MMM-yyyy")
        .format(DateTime.parse(taskmodel.createdAt.toIso8601String()))
        .replaceAll("-", ",");
  } else {
    return format(taskmodel.createdAt);
  }
}
