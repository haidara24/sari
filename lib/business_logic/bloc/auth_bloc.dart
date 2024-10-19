import 'package:custome_mobile/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late SharedPreferences prefs;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(
      (event, emit) async {
        emit(AuthInProgressState());
        try {
          prefs = await SharedPreferences.getInstance();
          var userType = prefs.getString("userType");

          final hastoken = await authRepository.isAuthenticated();
          if (userType != null) {
            if (hastoken) {
              switch (userType) {
                case "Trader":
                  emit(AuthTraderSuccessState());
                  break;
                case "Broker":
                  emit(AuthBrokerSuccessState());
                  break;
                default:
              }
            } else {
              emit(const AuthFailureState("User is not logged in"));
            }
          } else {
            emit(const AuthFailureState("User is not logged in"));
          }
        } catch (e) {
          emit(AuthFailureState(e.toString()));
        }
      },
    );

    on<SignInButtonPressed>((event, emit) async {
      emit(AuthLoggingInProgressState());
      try {
        prefs = await SharedPreferences.getInstance();
        var userType = prefs.getString("userType");

        var data = await authRepository.login(
            username: event.username, password: event.password);
        if (data["status"] == 200) {
          switch (userType) {
            case "Trader":
              emit(AuthTraderSuccessState());
              break;
            case "Broker":
              emit(AuthBrokerSuccessState());
              break;

            default:
              emit(const AuthFailureState("خطأ في نوع المستخدم."));
          }
        } else if (data["status"] == 401) {
          String? details = "";
          if (data["details"] != null) {
            details = data["details"];
          }
          emit(AuthLoginErrorState(details));
        } else {
          String details = data["details"];
          emit(AuthFailureState(details));
        }
      } catch (e) {
        emit(AuthFailureState(e.toString()));
      }
    });

    on<UserLoggedOut>(
      (event, emit) async {
        await authRepository.deleteToken();
        emit(AuthInitial());
      },
    );
  }
}
