import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layOut/shoop_app/cubit/cubit.dart';
import 'package:untitled5/screens/lay_out/cateogries/widget/listView_widget.dart';
import '../../../layOut/shoop_app/cubit/states.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(ShopInitialState())..getCategories(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          if (state is ShopSuccessCateogrisState) {
            return const ListViewWidget();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }


}
