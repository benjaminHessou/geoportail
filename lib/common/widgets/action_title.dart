import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ActionTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(  
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 280, 
          height: 43,
          decoration: BoxDecoration(
            color: Color(0xFFF5F0F0), 
            borderRadius: BorderRadius.circular(8.0), 
          ),
          alignment: Alignment.center, 
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF007533), 
            ),
          ),
        ),
      ),
    );
  }
}