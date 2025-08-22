
import 'package:get_it/get_it.dart';
import 'package:hezmart/features/my_orders/data/data/order_repo_impl/ordeer_repository_impl.dart';
import 'package:hezmart/features/wishlist/data/data/repossitory_impl/repossitory_impl.dart';
import 'package:hezmart/features/wishlist/domain/repossitory.dart';
import '../../features/authentication/data/data/repo_impl/authrepositoryimpl.dart';
import '../../features/authentication/domain/repo/authrepository.dart';
import '../../features/cart/data/data/cart_repo_impl.dart';
import '../../features/cart/domain/cart_repo/cart_repo.dart';
import '../../features/my_orders/domain/order_repository.dart';
import 'injector.dart';


void setup(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<MyfavouritesRepository>(
      () => MyfavouritesRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(injector.get()));

}
