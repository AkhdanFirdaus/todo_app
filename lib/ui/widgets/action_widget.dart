import 'package:flutter/material.dart';

import '../form/form_add_list_dialog.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              style:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
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
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        )
      ],
    );
  }
}
