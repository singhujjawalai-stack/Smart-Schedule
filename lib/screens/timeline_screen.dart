import 'package:flutter/material.dart';
import '../models/completion_model.dart';
import '../services/database_service.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key, required this.taskId});
  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timeline')),
      body: FutureBuilder<List<CompletionLog>>(
        future: AppDatabase.instance.getLogsForTask(taskId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final logs = snapshot.data!;
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return ListTile(
                title: Text(log.completedAt.toString()),
                subtitle: Text(log.missed ? 'Missed' : 'Completed - Dosage: ${log.dosageTaken}'),
              );
            },
          );
        },
      ),
    );
  }
}
