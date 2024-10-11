import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:capusle_rewards/api/api_repository.dart';
import 'package:capusle_rewards/firebase_options.dart';
import 'package:capusle_rewards/modules/db/database_controller.dart';
import 'package:capusle_rewards/shared/storage/storage_util.dart';
import 'package:capusle_rewards/shared/utils/common_widget.dart';
import 'package:capusle_rewards/shared/utils/widget_to_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:capusle_rewards/models/user.dart' as userModel;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final GlobalKey iconKey = GlobalKey();
  final DatabaseController _databaseController = Get.find();

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print(appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final authResult = await _auth.signInWithCredential(oauthCredential);
      await _handleAuthResult(authResult);
    } catch (exception) {
      print(exception);
    }
  }

  // Google sign-in
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("Google user: $googleUser");
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        await _handleAuthResult(authResult);

        // print("User signed in with Google: ${authResult.user?.displayName}");
        // _saveUserInfo(authResult.user!, 'google');
        // _checkAuth(authResult.user!, 'google');

        // _navigateToHome();
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  // Facebook sign-in
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult? result = await _facebookAuth.login();
      if (result != null) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        print("User signed in with Facebook: ${authResult.user?.displayName}");
        // _saveUserInfo(authResult.user!, 'facebook');
        // _checkAuth(authResult.user!, 'facebook');
        _navigateToHome();
      }
    } catch (e) {
      print("Error signing in with Facebook: $e");
    }
  }

  // Save user information to GetStorage
  void _saveUserInfo(userModel.User user, String provider) {
    print("Saving user info to GetStorage: ${user.id}");
    StorageUtil.save('uid', user.id);
    StorageUtil.save('displayName', user.name);
    StorageUtil.save('email', user.email);
    StorageUtil.save('photoURL', user.photoUrl);
    StorageUtil.save('provider', provider);
  }

  void signOut() {
    _auth.signOut();
    _googleSignIn.signOut();
    var apiRepository = Get.find<ApiRepository>();
    apiRepository.logout();

    StorageUtil.clear();
    EasyLoading.dismiss();

    Get.offAllNamed('/auth');
  }

  void _navigateToHome() {
    Get.offAllNamed('/home');
  }

  void takeAuth(GlobalKey widgetKey) async {
    if (await Permission.storage.request().isGranted) {
      printPngBytes(widgetKey);
    }
  }

  Future _handleAuthResult(UserCredential authResult) async {
    final idToken = await authResult.user!.getIdToken();

    printInfo(info: idToken.toString());

    final ApiRepository apiRepository = Get.find();

    final result = await apiRepository.firebaseLogin(idToken);
    printInfo(info: result.toString());

    result.fold((left) => CommonWidget.toast(left.error), (right) {
      printInfo(info: right.token);
      StorageUtil.save('token', right.token);
      _saveUserInfo(right.user, 'google');
      // _checkAuth(right, 'google'),
      _navigateToHome();
    });
  }

  void deleteAccount() async {
    var apiRepository = Get.find<ApiRepository>();
    _auth.signOut();
    _googleSignIn.signOut();

    await apiRepository.deleteAccount();
    StorageUtil.clear();
    EasyLoading.dismiss();
    Get.offAllNamed('/auth');
  }

  // void _checkAuth(User user, String provider) async {
  //   try {
  //     DocumentSnapshot userDoc =
  //         await _databaseController.users.doc(user.uid).get();
  //     if (!userDoc.exists) {
  //       // User does not exist in Firestore, create a new document
  //       var newUser = userModel.User(
  //           id: user.uid,
  //           name: user.displayName ?? '',
  //           email: user.email ?? '',
  //           photoUrl: user.photoURL,
  //           provider: provider);
  //       await _databaseController.addUser(newUser);
  //     } else {
  //       // Update the user's photoUrl in the Firestore document
  //       await _databaseController.users.doc(user.uid).update({
  //         'photoUrl': user.photoURL,
  //         'provider': provider,
  //       });
  //     }
  //   } catch (e) {
  //     // Handle login error
  //     print(e.toString());
  //   }
  // }

}
