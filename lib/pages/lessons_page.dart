import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final String description;
  final List<String> videos;
  final List<String> additionalInfo;
  final List<String> securityConcerns;
  final bool isUnlocked;

  Lesson({
    required this.title,
    required this.description,
    required this.videos,
    required this.additionalInfo,
    required this.securityConcerns,
    this.isUnlocked = false,
  });
}

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  bool _isJumpMode = false;
  final List<Lesson> _lessons = [
    Lesson(
      title: 'Basic Phone Features',
      description: 'Learn how to use basic phone features.',
      videos: ['video1.mp4'],
      additionalInfo: ['Info 1'],
      securityConcerns: ['Concern 1'],
      isUnlocked: true,
    ),
    Lesson(
      title: 'Using WhatsApp',
      description: 'Learn how to use WhatsApp.',
      videos: ['video2.mp4'],
      additionalInfo: ['Info 2'],
      securityConcerns: ['Concern 2'],
    ),
    Lesson(
      title: 'Using GPay',
      description: 'Learn how to use GPay.',
      videos: ['video3.mp4'],
      additionalInfo: ['Info 3'],
      securityConcerns: ['Concern 3'],
    ),
    Lesson(
      title: 'Using Amazon',
      description: 'Learn how to use Amazon.',
      videos: ['video4.mp4'],
      additionalInfo: ['Info 4'],
      securityConcerns: ['Concern 4'],
    ),
  ];

  void _toggleJumpMode() {
    setState(() {
      _isJumpMode = !_isJumpMode;
    });
  }

  void _unlockNextLesson(int index) {
    if (index < _lessons.length - 1) {
      setState(() {
        _lessons[index + 1] = Lesson(
          title: _lessons[index + 1].title,
          description: _lessons[index + 1].description,
          videos: _lessons[index + 1].videos,
          additionalInfo: _lessons[index + 1].additionalInfo,
          securityConcerns: _lessons[index + 1].securityConcerns,
          isUnlocked: true,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lessons"),
        actions: [
          IconButton(
            icon: Icon(_isJumpMode ? Icons.lock_open : Icons.lock),
            onPressed: _toggleJumpMode,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _lessons.length,
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          return Card(
            color: lesson.isUnlocked || _isJumpMode
                ? Colors.white
                : Colors.grey[200],
            child: ListTile(
              title: Text(lesson.title),
              subtitle: Text(lesson.description),
              onTap: lesson.isUnlocked || _isJumpMode
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonDetailPage(
                            lesson: lesson,
                            onComplete: () => _unlockNextLesson(index),
                          ),
                        ),
                      )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class LessonDetailPage extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onComplete;

  const LessonDetailPage(
      {super.key, required this.lesson, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Videos:"),
            ...lesson.videos.map((video) => Text(video)).toList(),
            const SizedBox(height: 10),
            Text("Additional Information:"),
            ...lesson.additionalInfo.map((info) => Text(info)).toList(),
            const SizedBox(height: 10),
            Text("Security Concerns:"),
            ...lesson.securityConcerns.map((concern) => Text(concern)).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onComplete();
                Navigator.pop(context);
              },
              child: const Text("Complete Lesson"),
            ),
          ],
        ),
      ),
    );
  }
}
