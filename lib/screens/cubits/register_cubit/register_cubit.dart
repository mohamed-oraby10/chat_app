import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterSuccess());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "weak-password") {
        emit(RegisterFailure(errMessage: 'Weak password'));
      } else if (ex.code == "email-already-in-use") {
        emit(RegisterFailure(errMessage: 'email already is used'));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: 'Somthing went wrong'));
    }
  }
}
