import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/controller/student_data_controller.dart';
import 'package:get_x/screens/add_students.dart';
import 'package:get_x/screens/grid_student.dart';
import 'package:get_x/screens/list_student.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final studentController = Get.put(StudentDataController());
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 12, 47, 52),
          foregroundColor: Colors.white54,
          centerTitle: true,
          title: const Text('Student Data'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    studentController.searchStudent(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () {
                       
                      }, 
                      icon: const Icon(Icons.search)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                ),
              ),
              const TabBar(tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.grid_view)),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: ListStudent(),
                    ),
                    Center(
                      child: GridStudent(), 
                    )
                  ]
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 12, 47, 52),
          child: const Icon(
            Icons.add,
            color: Colors.white54,
          ),
          onPressed: () {
            Get.to(() => AddStudents());
          }
        ),
      )
    );
  }
}