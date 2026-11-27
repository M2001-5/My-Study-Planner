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
scaffoldBackgroundColor: const Color(0xFFF5F7FC),
appBarTheme: const AppBarTheme(
backgroundColor: Colors.indigo,
foregroundColor: Colors.white,
centerTitle: true,
),
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
{'subject': 'Mobile App Development', 'hours': 5, 'done': false},
{'subject': 'Data Structures', 'hours': 3, 'done': false},
{'subject': 'Research Methodology', 'hours': 2, 'done': false},
];

int get totalHours {
return goals.fold(0, (sum, goal) => sum + (goal['hours'] as int));
}

int get completedGoals {
return goals.where((goal) => goal['done'] == true).length;
}

int get remainingGoals {
return goals.length - completedGoals;
}

Future<void> openAddScreen() async {
final result = await Navigator.push<Map<String, dynamic>>(
context,
MaterialPageRoute(builder: (context) => const AddGoalScreen()),
);
if (result != null) {
setState(() {
goals.add(result);
});
}
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
appBar: AppBar(title: const Text('My Study Planner')),
body: Padding(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('My Study Goals', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
const SizedBox(height: 15),
Row(
children: [
Expanded(child: StatCard(title: 'Total Hours', value: '$totalHours', color: Colors.blue)),
Expanded(child: StatCard(title: 'Completed', value: '$completedGoals', color: Colors.green)),
Expanded(child: StatCard(title: 'Remaining', value: '$remainingGoals', color: Colors.orange)),
],
),
const SizedBox(height: 22),
const Text('My Courses', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
const SizedBox(height: 10),

Expanded(
child: goals.isEmpty
? const Center(child: Text('No courses yet. Press + to add one.'))
: GridView.builder(
padding: const EdgeInsets.only(bottom: 10),
itemCount: goals.length,
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 15,
mainAxisSpacing: 15,
mainAxisExtent: 120,
),
itemBuilder: (context, index) {
final goal = goals[index];
final bool done = goal['done'];

return Card(
color: Colors.white,
elevation: 1,
child: Padding(
padding: const EdgeInsets.all(10),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Checkbox(
activeColor: Colors.indigo,
value: done,
onChanged: (value) {
toggleGoal(index);
},
),
IconButton(
icon: const Icon(Icons.delete_outline, color: Colors.red),
onPressed: () {
deleteGoal(index);
},
),
],
),
Expanded(
child: Text(
goal['subject'],
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 14,
decoration: done ? TextDecoration.lineThrough : TextDecoration.none,
),
),
),
Text('${goal['hours']} hours'),
],
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
backgroundColor: Colors.indigo,
foregroundColor: Colors.white,
onPressed: openAddScreen,
child: const Icon(Icons.add),
),
);
}
}

class StatCard extends StatelessWidget {
final String title;
final String value;
final Color color;

const StatCard({super.key, required this.title, required this.value, required this.color});

@override
Widget build(BuildContext context) {
return Card(
color: Colors.white,
elevation: 1,
child: Padding(
padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
child: Column(
children: [
Icon(Icons.bar_chart, color: color, size: 23),
const SizedBox(height: 6),
Text(value, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: color)),
Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
],
),
),
);
}
}

class AddGoalScreen extends StatefulWidget {
const AddGoalScreen({super.key});

@override
State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
final TextEditingController subjectController = TextEditingController();
final TextEditingController hoursController = TextEditingController();

String? subjectError;
String? hoursError;

@override
void dispose() {
subjectController.dispose();
hoursController.dispose();
super.dispose();
}

void saveGoal() {
final String subject = subjectController.text.trim();
final int? hours = int.tryParse(hoursController.text.trim());

setState(() {
subjectError = subject.isEmpty ? 'Please enter a course name' : null;
hoursError = hours == null || hours <= 0 ? 'Enter a valid number of hours' : null;
});

if (subjectError == null && hoursError == null) {
Navigator.pop(context, {
'subject': subject,
'hours': hours,
'done': false,
});
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Add New Course')),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Add a Study Goal', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
const Text('Enter your course details below.', style: TextStyle(color: Colors.grey)),
const SizedBox(height: 25),
TextField(
controller: subjectController,
decoration: InputDecoration(
labelText: 'Course Name',
prefixIcon: const Icon(Icons.book_outlined, color: Colors.indigo),
errorText: subjectError,
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
),
),
const SizedBox(height: 18),
TextField(
controller: hoursController,
keyboardType: TextInputType.number,
decoration: InputDecoration(
labelText: 'Study Hours',
prefixIcon: const Icon(Icons.access_time, color: Colors.indigo),
errorText: hoursError,
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
),
),
const SizedBox(height: 25),
SizedBox(
width: double.infinity,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.indigo,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(vertical: 14),
),
onPressed: saveGoal,
child: const Text('Save Course'),
),
),
],
),
),
);
}
}
