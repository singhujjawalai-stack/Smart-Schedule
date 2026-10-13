class CompletionLog {
  final String id;
  final String taskId;
  final DateTime completedAt;
  final int dosageTaken;
  final bool missed;

  CompletionLog({
    required this.id,
    required this.taskId,
    required this.completedAt,
    this.dosageTaken = 1,
    this.missed = false,
  });
}
