import 'package:flutter/material.dart';

ScaffoldFeatureController ShowSnackbar(BuildContext context, String text) {
  final screenSize = MediaQuery.sizeOf(context);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      backgroundColor: Colors.white70,
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(
          top: screenSize.height * 0.010,
          left: screenSize.height * 0.010,
          right: screenSize.height * 0.010,
          bottom: screenSize.height * 0.010),
    ),
  );
}
