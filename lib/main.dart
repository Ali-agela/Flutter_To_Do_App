import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        setState(() {
          tasks.add(TaskModel(
              title: "new task", createdat: DateTime.now(), subtitle: "do it"));
        });
      }),
      appBar: AppBar(
        title: const Text("To Do App"),
        backgroundColor: Colors.blue,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Text("waiting "),
                Text("Finished"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                  itemCount: tasks.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  itemBuilder: (context, index) {
                    if (!tasks[index].status) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(tasks[index].title),
                          subtitle: Text(tasks[index].subtitle ?? ""),
                          trailing: Checkbox(
                              value: tasks[index].status,
                              onChanged: (check) => setState(() {
                                    tasks[index].status = true;
                                  })),
                          tileColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                ListView.builder(
                  itemCount: tasks.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  itemBuilder: (context, index) {
                    if (tasks[index].status) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(tasks[index].title),
                          subtitle: Text(tasks[index].subtitle ?? ""),
                          trailing: Checkbox(
                              value: tasks[index].status,
                              onChanged: (check) => setState(() {
                                    tasks[index].status = false;
                                  })),
                          tileColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskModel {
  String title;
  String? subtitle;
  bool status;
  DateTime createdat;
  TaskModel(
      {required this.title,
      this.status = false,
      required this.createdat,
      this.subtitle});
}
