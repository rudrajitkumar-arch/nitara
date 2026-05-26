import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HealthEntry {
  final DateTime date;
  final double weight;
  final int waterGlasses;
  final double sleepHours;
  final int moodIndex; // 0=terrible, 1=bad, 2=ok, 3=good, 4=great

  HealthEntry({
    required this.date,
    this.weight = 0,
    this.waterGlasses = 0,
    this.sleepHours = 0,
    this.moodIndex = 2,
  });

  Map<String, dynamic> toMap() => {
        'date': date.toIso8601String(),
        'weight': weight,
        'waterGlasses': waterGlasses,
        'sleepHours': sleepHours,
        'moodIndex': moodIndex,
      };

  factory HealthEntry.fromMap(Map m) => HealthEntry(
        date: DateTime.parse(m['date']),
        weight: (m['weight'] as num).toDouble(),
        waterGlasses: m['waterGlasses'] as int,
        sleepHours: (m['sleepHours'] as num).toDouble(),
        moodIndex: m['moodIndex'] as int,
      );
}

class HealthProvider extends ChangeNotifier {
  final List<HealthEntry> _entries = [];
  HealthEntry? _todayEntry;
  bool _isLoading = false;

  List<HealthEntry> get entries => List.unmodifiable(_entries);
  HealthEntry? get todayEntry => _todayEntry;
  bool get isLoading => _isLoading;

  int get todayWaterGlasses => _todayEntry?.waterGlasses ?? 0;
  double get latestWeight {
    final w = _entries.where((e) => e.weight > 0).toList();
    return w.isNotEmpty ? w.last.weight : 0;
  }
  double get lastSleepHours => _todayEntry?.sleepHours ?? 0;
  int get todayMoodIndex => _todayEntry?.moodIndex ?? 2;

  static const List<String> moodEmojis = ['😞', '😕', '😊', '😃', '🥰'];
  static const List<String> moodLabels = ['Terrible', 'Not Great', 'Okay', 'Good', 'Great'];
  String get todayMoodEmoji => moodEmojis[todayMoodIndex];

  HealthProvider() {
    _load();
  }

  Future<void> _load() async {
    final box = Hive.box('health_data');
    final raw = box.get('entries', defaultValue: []);
    _entries.clear();
    for (final m in raw) {
      try {
        _entries.add(HealthEntry.fromMap(Map<String, dynamic>.from(m)));
      } catch (_) {}
    }
    _findTodayEntry();
    notifyListeners();
  }

  void _findTodayEntry() {
    final today = DateTime.now();
    _todayEntry = _entries.where((e) =>
        e.date.year == today.year &&
        e.date.month == today.month &&
        e.date.day == today.day).firstOrNull;
  }

  Future<void> _save() async {
    final box = Hive.box('health_data');
    await box.put('entries', _entries.map((e) => e.toMap()).toList());
  }

  Future<void> logWater(int glasses) async {
    final today = DateTime.now();
    final todayEntry = HealthEntry(
      date: today,
      weight: _todayEntry?.weight ?? 0,
      waterGlasses: glasses,
      sleepHours: _todayEntry?.sleepHours ?? 0,
      moodIndex: _todayEntry?.moodIndex ?? 2,
    );
    _upsertToday(todayEntry);
    await _save();
    notifyListeners();
  }

  Future<void> logWeight(double weight) async {
    final today = DateTime.now();
    final todayEntry = HealthEntry(
      date: today,
      weight: weight,
      waterGlasses: _todayEntry?.waterGlasses ?? 0,
      sleepHours: _todayEntry?.sleepHours ?? 0,
      moodIndex: _todayEntry?.moodIndex ?? 2,
    );
    _upsertToday(todayEntry);
    await _save();
    notifyListeners();
  }

  Future<void> logSleep(double hours) async {
    final today = DateTime.now();
    final todayEntry = HealthEntry(
      date: today,
      weight: _todayEntry?.weight ?? 0,
      waterGlasses: _todayEntry?.waterGlasses ?? 0,
      sleepHours: hours,
      moodIndex: _todayEntry?.moodIndex ?? 2,
    );
    _upsertToday(todayEntry);
    await _save();
    notifyListeners();
  }

  Future<void> logMood(int index) async {
    final today = DateTime.now();
    final todayEntry = HealthEntry(
      date: today,
      weight: _todayEntry?.weight ?? 0,
      waterGlasses: _todayEntry?.waterGlasses ?? 0,
      sleepHours: _todayEntry?.sleepHours ?? 0,
      moodIndex: index,
    );
    _upsertToday(todayEntry);
    await _save();
    notifyListeners();
  }

  void _upsertToday(HealthEntry entry) {
    final today = DateTime.now();
    _entries.removeWhere((e) =>
        e.date.year == today.year &&
        e.date.month == today.month &&
        e.date.day == today.day);
    _entries.add(entry);
    _todayEntry = entry;
  }

  /// Returns last N entries for chart display
  List<HealthEntry> getLastNEntries(int n) {
    final sorted = [..._entries]..sort((a, b) => a.date.compareTo(b.date));
    return sorted.length > n ? sorted.sublist(sorted.length - n) : sorted;
  }
}
