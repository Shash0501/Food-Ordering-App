import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        emit(AuthenticationLoading());

        final googleSignIn = GoogleSignIn();

        try {
          final googleUser = await googleSignIn.signIn();

          if (googleUser == null) return;

          final googleAuth = await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);
        } catch (e) {
          emit(AuthenticationFailure());
          debugPrint(e.toString());
        }
      } else if (event is AuthenticationLogOut) {
        final googleSignIn = GoogleSignIn();
        await googleSignIn.disconnect();
        FirebaseAuth.instance.signOut();
        emit(AuthenticationLogout());
      } else if (event is CheckIsAdmin) {
        int flag = 0;

        await FirebaseFirestore.instance
            .collection("admin_list")
            .get()
            .then((value) {
          for (var element in value.docs) {
            if (FirebaseAuth.instance.currentUser?.email == element.id) {
              emit(AuthenticationSuccess(
                  restaurantId: element.data()["restaurant_id"],
                  isAdmin: true));

              flag = 1;
              break;
            }
          }
        });
        if (flag == 0) {
          emit(AuthenticationSuccess(restaurantId: null, isAdmin: false));
        }
      }
    });
  }
}
