import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/controller/student_data_controller.dart';
import 'package:get_x/screens/data_screen.dart';
import 'package:get_x/screens/edit_sudent.dart';


class GridStudent extends StatelessWidget {
  const GridStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentDataController>();
    
    return Obx(() {
      // final studentList = studentController.filteredStudentData.isEmpty && 
      //                     Get.find<StudentDataController>().searchStudent == null ? 
      //                     studentController.studentData : 
      //                     studentController.filteredStudentData;
      
      // if (studentList.isEmpty) {
      //   return const Center(
      //     child: Text('Add Student Details'),
      //   );
      // }
      
      // return 
      final studentGrid=studentController.studentData;
      return (studentGrid.isEmpty)
      ?Center(child: Text('Add Student'),)
     : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: studentGrid.length,
        itemBuilder: (context, index) {
          final data = studentGrid[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => DataScreen(data: data));
            },
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      child: Image.file(
                        File(data.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Age: ${data.age}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Edit student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.to(() => EditStudent(data: data));
                                  },
                                  child: const Text('Yes')
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('No')
                                )
                              ],
                            )
                          );
                        },
                        icon: const Icon(Icons.edit, size: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Delete student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    studentController.deleteStudent(data.id!);
                                    Get.back();
                                  },
                                  child: const Text('Yes')
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('No')
                                )
                              ],
                            )
                          );
                        },
                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}