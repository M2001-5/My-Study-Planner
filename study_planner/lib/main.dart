import 'package:material_ui/material_ui.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Study Planner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const StudyPlannerScreen(),
    );
  }
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  List<Map<String, dynamic>> goals = [
    {
      'title': 'Mobile App Development',
      'hours': 4,
      'done': false,
    },
    {
      'title': 'Data Structures',
      'hours': 6,
      'done': false,
    },
    {
      'title': 'Research Methodology',
      'hours': 5,
      'done': true,
    },
  ];

  int sampleCount = 0;

  int get totalHours {
    return goals.fold(0, (sum, goal) {
      return sum + (goal['hours'] as int);
    });
  }

  int get completedGoals {
    return goals.where((goal) => goal['done'] == true).length;
  }

  int get remainingGoals {
    return goals.length - completedGoals;
  }

  void addGoal() {
    setState(() {
      sampleCount++;

      goals.add({
        'title': 'Sample Goal $sampleCount',
        'hours': 2,
        'done': false,
      });
    });
  }

  void toggleGoal(int index) {
    setState(() {
      goals[index]['done'] = !goals[index]['done'];
    });
  }

  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Study Planner'),
        centerTitle: true,
      ),
      body: Padding(
   padding: const EdgeInsets.all(16),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  const Text(
   'My Study Goals',
  style: TextStyle(
     fontSize: 24,
     fontWeight: FontWeight.bold,
 ),
            ),
    const SizedBox(height: 20),
    Row(
    children: [
    Expanded(
     child: StatCard(
     title: 'Total Hours',
     value: '$totalHours', icon: Icons.access_time, ), ), const SizedBox(width: 8),  Expanded(child: StatCard(
                    title: 'Completed',
  value: '$completedGoals',  icon: Icons.check_circle,  ),  ),
                const SizedBox(width: 8), Expanded(child: StatCard(  title: 'Remaining', value: '$remainingGoals', icon: Icons.pending_actions,
                  ),
                ),
              ],
            ),
 const SizedBox(height: 20),
  const Text( 'My Goals',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
 ),
 ),
 const SizedBox(height: 10),
  Expanded( child: goals.isEmpty ? const Center(
  child: Text('No study goals yet.'), )
  : ListView.builder( itemCount: goals.length,
  itemBuilder: (context, index) {
     bool isDone = goals[index]['done']; return Card(
                          margin: const EdgeInsets.only(bottom: 10),
   child: ListTile(  leading: Checkbox(value: isDone,
 onChanged: (value) {
   toggleGoal(index);
    },
    ),
title: Text(goals[index]['title'], style: TextStyle(  decoration: isDone
 ? TextDecoration.lineThrough : TextDecoration.none,
  ),
  ),
   subtitle: Text('${goals[index]['hours']} hours',
 ),
  trailing: IconButton( icon: const Icon(   Icons.delete,  color: Colors.red, ),
  onPressed: () {
  deleteGoal(index);
    },
    ),
   ),
     );
     },
     ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addGoal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(  padding: const EdgeInsets.all(10),
 child: Column( children: [Icon(icon, size: 25, color: Colors.indigo),const SizedBox(height: 8),
    Text( value, style: const TextStyle(   fontSize: 20,
 fontWeight: FontWeight.bold,
    ),
    ),
   Text( title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12),
   ),
    ],
    ),
      ),
    );
  }
}
