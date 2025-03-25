import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/controller/student_data_controller.dart';
import 'package:get_x/screens/edit_sudent.dart';

class DataScreen extends StatelessWidget {
  final int index;

  const DataScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final StudentDataController studentController =
        Get.find<StudentDataController>();

    return Obx(() {

      var data=studentController.studentData[index];

      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 12, 47, 52),
          foregroundColor: Colors.white54,
          centerTitle: true,
          title: const Text('Student Details'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.to(() => EditStudent(data: data));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Delete Student'),
                    content: const Text(
                      'Are you sure you want to delete this student?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back(); // Close dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          studentController.deleteStudent(data.id!);
                          Get.back(); // Close dialog
                          Get.back(); // Return to previous screen
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: 'student_image_${data.id}',
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(File(data.image)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', data.name),
                        const Divider(),
                        _buildDetailRow('Age', data.age),
                        const Divider(),
                        _buildDetailRow('Mobile', data.mobile),
                        const Divider(),
                        _buildDetailRow('ID', '${data.id}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 12, 47, 52),
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
