import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final controllerProvider = ChangeNotifierProvider<ControllerProvider>((ref) {
  return ControllerProvider();
});

class ControllerProvider extends ChangeNotifier {
  ControllerProvider();

  TimeOfDay start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay ends = TimeOfDay(hour: 0, minute: 0);
  int workDays = 22;
  int monthlySalary = 0;

  double hourlyRate = 0;

  void updateStart(TimeOfDay time) {
    start = time;
    notifyListeners();
  }

  void updateEnd(TimeOfDay time) {
    ends = time;
    notifyListeners();
  }

  void updateWorkDays(int days) {
    workDays = days;
    notifyListeners();
  }

  void updateSalary(int salary) {
    monthlySalary = salary;
    notifyListeners();
  }

  void calculateRate() {
    var startTime = toDouble(start);
    var endTime = toDouble(ends);
    double differenceTime = endTime - startTime;
    double workingHours = differenceTime * workDays;

    hourlyRate = (monthlySalary / workingHours);
    notifyListeners();
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}
