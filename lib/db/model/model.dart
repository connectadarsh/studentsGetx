import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String mobile;

  @HiveField(4)
  final String age;

  StudentModel({
    required this.name,
    required this.age,
    this.id,
    required this.image,
    required this.mobile
  });
}