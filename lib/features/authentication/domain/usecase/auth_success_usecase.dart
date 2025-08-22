

import '../../../../common/database/local/userstorage.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/services/data/session_manager.dart';
import '../../data/models/authsuccess_response.dart';
import '../../presentations/user_bloc/user_bloc.dart';

class AuthSuccessUseCase {
  final _userStorage = UserStorage();
  void execute(AuthSuccessResponse response) {
    // injector.get<UserBloc>().add(SaveUserEvent(response.data!.user));
    injector.get<UserBloc>().add(SaveUserEvent(response.data!.user!));
    _userStorage.saveUserToken(response.token.toString());
    SessionManager().isLoggedIn = true;
    SessionManager().hasOnboarded = true;

    // // for wallet
    // injector.get<WalletBloc>().add(SaveWalletEvent());
    // userWallet.saveWallet(response.data.bearerToken);
    SessionManager().isLoggedIn = true;
  }
}
