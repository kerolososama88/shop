import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/Cateogris_model.dart';

Widget buildCategoryItem(DataModel model, context) => Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    CachedNetworkImage(
      imageUrl: model.image,
      height: 100.0,
      width: 100.0,
      fit: BoxFit.cover,
    ),
    Container(
      width: 100.0,
      color: Colors.black.withOpacity(
        .8,
      ),
      child: Text(
        model.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  ],
);