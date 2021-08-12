import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign_in_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  User? _user;
  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _auth = firebaseAuth,
        _googleSignIn = googleSignIn {
    _init();
  }

  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen(
      (User? user) {
        if (!_completer.isCompleted) {
          _completer.complete();
        }
        _user = user;
      },
    );
  }

  @override
  Future<void> signOut() async {
    final data = _user?.providerData ?? [];
    String providerId = 'firebase';
    for (final provider in data) {
      // password
      // phone
      // google.com
      // facebook.com
      // twitter.com
      // github.com
      // apple.com
      if (provider.providerId != providerId) {
        providerId = provider.providerId;
        break;
      }
    }
    if (providerId == 'google.com') {
      await _googleSignIn.signOut();
    } else if (providerId == 'facebook.com') {}
    return _auth.signOut();
  }

  @override
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      return SignInResponse(
        user: user,
        providerId: userCredential.credential?.providerId,
        error: null,
      );
    } on FirebaseAuthException catch (e) {
      return getSingError(e);
    }
  }

  @override
  Future<SignInResponse> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        return SignInResponse(
          error: SignInError.cancelled,
          user: null,
          providerId: null,
        );
      }

      final googleAuth = await account.authentication;
      final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final userCredential = await _auth.signInWithCredential(oAuthCredential);
      return SignInResponse(
        user: userCredential.user,
        providerId: userCredential.credential?.providerId,
        error: null,
      );
    } on FirebaseAuthException catch (e) {
      return getSingError(e);
    }
  }
}
