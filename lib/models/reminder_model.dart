class ReminderSetting {
  final String taskId;
  final String mode; // notification, alarm
  final bool silent;
  final String recurrence; // daily, weekly, monthly, hourly, custom
  final int? customInterval;
  final DateTime? nextTrigger;

  ReminderSetting({
    required this.taskId,
    required this.mode,
    this.silent = false,
    required this.recurrence,
    this.customInterval,
    this.nextTrigger,
  });
}
