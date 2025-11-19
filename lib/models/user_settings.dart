import 'package:hive/hive.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 2)
class UserSettings extends HiveObject {
  @HiveField(0)
  int weeklyGoal;

  @HiveField(1)
  int currentStreak;

  @HiveField(2)
  int bestStreak;

  @HiveField(3)
  DateTime? lastSessionDate;

  @HiveField(4)
  String? selectedTheme;

  UserSettings({
    this.weeklyGoal = 100,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.lastSessionDate,
    this.selectedTheme = 'blue',
  });

  void updateStreak(DateTime newSessionDate) {
    if (lastSessionDate == null) {
      currentStreak = 1;
      lastSessionDate = newSessionDate;
      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
      }
      return;
    }

    final daysDifference = newSessionDate.difference(lastSessionDate!).inDays;

    if (daysDifference == 1) {
      // Día consecutivo
      currentStreak++;
      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
      }
    } else if (daysDifference > 1) {
      // Se rompió la racha
      currentStreak = 1;
    }
    // Si es el mismo día, no cambia la racha

    lastSessionDate = newSessionDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'weeklyGoal': weeklyGoal,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      'lastSessionDate': lastSessionDate?.toIso8601String(),
      'selectedTheme': selectedTheme,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      weeklyGoal: json['weeklyGoal'] as int? ?? 100,
      currentStreak: json['currentStreak'] as int? ?? 0,
      bestStreak: json['bestStreak'] as int? ?? 0,
      lastSessionDate: json['lastSessionDate'] != null
          ? DateTime.parse(json['lastSessionDate'] as String)
          : null,
      selectedTheme: json['selectedTheme'] as String? ?? 'blue',
    );
  }
}
