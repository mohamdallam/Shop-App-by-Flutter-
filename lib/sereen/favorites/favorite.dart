import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_abdallah/cubit/cubit.dart';
import 'package:shop_app_abdallah/cubit/states.dart';
import 'package:shop_app_abdallah/models/favorites_model.dart';
import 'package:shop_app_abdallah/shared/component.dart';
import 'package:shop_app_abdallah/shared/style/color.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstate>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );


    // return BlocConsumer<ShopCubit, Shopstate>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     return BlocConsumer<ShopCubit, Shopstate>(
    //       listener: (context, state) {},
    //       builder: (context, state) {
    //         return ListView.separated(
    //           itemBuilder: (context, index) => buildFavItem( ShopCubit.get(context).favoritesModel.data.data[index], context),
    //           itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
    //           separatorBuilder: (context, index) => SizedBox( height: 1,),
    //         );
    //       },
    //     );
    //     // return ListView.separated(
    //     //   itemBuilder: (context, index) => buildListProduct(
    //     //       ShopCubit.get(context).favoritesModel.data.data[index].product,
    //     //       context),
    //     //   separatorBuilder: (context, index) => myDivider(),
    //     //   itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
    //     // );
    //   },
    // );
    // return BlocConsumer<ShopCubit, Shopstate>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     return ListView.separated(
    //       itemBuilder: (context, index) => buildFavItem( ShopCubit.get(context).favoritesModel.data.data[index], context),
    //       itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
    //       separatorBuilder: (context, index) => SizedBox( height: 1,),
    //     );
    //   },
    // );
  }

Widget buildFavItem(FavoritesData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        // width: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  //fit: BoxFit.cover,
                ),
                if (model.product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (model.product.discount != 0)
                        Text(
                          model.product.oldPrice.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        // padding: EdgeInsets.zero,
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: ShopCubit.get(context).favorites[model.product.id]? defaultColor: Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                           ShopCubit.get(context).changeFavorites(model.product.id);
                          //print(model.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
