import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/alert/confirm_dialog.dart';
import 'package:todo_app/ui/form/form_add_list_dialog.dart';

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
            child: PopupMenuButton(
              child: Icon(Icons.filter_alt_outlined),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sort By"),
                      Divider(),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.circle,
                            color: Color(0xff4044C9), size: 12),
                      ),
                      Text("Finished"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.circle,
                            color: Color(0xff82868B), size: 12),
                      ),
                      Text("Unfinished"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Task",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "24",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => formAddListDialog(context),
                      child: Text("Add New"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: Colors.white,
                        onPrimary: Color(0xff4044C9),
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            ),
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
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by task name...",
                    hintStyle: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xffBABFC7),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
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
                            child: Container(
                              height: 64,
                              decoration: selected == index
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        left: BorderSide(
                                          color: Color(0xff4044C9),
                                          width: 4,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(64, 68, 201, 0.4),
                                          blurRadius: 6,
                                          spreadRadius: 0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    )
                                  : BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        left: BorderSide(
                                          color: Color(0xffBABFC7),
                                          width: 4,
                                        ),
                                      ),
                                    ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Checkbox(
                                      value: todo.completed,
                                      onChanged: (value) {
                                        Box<Todo?> todoBox =
                                            Hive.box<Todo?>('todoBox');
                                        todoBox.putAt(
                                            index, todo.toggleCompleted());
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            todo.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(todo.body),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: PopupMenuButton(
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Color(0xff82868B),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  color: Color(0xffFFA800),
                                                ),
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Color(0xffFFA800),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: GestureDetector(
                                            onTap: () => confirmDialog(context),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Color(0xffF64E80),
                                                  ),
                                                ),
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Color(0xffF64E80),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
