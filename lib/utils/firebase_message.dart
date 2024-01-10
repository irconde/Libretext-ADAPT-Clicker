import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class FirebaseMessage {

  FirebaseMessage({required this.title, required this.body, required this.route});

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? body;

  @HiveField(2)
  String? route;
}