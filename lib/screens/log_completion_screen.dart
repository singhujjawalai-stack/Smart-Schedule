import 'package:flutter/material.dart';
import '../models/completion_model.dart';
import '../services/database_service.dart';

class LogCompletionScreen extends StatelessWidget {
  final String taskId;
  const LogCompletionScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Completion')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mark task as completed or missed'),
            ElevatedButton(
              onPressed: () async {
                await AppDatabase.instance.insertLog(CompletionLog(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  taskId: taskId,
                  completedAt: DateTime.now(),
                  dosageTaken: 1,
                  missed: false,
                ));
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Completed'),
            ),
            ElevatedButton(
              onPressed: () async {
                await AppDatabase.instance.insertLog(CompletionLog(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  taskId: taskId,
                  completedAt: DateTime.now(),
                  dosageTaken: 0,
                  missed: true,
                ));
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Missed'),
            ),
          ],
        ),
      ),
    );
  }
}
