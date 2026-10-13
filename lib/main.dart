import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/log_completion_screen.dart';
import 'services/schedule_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScheduleService().init();
  runApp(const SmartScheduleApp());
}

class SmartScheduleApp extends StatelessWidget {
  const SmartScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Schedule',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddTaskScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/log': (context) => const LogCompletionScreen(taskId: ''),
      },
    );
  }
}
