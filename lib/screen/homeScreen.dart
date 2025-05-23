import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDUvian',
          style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 2,
                color: const Color.fromARGB(97, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 169, 28, 18),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.push('/credit');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Icon(
                      Icons.calculate_outlined,
                      color: Colors.black54,
                      size: 35,
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      'Credit Calculation',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
