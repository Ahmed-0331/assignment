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
      title: 'Ostad UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CoursesUI(),
    );
  }
}

class CoursesUI extends StatelessWidget {
  const CoursesUI({super.key});

  final List<Map<String, String>> courses = const [
    {
      'image': 'https://cdn.ostad.app/course/cover/2024-12-18T15-24-44.114Z-Untitled-1%20(21).jpg',
      'title': 'SQA: Manual & Automated Testing',
      'batch': 'ব্যাচ ১৯',
      'videos': '৫৭ ঘন্টা পার্ট',
      'days': '৬ দিন বাকি',
    },
    {
      'image': 'https://cdn.ostad.app/course/cover/2024-12-17T11-35-19.890Z-Course%20Thumbnail%2012.jpg',
      'title': 'Full Stack Web Development with JavaScript (MERN)',
      'batch': 'ব্যাচ ৬',
      'videos': '৮৬ ঘন্টা পার্ট',
      'days': '৪০ দিন বাকি',
    },
    {
      'image': 'https://cdn.ostad.app/course/cover/2024-12-18T15-29-34.261Z-Untitled-1%20(23).jpg',
      'title': 'Full Stack Web Development with ASP.Net Core',
      'batch': 'ব্যাচ ৭',
      'videos': '৭৫ ঘন্টা পার্ট',
      'days': '৩৯ দিন বাকি',
    },
    {
      'image': 'https://cdn.ostad.app/course/cover/2024-12-19T15-48-52.487Z-Full-Stack-Web-Development-with-Python,-Django-&-React.jpg',
      'title': 'Full Stack Web Development with Python, Django & React',
      'batch': 'ব্যাচ ১৩',
      'videos': '৫৫ ঘন্টা পার্ট',
      'days': '৪৯ দিন বাকি',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Ostad UI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: courses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.57,
          ),
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseCard(course: course);
          },
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, String> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.network(
              course['image']!,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem(Icons.class_, course['batch']!),
                _infoItem(Icons.play_circle_fill, course['videos']!),
                _infoItem(Icons.calendar_today, course['days']!),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              course['title']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('বিস্তারিত দেখুন'),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, size: 12),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 10, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 8),
        ),
      ],
    );
  }
}
