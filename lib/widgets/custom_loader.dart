import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String? message;

  const CustomLoader({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF223049),
              strokeWidth: 4,
            ),
            if (message != null) ...[
              SizedBox(height: 16),
              Text(
                message!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
