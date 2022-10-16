class TodoModel {
  final String id;
  final String description;
  final bool complate;

  TodoModel(
      {required this.id, required this.description, this.complate = false});
}
