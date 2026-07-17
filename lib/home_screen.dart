import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
bool showAnswer = false;
int currentIndex = 0;

final TextEditingController questionController =
TextEditingController();

final TextEditingController answerController =
TextEditingController();

List<Map<String, String>> flashCards = [
{
"question": "What is Flutter?",
"answer": "Flutter is a UI toolkit developed by Google."
},
{
"question": "Who developed Flutter?",
"answer": "Google"
},
{
"question": "Which language is used in Flutter?",
"answer": "Dart Programming Language"
},
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Flash Card App"),
centerTitle: true,
backgroundColor: Colors.blue,
actions: [
IconButton(
icon: const Icon(Icons.edit),
onPressed: () {              questionController.text =
flashCards[currentIndex]["question"]!;

answerController.text =
flashCards[currentIndex]["answer"]!;

showDialog(
context: context,
builder: (context) {
return AlertDialog(
title: const Text("Edit Flash Card"),

content: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: questionController,
decoration: const InputDecoration(
labelText: "Question",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextField(
controller: answerController,
decoration: const InputDecoration(
labelText: "Answer",
border: OutlineInputBorder(),
),
),
],
),

actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text("Cancel"),
),

ElevatedButton(
onPressed: () {
setState(() {
flashCards[currentIndex]["question"] =
questionController.text;

flashCards[currentIndex]["answer"] =
answerController.text;
});

questionController.clear();
answerController.clear();

Navigator.pop(context);
},
child: const Text("Update"),
),
],
);
},
);
},
),

IconButton(
icon: const Icon(Icons.delete),
onPressed: () {
if (flashCards.length > 1) {
setState(() {
flashCards.removeAt(currentIndex);

if (currentIndex >= flashCards.length) {
currentIndex = flashCards.length - 1;
}

showAnswer = false;
});
} else {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("At least one card must remain."),
),
);
}
},
),
],
),

body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [            Container(
height: 250,
width: double.infinity,
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(20),
),
child: Center(
child: Padding(
padding: const EdgeInsets.all(20),
child: Text(
showAnswer
? flashCards[currentIndex]["answer"]!
: flashCards[currentIndex]["question"]!,
textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 28,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
),
),

const SizedBox(height: 20),

Text(
"Card ${currentIndex + 1} of ${flashCards.length}",
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 20),

ElevatedButton(
onPressed: () {
setState(() {
showAnswer = !showAnswer;
});
},
child: Text(
showAnswer
? "Show Question"
: "Show Answer",
),
),

const SizedBox(height: 15),

ElevatedButton(
onPressed: () {
setState(() {
currentIndex++;

if (currentIndex >= flashCards.length) {
currentIndex = 0;
}

showAnswer = false;
});
},
child: const Text("Next Card"),
),

const SizedBox(height: 15),

ElevatedButton(
onPressed: () {
setState(() {
if (currentIndex > 0) {
currentIndex--;
} else {
currentIndex = flashCards.length - 1;
}

showAnswer = false;
});
},
child: const Text("Previous Card"),
),
],
),
),      floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.blue,
  child: const Icon(Icons.add),
  onPressed: () {
    questionController.clear();
    answerController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Flash Card"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: "Question",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: answerController,
                decoration: const InputDecoration(
                  labelText: "Answer",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                if (questionController.text.isNotEmpty &&
                    answerController.text.isNotEmpty) {
                  setState(() {
                    flashCards.add({
                      "question": questionController.text,
                      "answer": answerController.text,
                    });
                  });

                  questionController.clear();
                  answerController.clear();

                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  },
),
);
}
}