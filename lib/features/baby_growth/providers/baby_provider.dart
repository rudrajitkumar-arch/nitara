import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/pregnancy_calculator.dart';
import '../models/baby_data.dart';

class BabyProvider extends ChangeNotifier {
  int _currentWeek = 12;
  DateTime? _lmpDate;

  int get currentWeek => _currentWeek;
  DateTime? get lmpDate => _lmpDate;

  BabyWeekData get currentWeekData {
    final idx = (_currentWeek - 1).clamp(0, allWeeksData.length - 1);
    return allWeeksData[idx];
  }

  BabyWeekData weekData(int week) {
    final idx = (week - 1).clamp(0, allWeeksData.length - 1);
    return allWeeksData[idx];
  }

  int get trimester => PregnancyCalculator.trimester(_currentWeek);
  String get trimesterLabel => PregnancyCalculator.trimesterLabel(_currentWeek);
  double get overallProgress => PregnancyCalculator.overallProgress(_currentWeek);
  double get trimesterProgress => PregnancyCalculator.trimesterProgress(_currentWeek);
  int get daysRemaining => _lmpDate != null ? PregnancyCalculator.daysRemaining(_lmpDate!) : 0;
  DateTime get dueDate => _lmpDate != null ? PregnancyCalculator.dueDate(_lmpDate!) : DateTime.now().add(const Duration(days: 140));

  BabyProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final lmpStr = prefs.getString('lmpDate');
    if (lmpStr != null) {
      _lmpDate = DateTime.tryParse(lmpStr);
      if (_lmpDate != null) {
        _currentWeek = PregnancyCalculator.currentWeek(_lmpDate!);
      }
    }
    notifyListeners();
  }

  Future<void> setLmpDate(DateTime date) async {
    _lmpDate = date;
    _currentWeek = PregnancyCalculator.currentWeek(date);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lmpDate', date.toIso8601String());
    notifyListeners();
  }
}
