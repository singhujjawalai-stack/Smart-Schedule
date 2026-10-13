import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'dashboard_screen.dart';
import 'log_completion_screen.dart';
import '../widgets/progress_chart.dart';
import '../services/database_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Schedule'),
        actions: [
          IconButton(icon: const Icon(Icons.dashboard), onPressed: () => Navigator.pushNamed(context, '/dashboard')),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: ProgressChart()),
          FutureBuilder(
            future: AppDatabase.instance.getAllTasks(),
            builder: (context, snapshot) {
              final count = snapshot.hasData ? snapshot.data!.length : 0;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Tasks: $count | Tap + to add or log', style: Theme.of(context).textTheme.titleMedium),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
