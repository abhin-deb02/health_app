import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_app/services/database.dart';

/*
class GoogleSignInProvider extends ChangeNotifier
{
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async
  {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);



    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}
 */

class AuthService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // login with google [Future bool method] {bool value helps create the login screen}

  Future<bool> googleLogIn() async {
    try
    {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account == null) return false;

      UserCredential res = await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));

      User? user = res.user;
      if (res.additionalUserInfo!.isNewUser)
      {
        print("new user detected");
        await DatabaseServices(uid: user!.uid).updateUserData(<String>[], <String>[]);
      }

      if (res.user == null) return false;

      return true;

    } catch (e)
    {
      print("error logging in");
      return false;
    }
  }

  // logout user
  Future<void> logOut() async {
    try
    {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
      await _auth.signOut();
    } catch (e)
    {
      print("error signing out!");
    }
  }


}