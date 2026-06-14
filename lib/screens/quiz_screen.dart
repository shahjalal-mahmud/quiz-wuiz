import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../widgets/option_tile.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  final List<int?> _selectedAnswers = List.filled(quizQuestions.length, null);

  bool get _isLastQuestion => _currentIndex == quizQuestions.length - 1;

  void _selectOption(int optionIndex) {
    setState(() {
      _selectedAnswers[_currentIndex] = optionIndex;
    });
  }

  void _handleNextOrSubmit() {
    if (_selectedAnswers[_currentIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select an answer.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF7E57C2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      );
      return;
    }

    if (_isLastQuestion) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            selectedAnswers: List<int?>.from(_selectedAnswers),
          ),
        ),
      );
    } else {
      setState(() => _currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[_currentIndex];
    final labels = ['A', 'B', 'C', 'D'];
    final questionNumber =
    (_currentIndex + 1).toString().padLeft(2, '0');

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE1D5F5),
              Color(0xFFCFBEF0),
              Color(0xFFBFA8E8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Close button row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9575CD).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF5E35B1),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Question number badge (small circle above blob)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF9575CD).withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  questionNumber,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A148C),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Blob question card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 28),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9575CD).withValues(alpha: 0.30),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(60),
                      topRight: const Radius.circular(40),
                      bottomLeft: const Radius.circular(40),
                      bottomRight: const Radius.circular(60),
                    ),
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A148C),
                      height: 1.45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Options list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    return OptionTile(
                      label: labels[index],
                      text: question.options[index],
                      isSelected: _selectedAnswers[_currentIndex] == index,
                      onTap: () => _selectOption(index),
                    );
                  },
                ),
              ),

              // Next / Submit button
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _handleNextOrSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E57C2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _isLastQuestion ? 'SUBMIT' : 'NEXT',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}