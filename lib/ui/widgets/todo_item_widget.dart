import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/todo.dart';
import '../alert/confirm_dialog.dart';
import '../form/form_add_list_dialog.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    Key? key,
    required this.selected,
    required this.index,
    required this.todo,
  }) : super(key: key);

  final int selected;
  final int index;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Color.fromRGBO(64, 68, 201, 0.4),
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                Box<Todo?> todoBox = Hive.box<Todo?>('todoBox');
                todoBox.putAt(index, todo.toggleCompleted());
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  onTap: () => formAddListDialog(context, todo),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
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
                    onTap: () => confirmDialog(context, index),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
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
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
