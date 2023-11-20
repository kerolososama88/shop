import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/screens/lay_out/products/widget/product_builder.dart';

import '../../../../layOut/shoop_app/cubit/cubit.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: ShopCubit.get(context).homeModel != null &&
          ShopCubit.get(context).categoriesModel != null,
      builder: (context) => productsBuilder(
          ShopCubit.get(context).homeModel!,
          ShopCubit.get(context).categoriesModel!,
          context),
      fallback: (context) =>
      const Center(child: CircularProgressIndicator()),
    );
  }
}
