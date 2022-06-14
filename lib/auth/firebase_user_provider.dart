import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FfFirebaseFirebaseUser {
  FfFirebaseFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FfFirebaseFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FfFirebaseFirebaseUser> ffFirebaseFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FfFirebaseFirebaseUser>(
            (user) => currentUser = FfFirebaseFirebaseUser(user));
