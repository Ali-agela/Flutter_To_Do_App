import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskDialog extends StatefulWidget {
  AddTaskDialog(
      {super.key,
      required this.taskTitleController,
      required this.taskSubtitleController,
      required this.formkey,
      required this.ontap,
      this.textOnButton ="Add", this.textOnDia="Add your Task"
      });

  final TextEditingController taskTitleController;
  final TextEditingController taskSubtitleController;
  final GlobalKey<FormState> formkey;
  final Function ontap;
  final String textOnButton ;
  final String textOnDia;


  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.textOnDia),
              const SizedBox(height: 16,),
              TextFormField(
                controller: widget.taskTitleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return language.entertaskname;
                  }
                  if (value.length <5) {
                    return language.titlemustbeatleat6letterslong;
                  }
                  if (value.length > 20){
                      return language.titleistoolong;
                  }
                  return null;
                },
                decoration:  InputDecoration(
                  hintText: language.entertaskname ,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: widget.taskSubtitleController,
                decoration:  InputDecoration(
                  hintText: language.entertasksubtitle,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child:  Text(
                      language.cancel,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      widget.taskSubtitleController.clear();
                      widget.taskTitleController.clear();
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (widget.formkey.currentState!.validate()) {
                          widget.ontap();
                        }
                      },
                      child:  Text(widget.textOnButton))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
