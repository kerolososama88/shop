import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../layOut/shoop_app/cubit/cubit.dart';
import '../../../../models/home_model.dart';
import '../../../../styels/color.dart';

Widget buildGridProudect(Products model, context) => Container(
  color: Colors.white,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          CachedNetworkImage(
            imageUrl: model.image ?? '',
            width: double.infinity,
            height: 200,
          ),
          if (model.discount != 0)
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              child: const Text(
                'DISSCOUNT',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                height: 1.3,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price!.round()}',
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: defaultColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice!.round()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(productId:model.id!);
                  },
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor:
                    ShopCubit.get(context).favoriets[model.id]!
                        ? defaultColor
                        : Colors.grey,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);