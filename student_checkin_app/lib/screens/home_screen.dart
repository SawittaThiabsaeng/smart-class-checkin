import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [

                const SizedBox(height: 40),

                /// Ongoing Class Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "ONGOING CLASS",
                        style: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 2,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Smart Class Check-in & Learning Reflection App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.white70),
                            SizedBox(width: 6),
                            Text(
                              "Class Check-in & Class Completion",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 70),

                /// Buttons
                Row(
                  children: [

                    Expanded(
                      child: _actionButton(
                        icon: Icons.login,
                        text: "Class Check-in",
                        onTap: () =>
                            Navigator.pushNamed(context, '/checkin'),
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: _actionButton(
                        icon: Icons.logout,
                        text: "Class Completion",
                        onTap: () =>
                            Navigator.pushNamed(context, '/finish'),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// Footer
                Column(
                  children: [

                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "SMART ATTENDANCE SYSTEM",
                      style: TextStyle(
                        color: Colors.white38,
                        letterSpacing: 3,
                        fontSize: 10,
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _actionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),

            const SizedBox(height: 16),

            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

