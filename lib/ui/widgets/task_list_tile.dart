import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_management_api/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback oneDeleteTap, onEditTap;

  const TaskListTile({
    super.key,
    required this.data,
    required this.oneDeleteTap,
    required this.onEditTap,
  });

  final TaskData data;

  Color _getStatusColor(String? status) {
    Map<String, Color> statusColors = {
      'New': Colors.blue,
      'Progress': Colors.purple,
      'Canceled': Colors.red,
      'Completed': Colors.green,
    };

    return statusColors[status] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown Title'),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.description ?? ''),
            Text(data.createdDate ?? ''),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    data.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getStatusColor(data.status),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onEditTap,
                  icon: const FaIcon(
                    FontAwesomeIcons.penToSquare,
                    color: CupertinoColors.systemGreen,
                  ),
                ),
                IconButton(
                  onPressed: oneDeleteTap,
                  icon: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
