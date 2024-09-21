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
