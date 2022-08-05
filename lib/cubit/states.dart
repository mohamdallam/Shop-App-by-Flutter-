import 'package:shop_app_abdallah/models/change_favorites_model.dart';
import 'package:shop_app_abdallah/models/login_model.dart';

abstract class Shopstate {}

////////////////////////////////Login/////////////////////////////////////////
class ShopLoginInitialState extends Shopstate {}
class ShopLoginLoadingState extends Shopstate {}
class ShopLoginSuccessState extends Shopstate {
  final LoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends Shopstate {
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends Shopstate {}

/////////////////////////////////BottomNavigationBar///////////////////////////////
class ShopInitialState extends Shopstate {}
class ShopChangeBottomNavState extends Shopstate {}

/////////////////////////////////Home/////////////////////////////////////////////
class ShopLoadingHomeDataState extends Shopstate {}
class ShopSuccessHomeDataState extends Shopstate {}
class ShopErrorHomeDataState extends Shopstate {}

/////////////////////////////////Categories///////////////////////////////
class ShopSuccessCategoriesState extends Shopstate {}
class ShopErrorCategoriesState extends Shopstate {}

/////////////////////////////////Favorites///////////////////////////////
class ShopChangeFavoritesState extends Shopstate {}
class ShopErrorFavoritesState extends Shopstate {}
class ShopSuccessChangeFavoritesState extends Shopstate
{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}


/////////////////////////////////Get Favorites///////////////////////////////
// class ShopSuccessGetFavoritesState extends Shopstate {}
// class ShopLoadingGetFavoritesState extends Shopstate {}
// class ShopErrorGetFavoritesState extends Shopstate {}






class ShopSuccessGetFavoritesState extends Shopstate {}
class ShopLoadingGetFavoritesState extends Shopstate {}
class ShopErrorGetFavoritesState extends Shopstate {}
class ShopErrorChangeFavoritesState extends Shopstate {}

////////////////////////////// UserData ////////////////////////////////////////
class ShopLoadingUserDataState extends Shopstate {}
class ShopErrorUserDataState extends Shopstate {}
class ShopSuccessUserDataState extends Shopstate {
  final LoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}



//////////////////////////// UpdateUser ////////////////////////

class ShopLoadingUpdateUserState extends Shopstate {}
class ShopErrorUpdateUserState extends Shopstate {}
class ShopSuccessUpdateUserState extends Shopstate
{
  final LoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

