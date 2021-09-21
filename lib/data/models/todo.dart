import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0, adapterName: 'TodoAdapter')
class Todo extends HiveObject {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final bool completed;

  Todo({
    required this.uid,
    required this.title,
    required this.body,
    this.completed = false,
  });
}
