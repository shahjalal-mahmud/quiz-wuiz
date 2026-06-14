import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Ambient background orbs
          Positioned(
            top: -80,
            right: -60,
            child: _Orb(size: 280, color: const Color(0xFF6366F1), opacity: 0.18),
          ),
          Positioned(
            top: 60,
            left: -80,
            child: _Orb(size: 200, color: const Color(0xFF10B981), opacity: 0.10),
          ),
          Positioned(
            bottom: 120,
            right: -40,
            child: _Orb(size: 160, color: const Color(0xFFF59E0B), opacity: 0.10),
          ),
          // Main content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      // Top badges row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _PillBadge(
                            label: '10 Questions',
                            dot: true,
                            dotColor: const Color(0xFF10B981),
                          ),
                          _PillBadge(label: 'MCQ'),
                        ],
                      ),
                      const Spacer(flex: 2),
                      // Icon
                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.35),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text('🎯', style: TextStyle(fontSize: 48)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Bengali title
                      const Text(
                        'আমার প্রশ্ন',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          height: 1.15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'AMAR PROSHNO',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.35),
                          letterSpacing: 4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      // Description
                      Text(
                        'Test your knowledge across multiple topics.\nChallenge yourself and track your score!',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha: 0.50),
                          height: 1.7,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(flex: 2),
                      // Stats row
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              value: '10',
                              label: 'Questions',
                              color: const Color(0xFF6366F1),
                              glowColor: const Color(0xFF6366F1),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              value: 'MCQ',
                              label: 'Format',
                              color: const Color(0xFF10B981),
                              glowColor: const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Start button
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: FilledButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, anim, __) =>
                                  const QuizScreen(),
                                  transitionsBuilder: (_, anim, __, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                  const Duration(milliseconds: 350),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 24,
                            ),
                            label: const Text(
                              'Start Quiz',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Footer
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Made by ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.30),
                              ),
                            ),
                            TextSpan(
                              text: 'Shahajalal Mahmud',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.50),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ──────────────────────────────────────────────────────────

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const _Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: opacity),
      ),
    );
  }
}

class _PillBadge extends StatelessWidget {
  final String label;
  final bool dot;
  final Color? dotColor;

  const _PillBadge({required this.label, this.dot = false, this.dotColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.60),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color glowColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: color.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.35),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}