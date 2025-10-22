import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'User not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'Wrong password'));
      } else if (ex.code == 'invalid-email') {
        emit(LoginFailure(errMessage: 'Wrong email'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'Somthing went wrong'));
    }
  }

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

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
