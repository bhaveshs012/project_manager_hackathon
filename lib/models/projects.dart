class Project {
  Project( {
    required this.name,
    required this.id,
    required this.image,
    required this.desc,
    required this.totalTasks,
     required this.taskCompleted,
  });
  final String name;
  final int image;
  final String id;
  final String desc;
  final int totalTasks;
  final int taskCompleted;
}
