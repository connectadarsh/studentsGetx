// import 'package:flutter/material.dart';
// import 'package:get_x/db/model/model.dart';
// import 'package:hive/hive.dart';

// // Define studentListNotifier
// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

// // Function to get Hive box
// Box<StudentModel> getStudentBox() {
//   return Hive.box<StudentModel>('student_box');
// }

// // Add Student
// Future<void> addStudent(StudentModel value) async {
//   final studentBox = getStudentBox();
//   await studentBox.add(value);
//   await getAllStudents(); // Refresh list after adding
// }

// // Get all students
// Future<void> getAllStudents() async {
//   final studentBox = getStudentBox();
//   studentListNotifier.value = studentBox.values.toList();
//   studentListNotifier.notifyListeners(); // Notify UI to update
// }

// // Delete Student
// Future<void> deleteStudent(int key) async {
//   final studentBox = getStudentBox();
//   await studentBox.delete(key);
//   await getAllStudents(); // Refresh list after deletion
// }

// // Search Student
// Future<void> searchStudent(String value) async {
//   final studentBox = getStudentBox();
//   final allStudents = studentBox.values.toList();
  
//   studentListNotifier.value = allStudents
//       .where((student) => student.name.toLowerCase().contains(value.toLowerCase()))
//       .toList();
  
//   studentListNotifier.notifyListeners(); // Notify UI to update
// }

// // Update Student
// Future<void> updateStudent(int key, StudentModel updatedValue) async {
//   final studentBox = getStudentBox();
//   await studentBox.put(key, updatedValue);
//   await getAllStudents(); // Refresh list after update
// }
