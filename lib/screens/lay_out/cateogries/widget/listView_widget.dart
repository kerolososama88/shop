import 'package:flutter/material.dart';
import '../../../../layOut/shoop_app/cubit/cubit.dart';
import 'build_cat_Item.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildCatItem(
          ShopCubit.get(context).categoriesModel!.data!.data[index]),
      separatorBuilder: (context, index) => const Center(
        child: Text(
          '--------------------------------------------------------------------------------------',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      itemCount:
      ShopCubit.get(context).categoriesModel!.data!.data.length,
    );
  }
}
