import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentManagementApp(),
    );
  }
}

class StudentManagementApp extends StatefulWidget {
  @override
  State<StudentManagementApp> createState() => _StudentManagementAppState();
}

class _StudentManagementAppState extends State<StudentManagementApp> {
  int selectedIndex = 0;
  List<Map<String, String>> students = [];

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String selectedImage = 'assets/images/Stud_2.png';

  void addStudent() {
    if (nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        courseController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      setState(() {
        students.add({
          "name": nameController.text,
          "age": ageController.text,
          "course": courseController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "image": selectedImage,
        });
        nameController.clear();
        ageController.clear();
        courseController.clear();
        emailController.clear();
        phoneController.clear();

        selectedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(students),
      AddStudentScreen(
        nameController,
        ageController,
        courseController,
        emailController,
        phoneController,
        selectedImage,
        (value) {
          setState(() {
            selectedImage = value;
          });
        },
        addStudent,
      ),

      const ProfileScreen(),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 167, 214),

      appBar: AppBar(
        title: const Text("Student Management App"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 222, 227, 230),
        foregroundColor: Colors.white,
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 8, 125, 214),

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> students;

  const HomeScreen(this.students, {super.key});

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const Center(
        child: Text(
          "No Students Added",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: students.length,

      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(students[index]["image"]!),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        students[index]["name"]!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Age: ${students[index]["age"]}"),
                      Text("Course: ${students[index]["course"]}"),
                      Text("Email: ${students[index]["email"]}"),
                      Text("Phone: ${students[index]["phone"]}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddStudentScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController courseController;
  final TextEditingController emailContrller;
  final TextEditingController phoneController;

  final String selectedImage;
  final Function(String) onImageChanged;
  final VoidCallback addStudent;

  const AddStudentScreen(
    this.nameController,
    this.ageController,
    this.courseController,
    this.emailContrller,
    this.phoneController,
    this.selectedImage,
    this.onImageChanged,
    this.addStudent, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),

      child: Column(
        children: [
          CircleAvatar(radius: 60, backgroundImage: AssetImage(selectedImage)),

          const SizedBox(height: 15),

          DropdownButton<String>(
            value: selectedImage,
            isExpanded: true,

            items: const [
              DropdownMenuItem(
                value: 'assets/images/Stud_1.webp',
                child: Text("Student image 1"),
              ),
              DropdownMenuItem(
                value: 'assets/images/Stud_2.png',
                child: Text("Student image 2"),
              ),

              DropdownMenuItem(
                value: 'assets/images/stud_3.png',
                child: Text("Student image 3"),
              ),
            ],

            onChanged: (value) {
              onImageChanged(value!);
            },
          ),
          const SizedBox(height: 20),

          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: ageController,
            decoration: const InputDecoration(labelText: "Age"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: courseController,
            decoration: const InputDecoration(labelText: "Course"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: emailContrller,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: "Phone"),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: addStudent,
            child: const Text('Add Student'),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 20)),
            SizedBox(height: 20),
            Text(
              "Anaswara",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "BCA Student",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "anaswara@gmail.com",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
