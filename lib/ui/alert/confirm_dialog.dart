import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/ui/alert/success_deleted_dialog.dart';

void confirmDialog(BuildContext context, int index) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Color(0xffEA5455),
            ),
            SizedBox(height: 16),
            Text(
              "Are you sure want to delete this task?",
              style: TextStyle(
                color: Color(0xffEA5455),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPrimary: Colors.white,
                  primary: Color(0xff82868B),
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Box<Todo?> todoBox = Hive.box<Todo?>('todoBox');
                  todoBox.deleteAt(index).then((value) {
                    successDeletedDialog(context);
                  });
                },
                child: Text("Yes, delete it"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPrimary: Colors.white,
                  primary: Color(0xffEA5455),
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          )
        ],
        actionsPadding: const EdgeInsets.only(top: 16, bottom: 24),
        contentPadding: const EdgeInsets.only(top: 24),
      ),
    );
