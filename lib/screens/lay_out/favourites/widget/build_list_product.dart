import 'package:flutter/material.dart';
import '../../../../layOut/shoop_app/cubit/cubit.dart';
import '../../../../styels/color.dart';

Widget buildListProduct(model, context,
    {isOldPrice=true,})
=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image ?? ''),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0 && isOldPrice )
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
        const SizedBox(
          width: 20,
        ),
        Expanded(
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
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0&& isOldPrice)
                    Text(
                      model.oldPrice.toString(),
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
                      ShopCubit.get(context)
                          .changeFavorites(productId: model.id,);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context)
                          .favoriets[model.id] ??
                          false
                          ? defaultColor
                          : Colors.redAccent,
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
  ),
);
