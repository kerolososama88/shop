import 'package:flutter/material.dart';

import '../on_boarding_screen.dart';

Widget buildBoardingItem(BoardingMoudel moudel)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image.asset(moudel.image),
    ),
    const SizedBox(
      height: 30,
    ),
    Text(
      moudel.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    const SizedBox(
      height: 15,
    ),
    Text(
      moudel.body,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
  ],
);
