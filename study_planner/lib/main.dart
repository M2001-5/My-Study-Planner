import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// STATIC: root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Study Planner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
      home: const StudyPlannerScreen(),
    );
  }
}

// STATIC: main screen (no data changes yet, so StatelessWidget)
class StudyPlannerScreen extends StatelessWidget {
  const StudyPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: top bar with the app title
      appBar: AppBar(
        title: const Text('My Study Planner'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // STATIC: heading above the list
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'My Study Goals',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // STATIC: goal card 1 (hard-coded)
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text('Mobile App Development'),
              subtitle: Text('5 study hours'),
            ),
          ),
          // STATIC: goal card 2 (hard-coded)
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text('Data Structures'),
              subtitle: Text('3 study hours'),
            ),
          ),
          // STATIC: goal card 3 (hard-coded)
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text('Research Methodology'),
              subtitle: Text('2 study hours'),
            ),
          ),
        ],
      ),
      // STATIC: floating button that does nothing yet
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}