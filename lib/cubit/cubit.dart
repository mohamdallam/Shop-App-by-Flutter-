import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_abdallah/cubit/states.dart';
import 'package:shop_app_abdallah/models/categories_model.dart';
import 'package:shop_app_abdallah/models/change_favorites_model.dart';
import 'package:shop_app_abdallah/models/favorites_model.dart';
import 'package:shop_app_abdallah/models/home_model.dart';
import 'package:shop_app_abdallah/models/login_model.dart';
import 'package:shop_app_abdallah/sereen/categories/categories.dart';
import 'package:shop_app_abdallah/sereen/favorites/favorite.dart';
import 'package:shop_app_abdallah/sereen/products/products.dart';
import 'package:shop_app_abdallah/sereen/setting/setting.dart';
import 'package:shop_app_abdallah/shared/component.dart';
import 'package:shop_app_abdallah/shared/network/end_point.dart';
import 'package:shop_app_abdallah/shared/network/remote.dart';

class ShopLoginCubit extends Cubit<Shopstate> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

/////////////////////////////////////////////// LOGIN //////////////////////////////////////////////////////
  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data.token);
    }).catchError((error) {
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }

///////////////////////////////////////// Toggle Password Visibility ///////////////////////////////////
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}

////////////////////////////////////////////////// BottomNavigationBar ///////////////////////////////

class ShopCubit extends Cubit<Shopstate> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    Products(),
    Categories(),
    Favorites(),
    Setting(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

/////////////////////////////////////////////// Home /////////////////////////////////////////////

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
       printFullText(homeModel.toString());
      //   printFullText(homeModel.data.banners[0].image);
      //   print(homeModel.status);

      homeModel.data.products.forEach((element) {
        favorites.addAll
          ({element.id : element.inFavorites});
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

////////////////////////////////////////////////////// Categories /////////////////////////////////////
  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //  printFullText(homeModel.toString());
      printFullText(homeModel.data.banners[0].image);
      print(homeModel.status);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

////////////////////////////////////////////////////// changeFavorites /////////////////////////////////////

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));

    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorGetFavoritesState());
    });
  }
////////////////////////////////////////////////////// getFavorites /////////////////////////////////////
  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


///////////////////////////////////////////////////////////////////////


  LoginModel userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText('user model : $userModel.data.name');

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


///////////////////////////////// Update User Data //////////////////////////////

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }




}




////////////////////////////////////////////////////// ChangeFavorites /////////////////////////////////////
//   ChangeFavoritesModel changeFavoritesModel;
//   void changeFavorites(int productId) {
//     favorites[productId] = !favorites[productId];
//     emit(ShopChangeFavoritesState());
//     DioHelper.postData(
//       url: FAVORITES,
//       data: {
//         'product_id': productId,
//       },
//       token: token,
//     ).then((value) {
//       changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
//       print(value.data);
//       if (!changeFavoritesModel.status) {
//         favorites[productId] = !favorites[productId];
//       }else{
//         getFavorites();
//       }
//       emit(ShopSuccessFavoritesState(changeFavoritesModel));
//     }).catchError((error) {
//       favorites[productId] = !favorites[productId];
//       emit(ShopErrorFavoritesState());
//     });
//   }

/////////////////////////////////////////////////////// GetFavorites//////////////////////
//   FavoritesModel favoritesModel;
//   void getFavorites() {
//     emit(ShopLoadingGetFavoritesState());
//     DioHelper.getData(
//       url: FAVORITES,
//       token: token,
//     ).then((value) {
//       favoritesModel = FavoritesModel.fromJson(value.data);
//       printFullText(value.data.toString());
//
//       emit(ShopSuccessGetFavoritesState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(ShopErrorGetFavoritesState());
//     });
//   }