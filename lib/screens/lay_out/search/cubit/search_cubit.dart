import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/models/search_model.dart';
import 'package:untitled5/remote/cache_helper.dart';
import 'package:untitled5/remote/dio_helper.dart';
import 'package:untitled5/screens/lay_out/search/cubit/search_states.dart';
import '../../../../network/end_point.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(super.initialState);

  static SearchCubit get(context)=> BlocProvider.of(context);

 late SearchModel model;

 void search(String text){
   String token = CacheHelper.getData(key: 'token');
   emit(SearchLoadingState());
   DioHelper.postData(
       url:SEARCH ,
       data: {
         'text':text ,
         token:token,
       },
   ).then((value) {
     model=SearchModel.fromJson(value.data);
     emit(SearchSuccessState());
   }).catchError((onError){
     emit(SearchErrorState());
   });
 }
}