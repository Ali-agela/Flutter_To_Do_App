import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/task_models.dart';
import 'package:flutter_to_do_app/widgets/cards/taskcard.dart';
import 'package:flutter_to_do_app/widgets/dialogs/addtaddialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController subTaskTitleController = TextEditingController();
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddTaskDialog(
                      taskTitleController: taskTitleController,
                      taskSubtitleController: subTaskTitleController,
                      formkey: formKey,
                      ontap: () {
                        tasks.add(TaskModel(
                            title: taskTitleController.text,
                            subtitle: subTaskTitleController.text,
                            createdat: DateTime.now()));
                        setState(() {
                        taskTitleController.clear();
                        subTaskTitleController.clear();
                        Navigator.pop(context);
                        });
                      });
                });
          }),
      appBar: AppBar(
        title: const Text("ToDo"),
      ),
      body:  DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const  TabBar(tabs: [
            Tab(text:"Waiting"),
            Tab(text: "Completed",)
          ]),
          Expanded(child: TabBarView(children: [
            ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: tasks.length,
              itemBuilder: (context, index){
                if (!tasks[index].status){
                return  TaskCard(taskModel: tasks[index], onTapForCheck:(){
                  tasks[index].status=true;
                  setState(() {});
                  },
                  onTapForDelete: () {
                          tasks.removeAt(index);
                          setState(() {});
                        },
                  );
                  
                  }
                else {return const SizedBox();} 
              },
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    if (tasks[index].status) {
                      return TaskCard(
                          taskModel: tasks[index],
                          onTapForCheck: () {
                            tasks[index].status = false;
                            setState(() {});
                          },
                          onTapForDelete: (){
                            tasks.removeAt(index);
                            setState(() {});
                          },
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
}
