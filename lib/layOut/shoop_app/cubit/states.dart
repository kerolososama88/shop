import 'package:untitled5/models/change_favorites_model.dart';
import 'package:untitled5/models/favorites_model.dart';

import '../../../models/Cateogris_model.dart';
import '../../../models/home_model.dart';
import '../../../models/profile_model.dart';

abstract class ShopState{}

class ShopInitialState extends ShopState{}

class ShopChangeBottomNavState extends ShopState{}

class ShopLoadingHomeDataState extends ShopState{}

class ShopSuccessHomeDataState extends ShopState{
  final HomeModel homeModel;
  final CategoriesModel categoriesModel ;

  ShopSuccessHomeDataState(this.homeModel, this.categoriesModel,);
}

class ShopErrorHomeDataState extends ShopState{}

class ShopSuccessCateogrisState extends ShopState{
  final CategoriesModel categoriesModel;

  ShopSuccessCateogrisState(this.categoriesModel);
}

class ShopErrorCateogrisState extends ShopState{}

class ShopSuccessChangeFavoritesState extends ShopState{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopState{}

class ShopErrorChangeFavoritesState extends ShopState{

}

class ShopLoadingUserDataState extends ShopState{}

class ShopSuccessUserDataState extends ShopState{
 final ProfileModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopState{}

class ShopLoadingUpdateUserState extends ShopState{}

class ShopSuccessUpdateUserState extends ShopState{
  final ProfileModel profileModel;

  ShopSuccessUpdateUserState(this.profileModel);
}

class ShopErrorUpdateUserState extends ShopState{}

class ShopLoadingGetFavoritesState extends ShopState{}

class ShopSuccessGetFavoritesState extends ShopState{
  ShopSuccessGetFavoritesState(FavoritesModel favoritesModel);
}

class ShopErrorGetFavoritesState extends ShopState{}
