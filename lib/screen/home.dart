import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar(context, "EDUvian"),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: offWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,

            childAspectRatio: 3, // Slim buttons
            children: [
              _buildSmallButton(
                icon: Icons.calculate,
                label: 'Credit & Cost Calculator',
                color: primaryColor,
                onTap: () => context.push("/credit"),
              ),
              _buildSmallButton(
                icon: Icons.calculate,
                label: 'Credit & Cost Calculator',
                color: primaryColor,
                onTap: () => context.push("/credit"),
              ),
              _buildSmallButton(
                icon: Icons.calculate,
                label: 'Credit & Cost Calculator',
                color: primaryColor,
                onTap: () => context.push("/credit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
