import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_x/controller/add_image_controller.dart';
import 'package:get_x/controller/student_data_controller.dart';

class AddStudents extends StatelessWidget {
  AddStudents({super.key});
  
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
 
    final AddImageController imageController = Get.put(AddImageController());
    final StudentDataController studentController = Get.find<StudentDataController>();
    
    void onAddStudentButtonClicked() async {
      final name = nameController.text.trim();
      final age = ageController.text.trim();
      final mobile = mobileController.text.trim();
      
      if (name.isEmpty || age.isEmpty || mobile.isEmpty) {
        return;
      }
      
      if (!imageController.validateImage()) {
        return;
      }
      
  
      await studentController.addStudent(
        name: name,
        age: age,
        mobile: mobile,
        image: imageController.image.value,
      );
      
 
      Get.back();
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 47, 52),
        foregroundColor: Colors.white54,
        centerTitle: true,
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Obx(() => Container(
                  width: 200,
                  height: 250,
                  color: Colors.grey[400],
                  child: imageController.image.value.isNotEmpty
                      ? Image.file(
                          File(imageController.image.value),
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Text('Add image')),
                )),
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      imageController.pickImageFromCamera();
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.camera, size: 70),
                                  ),
                                  const Text('Camera'),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      imageController.pickImageFromGallery();
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.image, size: 70),
                                  ),
                                  const Text('Gallery'),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  label: const Text('Choose Photo'),
                  icon: const Icon(Icons.camera),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter the name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter the Age';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: mobileController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mobile',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter mobile number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onAddStudentButtonClicked();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}