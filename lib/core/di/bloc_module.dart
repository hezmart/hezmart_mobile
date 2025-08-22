import 'package:get_it/get_it.dart';
import 'package:hezmart/features/my_orders/data/models/single_order.dart';
import 'package:hezmart/features/my_orders/presentations/order_bloc/order_bloc.dart';
import 'package:hezmart/features/wishlist/presentations/fav_bloc/favourite_bloc.dart';
import '../../features/authentication/presentations/user_bloc/user_bloc.dart';
import '../../features/cart/presentations/cartbloc/cart_bloc.dart';
import 'injector.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton(() => UserBloc());
  getIt.registerLazySingleton(() => CartBloc(injector.get()));
  getIt.registerLazySingleton(() => FavouriteBloc(injector.get()));
  getIt.registerLazySingleton(() => OrderBloc(injector.get()));
  // getIt.registerLazySingleton(() => MyWorkersBloc(injector.get()));
  // // getIt.registerLazySingleton(() => GamesBloc(injector.get()));
}
