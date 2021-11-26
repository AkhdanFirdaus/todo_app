import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/todo.dart';
import 'ui/widgets/action_widget.dart';
import 'ui/widgets/filter_widget.dart';
import 'ui/widgets/todo_item_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Todo?>(TodoAdapter());
  await Hive.openBox<Todo?>('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyTodo(),
    );
  }
}

class MyTodo extends StatefulWidget {
  const MyTodo({Key? key}) : super(key: key);

  @override
  State<MyTodo> createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  bool isChecked = false;
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4044C9),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.android_outlined),
        ),
        centerTitle: true,
        title: Text(
          "Todo App",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilterWidget(),
          ),
        ],
        elevation: 0,
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
            child: ActionWidget(),
          ),
          preferredSize: Size.fromHeight(85),
        ),
      ),
      body: Container(
        color: Color(0xff4044C9),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: 16,
                ),
                padding: EdgeInsets.only(left: 16.0),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color.fromRGBO(186, 191, 199, 1)),
                  color: Color.fromRGBO(108, 117, 125, 0.18),
                ),
                child: SearchWidget(),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<Todo?>('todoBox').listenable(),
                  builder: (context, Box<Todo?> box, widget) {
                    if (box.values.isEmpty) {
                      return Center(child: Text("Todo Is Empty"));
                    }
                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        final todo = box.getAt(index)!;
                        return Padding(
                          key: Key('item-$index'),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = selected == index ? -1 : index;
                              });
                            },
                            child: TodoItemWidget(
                              selected: selected,
                              index: index,
                              todo: todo,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
