import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errmessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
            LoginFailure(errmessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(errmessage: 'something went wrong'));
    }
  }

  Future<void> userRegister(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errmessage: 'The password provided is too weak.'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errmessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterFailure(errmessage: 'something went wrong'));
    }
  }
}
