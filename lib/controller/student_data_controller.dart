import 'package:get/get.dart';
import 'package:get_x/db/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentDataController extends GetxController {
  var studentData = <StudentModel>[].obs;
  final filteredStudentData = <StudentModel>[].obs; // Stores search results
  late Box<StudentModel> student_box;

  @override
  void onInit() {
    super.onInit();
    student_box = Hive.box<StudentModel>('student_box');
    studentData.addAll(student_box.values.toList());
  }

  // -------Add Student------
  Future<void> addStudent({
    required String name,
    required String age,
    required String mobile,
    required String image,
  }) async {
  
    final student = StudentModel(
      name: name,
      age: age,
      mobile: mobile,
      image: image,
    );

  
    final int key = await student_box.add(student);

   
    final updatedStudent = StudentModel(
      id: key,
      name: name,
      age: age,
      mobile: mobile,
      image: image
    );

   
    student_box.put(key, updatedStudent);
    // student_box.add(student);
    // Add to observable list
    studentData.add(student);
  }

  // ------------Delete Student----------
  void deleteStudent(int key) {
    // Remove from Hive
    student_box.delete(key);

    // Remove from observable list
    studentData.removeWhere((student) => student.id == key);
  }
  // -------------------Edit Student--------------------

  void editStudentData({
    required int id, // Use id instead of index
    required String name,
    required String age,
    required String mobile,
    required String image,
  }) {
    final editedStudent = StudentModel(
      id: id, // Include id
      name: name,
      age: age,
      mobile: mobile,
      image: image,
    );

    // Update in Hive using the ID as the key
    student_box.put(id, editedStudent);

    // Update observable list
    final index = studentData.indexWhere((student) => student.id == id);
    if (index != -1) {
      studentData[index] = editedStudent;
      studentData.refresh();
    }
  }

  // -------------------Search--------------
  void searchStudent(String query) {
    if (query.isEmpty) {
      // filteredStudentData.assignAll(studentData);
         studentData.assignAll(student_box.values.toList());
    } else {
      // filteredStudentData.assignAll(
      //   studentData.where((student) {
      //     return student.name.toLowerCase().contains(query.toLowerCase());
      //   }).toList(),
      // );
      var filteredList=student_box.values.where((student) {
          return student.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
        studentData.assignAll(filteredList);
    }
    studentData.refresh();
  }
}
