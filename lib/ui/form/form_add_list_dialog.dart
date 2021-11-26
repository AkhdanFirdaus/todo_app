import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/ui/alert/success_added_dialog.dart';
import 'package:uuid/uuid.dart';

void formAddListDialog(BuildContext context, [Todo? todo]) => showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: FormAddList(todo: todo),
      ),
    );

class FormAddList extends StatefulWidget {
  FormAddList({Key? key, this.todo}) : super(key: key);
  final Todo? todo;

  @override
  _FormAddListState createState() => _FormAddListState();
}

class _FormAddListState extends State<FormAddList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      bodyController.text = widget.todo!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add New Task",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              thickness: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color.fromRGBO(186, 191, 199, 1)),
                  color: Color.fromRGBO(108, 117, 125, 0.18),
                ),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "E.g. Washing Dishes",
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Detail",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                height: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color.fromRGBO(186, 191, 199, 1)),
                  color: Color.fromRGBO(108, 117, 125, 0.18),
                ),
                child: TextField(
                  controller: bodyController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "E.g. Mom asked me to washes the dishes",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 16),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                  todoBox
                      .add(
                    Todo(
                      uid: Uuid().v1(),
                      title: titleController.text,
                      body: bodyController.text,
                    ),
                  )
                      .then((value) {
                    successAddedDialog(context);
                  });
                },
                child: Text("Submit Data"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPrimary: Colors.white,
                  primary: Color(0xff4044C9),
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
