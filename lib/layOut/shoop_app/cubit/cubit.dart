import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layOut/shoop_app/cubit/states.dart';
import 'package:untitled5/models/change_favorites_model.dart';
import 'package:untitled5/models/favorites_model.dart';
import 'package:untitled5/network/end_point.dart';
import 'package:untitled5/remote/cache_helper.dart';
import '../../../constans/componant.dart';
import '../../../models/Cateogris_model.dart';
import '../../../models/home_model.dart';
import '../../../models/profile_model.dart';
import '../../../remote/dio_helper.dart';
import '../../../screens/lay_out/cateogries/cateogries_screen.dart';
import '../../../screens/lay_out/favourites/favourites_screen.dart';
import '../../../screens/lay_out/products/screen/products_screen.dart';
import '../../../screens/lay_out/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(super.initialState);

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProudectsScreen(),
    const CateogriesScreen(),
    const FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int?, bool?> favoriets = {};

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products!) {
        favoriets.addAll({
          element.id: element.inFavorites,
        });
      }
      emit(ShopSuccessHomeDataState(homeModel!, categoriesModel!));
      getCategories();
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCateogrisState(categoriesModel!));
    }).catchError((error) {
      emit(ShopErrorCateogrisState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites({
    required int productId,
}){
    String token = CacheHelper.getData(key: 'token');
    favoriets[productId] = !favoriets[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      token: token,
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status==false) {
        favoriets[productId] = !favoriets[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favoriets[productId] = !favoriets[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    String token = CacheHelper.getData(key: 'token');
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      for (var element in homeModel!.data!.products!) {
        favoriets.addAll({
          element.id: element.inFavorites,
        });
      }
      emit(ShopSuccessGetFavoritesState(favoritesModel!));
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ProfileModel? userModel;

  void getUserData() {
  String token = CacheHelper.getData(key: 'token');
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {

      userModel = ProfileModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopLoadingUserDataState());
      String token = CacheHelper.getData(key: 'token');
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        name: 'name',
        phone: 'phone',
        email: 'email',
      },
    ).then((value) {
      userModel = ProfileModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
    });
  }
}
