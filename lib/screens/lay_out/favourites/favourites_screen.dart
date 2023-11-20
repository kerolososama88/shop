import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layOut/shoop_app/cubit/cubit.dart';
import 'package:untitled5/layOut/shoop_app/cubit/states.dart';
import 'package:untitled5/screens/lay_out/favourites/widget/build_list_product.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
  builder: (context, state) {
    return ConditionalBuilder(
      condition: state is! ShopLoadingGetFavoritesState,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildListProduct(
            ShopCubit.get(context).favoritesModel!.data!.data![index].product!,
            context,),
        separatorBuilder: (context, index) => const Center(
          child: Text(
            '--------------------------------------------------------------------------------------',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        itemCount:
            ShopCubit.get(context).favoritesModel!.data!.data!.length,
      ),
      fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
    );
  },
);
  }

}
