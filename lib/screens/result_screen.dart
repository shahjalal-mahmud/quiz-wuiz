import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<int?> selectedAnswers;

  const ResultScreen({super.key, required this.selectedAnswers});

  int get _correctCount {
    int count = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (selectedAnswers[i] == quizQuestions[i].correctAnswerIndex) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final correct = _correctCount;
    final wrong = quizQuestions.length - correct;
    final total = quizQuestions.length;
    final percentage = (correct / total * 100).toInt();

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

              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                            (route) => false,
                      ),
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
                    const Expanded(
                      child: Text(
                        'RESULTS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ),
                    const SizedBox(width: 36), // balance close button
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Score blob card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 28),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9575CD).withValues(alpha: 0.30),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        color: Color(0xFF5E35B1),
                        size: 44,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Quiz Completed!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A148C),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$correct / $total',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4A148C),
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$percentage% Correct',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF5E35B1).withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Correct / Wrong chips
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _StatPill(
                            label: 'Correct',
                            value: '$correct',
                            color: const Color(0xFF7E57C2),
                            iconData: Icons.check_rounded,
                          ),
                          const SizedBox(width: 14),
                          _StatPill(
                            label: 'Wrong',
                            value: '$wrong',
                            color: const Color(0xFF9575CD),
                            iconData: Icons.close_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Detailed results label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'DETAILED RESULTS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      color: const Color(0xFF5E35B1).withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Scrollable results list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  itemCount: quizQuestions.length,
                  itemBuilder: (context, index) {
                    final question = quizQuestions[index];
                    final userAnswerIndex = selectedAnswers[index];
                    final isCorrect =
                        userAnswerIndex == question.correctAnswerIndex;
                    final userAnswerText = userAnswerIndex != null
                        ? question.options[userAnswerIndex]
                        : 'No answer';
                    final correctAnswerText =
                    question.options[question.correctAnswerIndex];

                    return _ResultItem(
                      index: index + 1,
                      questionText: question.question,
                      userAnswer: userAnswerText,
                      correctAnswer: correctAnswerText,
                      isCorrect: isCorrect,
                    );
                  },
                ),
              ),

              // Bottom action buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'HOME',
                        icon: Icons.home_rounded,
                        filled: false,
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()),
                              (route) => false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _ActionButton(
                        label: 'RESTART',
                        icon: Icons.refresh_rounded,
                        filled: true,
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const QuizScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper widgets ──────────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData iconData;

  const _StatPill({
    required this.label,
    required this.value,
    required this.color,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.25),
            ),
            child: Icon(iconData, size: 14, color: const Color(0xFF4A148C)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4A148C),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: const Color(0xFF5E35B1).withValues(alpha: 0.65),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final int index;
  final String questionText;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const _ResultItem({
    required this.index,
    required this.questionText,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xFF7E57C2).withValues(alpha: 0.13)
            : const Color(0xFF9575CD).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCorrect
              ? const Color(0xFF7E57C2).withValues(alpha: 0.40)
              : const Color(0xFF9575CD).withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCorrect
                      ? const Color(0xFF7E57C2).withValues(alpha: 0.25)
                      : const Color(0xFF9575CD).withValues(alpha: 0.20),
                ),
                child: Icon(
                  isCorrect ? Icons.check_rounded : Icons.close_rounded,
                  size: 14,
                  color: isCorrect
                      ? const Color(0xFF4A148C)
                      : const Color(0xFF7B1FA2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '$index. $questionText',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF4A148C),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AnswerRow(
                  label: 'Your answer:',
                  value: userAnswer,
                  isCorrect: isCorrect,
                  isUserAnswer: true,
                ),
                const SizedBox(height: 4),
                _AnswerRow(
                  label: 'Correct answer:',
                  value: correctAnswer,
                  isCorrect: true,
                  isUserAnswer: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isCorrect;
  final bool isUserAnswer;

  const _AnswerRow({
    required this.label,
    required this.value,
    required this.isCorrect,
    required this.isUserAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final valueColor = isUserAnswer
        ? (isCorrect
        ? const Color(0xFF5E35B1)
        : const Color(0xFF7B1FA2).withValues(alpha: 0.7))
        : const Color(0xFF5E35B1);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF5E35B1).withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: filled
              ? const Color(0xFF7E57C2)
              : const Color(0xFF9575CD).withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: filled
                ? Colors.transparent
                : const Color(0xFF9575CD).withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: filled ? Colors.white : const Color(0xFF5E35B1),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: filled ? Colors.white : const Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}