import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/controller/student_data_controller.dart';
import 'package:get_x/screens/data_screen.dart';
import 'package:get_x/screens/edit_sudent.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.put(StudentDataController());

    return Obx(() {
      // final studentList =
      //     studentController.filteredStudentData.isEmpty &&
      //             Get.find<StudentDataController>().searchStudent == null
      //         ? studentController.studentData
      //         : studentController.filteredStudentData;

      // if (studentList.isEmpty) {
      //   return const Center(child: Text('Add Student Details'));
      // }

      // return
      final studentList = studentController.studentData;
      return (studentList.isEmpty)
          ? Center(child: Text('Add Student'))
          : ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              return ListTile(
                onTap: () {
                  Get.to(() => DataScreen(data: data));
                },
                title: Text(data.name),
                subtitle: Text(data.age),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(data.image)),
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text(
                                'Are you sure you want to edit?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.to(() => EditStudent(data: data));
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text(
                                'Are you sure you want to delete?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    studentController.deleteStudent(data.id!);
                                    Get.back();
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
    });
  }
}
