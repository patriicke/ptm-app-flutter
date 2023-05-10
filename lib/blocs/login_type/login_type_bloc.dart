import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';

part 'login_type_event.dart';
part 'login_type_state.dart';

class LoginTypeBloc extends Bloc<LoginTypeEvent, LoginType> {
  LoginTypeBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(LoginType.unspecified) {
    _loginTypeSubscription = _authenticationRepository.loginTypeStream.listen(
      (loginType) => add(LoginTypeStreamedIn(loginType)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<LoginType> _loginTypeSubscription;

  @override
  Stream<LoginType> mapEventToState(
    LoginTypeEvent event,
  ) async* {
    if (event is LoginTypeUpdated) {
      yield event.loginType;
      await _authenticationRepository.updateLoginType(event.loginType);
    } else if (event is LoginTypeStreamedIn) {
      yield event.loginType;
    }
  }

  @override
  Future<void> close() {
    _loginTypeSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
