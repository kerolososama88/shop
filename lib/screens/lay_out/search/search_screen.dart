import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/screens/lay_out/search/cubit/search_cubit.dart';
import 'package:untitled5/screens/lay_out/search/cubit/search_states.dart';
import '../favourites/widget/build_list_product.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
  var formKey=GlobalKey<FormState>();
  var searchController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(SearchInitalState()),
      child: BlocBuilder<SearchCubit, SearchStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key:  formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: searchController,
                      decoration: const InputDecoration(
                        label: Text('Search'),
                        prefix: Icon(Icons.search),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onFieldSubmitted:  (String text) {
                        SearchCubit.get(context).search(text);
                        },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                     const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model.data!.data![index],context,isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => const Center(
                          child: Text(
                            '--------------------------------------------------------------------------------------',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        itemCount:
                        SearchCubit.get(context).model.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}