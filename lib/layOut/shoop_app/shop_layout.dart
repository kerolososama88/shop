import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layOut/shoop_app/cubit/cubit.dart';
import 'package:untitled5/layOut/shoop_app/cubit/states.dart';
import '../../screens/lay_out/search/search_screen.dart';


class ShopLayOut extends StatelessWidget {
  const ShopLayOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Yalla Shop',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>  SearchScreen()),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: 'Categorys',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
