import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../../../core/utils/pregnancy_calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YogaProvider extends ChangeNotifier {
  YogaCategory? _selectedCategory;
  int _currentWeek = 12;

  YogaCategory? get selectedCategory => _selectedCategory;
  int get currentWeek => _currentWeek;
  Trimester get currentTrimester {
    final t = PregnancyCalculator.trimester(_currentWeek);
    if (t == 1) return Trimester.first;
    if (t == 2) return Trimester.second;
    return Trimester.third;
  }

  List<Exercise> get filteredExercises {
    var exercises = allExercises.where((e) =>
        e.trimesters.contains(currentTrimester) ||
        e.trimesters.contains(Trimester.all)).toList();
    if (_selectedCategory != null) {
      exercises = exercises.where((e) => e.category == _selectedCategory).toList();
    }
    return exercises;
  }

  YogaProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final lmpStr = prefs.getString('lmpDate');
    if (lmpStr != null) {
      final lmp = DateTime.tryParse(lmpStr);
      if (lmp != null) {
        _currentWeek = PregnancyCalculator.currentWeek(lmp);
      }
    }
    notifyListeners();
  }

  void setCategory(YogaCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
