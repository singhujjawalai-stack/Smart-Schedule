import 'package:flutter/material.dart';
import '../widgets/progress_chart.dart';
import '../services/database_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder(
        future: AppDatabase.instance.getAllTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final tasks = snapshot.data!;
          return Column(
            children: [
              const SizedBox(height: 200, child: ProgressChart()),
              Text('Total Tasks: ${tasks.length}', style: Theme.of(context).textTheme.headlineSmall),
              const Text('Timeline and completion rate below'),
            ],
          );
        },
      ),
    );
  }
}
