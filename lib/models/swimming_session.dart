import 'package:hive/hive.dart';

part 'swimming_session.g.dart';

@HiveType(typeId: 1)
class SwimmingSession extends HiveObject {
  @HiveField(0)
  int pools;

  @HiveField(1)
  int meters;

  @HiveField(2)
  DateTime date;

  SwimmingSession({
    required this.pools,
    required this.date,
  }) : meters = pools * 25;

  Map<String, dynamic> toJson() {
    return {
      'pools': pools,
      'meters': meters,
      'date': date.toIso8601String(),
    };
  }

  factory SwimmingSession.fromJson(Map<String, dynamic> json) {
    return SwimmingSession(
      pools: json['pools'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
