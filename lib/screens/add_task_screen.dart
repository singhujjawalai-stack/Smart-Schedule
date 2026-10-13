import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/task_model.dart';
import '../services/database_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  String _selectedType = 'general';
  String? _photoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            DropdownButton<String>(
              value: _selectedType,
              items: ['medicine', 'workout', 'study', 'general'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _selectedType = v!),
            ),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) setState(() => _photoPath = picked.path);
              },
              child: const Text('Attach Photo'),
            ),
            if (_photoPath != null) Text('Photo attached: $_photoPath'),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                final task = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _titleController.text,
                  type: _selectedType,
                  photoPath: _photoPath,
                  createdAt: DateTime.now(),
                );
                await AppDatabase.instance.insertTask(task);
                if (mounted) Navigator.pop(context);
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
