import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit() : super(AuthFormState(alertCheck: false));

  void showAlertDialogue({bool alertCheck}) {
    emit(AuthFormState(alertCheck: alertCheck));
  }
}
