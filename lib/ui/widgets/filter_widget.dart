import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(Icons.filter_alt_outlined),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                child: Icon(Icons.circle, color: Color(0xff4044C9), size: 12),
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
                child: Icon(Icons.circle, color: Color(0xff82868B), size: 12),
              ),
              Text("Unfinished"),
            ],
          ),
        ),
      ],
    );
  }
}
