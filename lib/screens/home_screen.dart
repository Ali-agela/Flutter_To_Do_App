import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/task_models.dart';
import 'package:flutter_to_do_app/providers/dark_mode_provider.dart';
import 'package:flutter_to_do_app/providers/tasks_Provider.dart';
import 'package:flutter_to_do_app/widgets/cards/taskcard.dart';
import 'package:flutter_to_do_app/widgets/clickables/draweer_tile.dart';
import 'package:flutter_to_do_app/widgets/dialogs/addtaddialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController subTaskTitleController = TextEditingController();
  // List<TaskModel> tasks = [];

  @override
  void initState() {
    print("thisFunWorks");
    Provider.of<TasksProvider>(context,listen: false).getTasks();
    print(Provider.of<TasksProvider>(context,listen: false).tasks);
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context)!;
    return Consumer<DarkModeProvider>(
      builder: (context,darkModeProvider,_) {
        return Consumer<TasksProvider>(
          builder: (context, tasksProvider,_) {
            return Scaffold(
              drawer: SafeArea(
                child: Drawer(
                  child: DraweerTile(
                    icon: darkModeProvider.isDark?Icons.dark_mode:Icons.light_mode,
                    text: darkModeProvider.isDark? language.lightmode:language.darkmode,
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddTaskDialog(
                            textOnButton: language.add,
                            textOnDia: language.add,
                              taskTitleController: taskTitleController,
                              taskSubtitleController: subTaskTitleController,
                              formkey: formKey,
                              ontap: () {
                                Provider.of<TasksProvider>(context , listen: false).addTask(
                                  TaskModel(
                                    title: taskTitleController.text,
                                    subTitle: subTaskTitleController.text,
                                    createdAt: DateTime.now())
                                ) ; 
                                taskTitleController.clear();
                                subTaskTitleController.clear();
                                Navigator.pop(context);
                              });
                        });
                  }),
              appBar: AppBar(
                title:  Text(language.todo),
              ),
              body:  DefaultTabController(
              length: 2,
              child: Column(
                children: [
                    TabBar(tabs: [
                    Tab(text: language.waiting   ),
                    Tab(text: language.completed,)
                  ]),
                  Expanded(child: TabBarView(children: [
                    ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount:tasksProvider.tasks.length,
                      itemBuilder: (context, index){
                        if (!tasksProvider.tasks[index].status){
                        return  TaskCard(taskModel: tasksProvider.tasks[index], onTapForCheck:(){
                            Provider.of<TasksProvider>(context,listen: false).switchState(
                              tasksProvider.tasks[index]
                            );
                          },
                          onTapForDelete: () {
                              Provider.of<TasksProvider>(context,listen: false).deleteTask(
                                tasksProvider.tasks[index]
                              );
                            },
                            onTapForEdite: (){
                              showDialog(context: context, builder: (context) {
                                return AddTaskDialog(
                                  textOnButton: language.edit,
                                  textOnDia: language.edityourtask,
                                  taskTitleController: taskTitleController,
                                  taskSubtitleController: subTaskTitleController,
                                  formkey: formKey,
                                  ontap: (){
                                    Provider.of<TasksProvider>(context , listen: false).editTask(
                                    TaskModel(
                                    title: taskTitleController.text,
                                    subTitle: subTaskTitleController.text,
                                    createdAt: DateTime.now()),tasksProvider.tasks[index]);
                                          taskTitleController.clear();
                                          subTaskTitleController.clear();
                                          Navigator.pop(context);
        
                                });
                              },);
                            },
                          );
                          
                          }
                        else {return const SizedBox();} 
                      },
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.all(24),
                          itemCount: tasksProvider.tasks.length,
                          itemBuilder: (context, index) {
                            if (tasksProvider.tasks[index].status) {
                              return TaskCard(
                                  taskModel: tasksProvider.tasks[index],
                                  onTapForCheck: () {
                                    Provider.of<TasksProvider>(context,listen: false).switchState(
                                    tasksProvider.tasks[index]
                                  );
                                  },
                                  onTapForDelete: (){
                                    Provider.of<TasksProvider>(context, listen: false)
                                    .deleteTask(tasksProvider.tasks[index]);
                                  },
                                  onTapForEdite: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddTaskDialog(
                                          textOnButton:  language.edit,
                                          textOnDia: language.edityourtask,
                                          taskTitleController: taskTitleController,
                                          taskSubtitleController:
                                              subTaskTitleController,
                                          formkey: formKey,
                                          ontap: () {
                                            Provider.of<TasksProvider>(context,
                                                    listen: false)
                                                .editTask(
                                                    TaskModel(
                                                      status: true,
                                                        title: taskTitleController
                                                            .text,
                                                        subTitle:
                                                            subTaskTitleController
                                                                .text,
                                                        createdAt: DateTime.now()),
                                                    tasksProvider.tasks[index]);
                                            taskTitleController.clear();
                                            subTaskTitleController.clear();
                                            Navigator.pop(context);
                                          });
                                    },
                                  );
                                }
                                  );
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                    
                  ]))
                ],
              )
              ),
            );
          }
        );
      }
    );
  }
}

