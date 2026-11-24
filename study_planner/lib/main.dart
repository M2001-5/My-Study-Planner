import 'package:material_ui/material_ui.dart';

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

// STATIC + LOGIC: main screen (StatefulWidget because the data changes)
class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  // LOGIC: the data (list of maps with subject, hours, done)
  final List<Map<String, dynamic>> _goals = [
    {'subject': 'Mobile App Development', 'hours': 5, 'done': false},
    {'subject': 'Data Structures', 'hours': 3, 'done': false},
    {'subject': 'Research Methodology', 'hours': 2, 'done': true},
  ];

  // LOGIC: counter used to name the sample goals
  int _sampleCount = 0;

  // LOGIC: add a sample goal (setState rebuilds the screen)
  void _addSampleGoal() {
    setState(() {
      _sampleCount = _sampleCount + 1;
      _goals.add({
        'subject': 'Sample goal $_sampleCount',
        'hours': 2,
        'done': false,
      });
    });
  }

  // LOGIC: mark a goal as done / not done
  void _toggleGoal(int index) {
    setState(() {
      _goals[index]['done'] = !(_goals[index]['done'] as bool);
    });
  }

  // LOGIC: delete a goal
  void _deleteGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: top bar with the app title
      appBar: AppBar(
        title: const Text('My Study Planner'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // STATIC: heading above the list
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'My Study Goals',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // STATIC: list built from the data (no hard-coded cards)
          Expanded(
            child: ListView.builder(
              // CONNECTION 1: the UI reads its data from the LOGIC list
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> goal = _goals[index];
                final bool done = goal['done'] as bool;

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      activeColor: Colors.indigo,
                      value: done,
                      onChanged: (value) {
                        _toggleGoal(index);
                      },
                    ),
                    title: Text(
                      goal['subject'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration:
                            done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('${goal['hours']} study hours'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      // CONNECTION 2: the UI calls LOGIC functions
                      onPressed: () {
                        _deleteGoal(index);
                      },
                    ),
                    onTap: () {
                      _toggleGoal(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // STATIC: button that adds a sample goal for now
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () {
          _addSampleGoal();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}