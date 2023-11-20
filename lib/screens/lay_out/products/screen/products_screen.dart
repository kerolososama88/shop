import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/constans/constans_buttom.dart';
import 'package:untitled5/layOut/shoop_app/cubit/cubit.dart';
import 'package:untitled5/layOut/shoop_app/cubit/states.dart';
import '../widget/product_body.dart';

class ProudectsScreen extends StatelessWidget {
  const ProudectsScreen({super.key});

  static ShopCubit get(context) => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(ShopInitialState())..getHomeData()..getCategories(),

      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is ShopSuccessChangeFavoritesState) {
            if(!state.model.status!)
            {
              showToast(
                  text:state.model.message! ,
                  state:ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return  const ProductBody();
        },
      ),
    );
  }

}
