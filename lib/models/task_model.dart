class Task {
  final String id;
  final String title;
  final String description;
  final String type; // medicine, workout, study, general
  final Map<String, dynamic>? medicineDetails;
  final String? photoPath;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.type,
    this.medicineDetails,
    this.photoPath,
    required this.createdAt,
  });
}
