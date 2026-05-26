import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show RepeatInterval;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/notification_service.dart';

enum ReminderType { medicine, doctor, water, tip, custom }

class Reminder {
  final String id;
  final String title;
  final String? description;
  final ReminderType type;
  final TimeOfDay time;
  final bool isActive;
  final DateTime? date;
  final bool isDaily;

  Reminder({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.time,
    this.isActive = true,
    this.date,
    this.isDaily = true,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type.index,
        'timeHour': time.hour,
        'timeMinute': time.minute,
        'isActive': isActive,
        'date': date?.toIso8601String(),
        'isDaily': isDaily,
      };

  factory Reminder.fromMap(Map m) => Reminder(
        id: m['id'],
        title: m['title'],
        description: m['description'],
        type: ReminderType.values[m['type']],
        time: TimeOfDay(hour: m['timeHour'], minute: m['timeMinute']),
        isActive: m['isActive'],
        date: m['date'] != null ? DateTime.tryParse(m['date']) : null,
        isDaily: m['isDaily'] ?? true,
      );

  Reminder copyWith({bool? isActive}) => Reminder(
        id: id,
        title: title,
        description: description,
        type: type,
        time: time,
        isActive: isActive ?? this.isActive,
        date: date,
        isDaily: isDaily,
      );
}

class ReminderProvider extends ChangeNotifier {
  final List<Reminder> _reminders = [];
  final _uuid = const Uuid();

  List<Reminder> get reminders => List.unmodifiable(_reminders);
  List<Reminder> get activeReminders => _reminders.where((r) => r.isActive).toList();

  ReminderProvider() {
    _load();
  }

  Future<void> _load() async {
    final box = Hive.box('reminders');
    final raw = box.get('list', defaultValue: []);
    _reminders.clear();
    for (final m in raw) {
      try {
        _reminders.add(Reminder.fromMap(Map<String, dynamic>.from(m)));
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> _save() async {
    final box = Hive.box('reminders');
    await box.put('list', _reminders.map((r) => r.toMap()).toList());
  }

  Future<void> addReminder({
    required String title,
    String? description,
    required ReminderType type,
    required TimeOfDay time,
    DateTime? date,
    bool isDaily = true,
  }) async {
    final id = _uuid.v4();
    final reminder = Reminder(
      id: id,
      title: title,
      description: description,
      type: type,
      time: time,
      date: date,
      isDaily: isDaily,
    );

    _reminders.add(reminder);
    await _save();

    // Schedule notification
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await NotificationService.instance.scheduleNotification(
      id: id.hashCode,
      title: '🌸 $title',
      body: description ?? 'Your reminder from Nitara',
      scheduledDate: scheduledDate,
      repeat: isDaily ? RepeatInterval.daily : null,
    );

    notifyListeners();
  }

  Future<void> toggleReminder(String id) async {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index >= 0) {
      final r = _reminders[index];
      _reminders[index] = r.copyWith(isActive: !r.isActive);
      if (!_reminders[index].isActive) {
        await NotificationService.instance.cancelNotification(r.id.hashCode);
      }
      await _save();
      notifyListeners();
    }
  }

  Future<void> deleteReminder(String id) async {
    _reminders.removeWhere((r) => r.id == id);
    await NotificationService.instance.cancelNotification(id.hashCode);
    await _save();
    notifyListeners();
  }
}
