import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../models/Cateogris_model.dart';


Widget buildCatItem(DataModel model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CachedNetworkImage(
        imageUrl: model.image,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      const SizedBox(
        width: 20,
      ),
      Text(
        model.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Spacer(),
      const Icon(
        Icons.arrow_forward_outlined,
      ),
    ],
  ),
);