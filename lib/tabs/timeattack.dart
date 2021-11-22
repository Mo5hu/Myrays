import 'package:flutter/material.dart';

class TimeAttack extends StatefulWidget {
  const TimeAttack({Key? key}) : super(key: key);

  @override
  _TimeAttackState createState() => _TimeAttackState();
}

class _TimeAttackState extends State<TimeAttack> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          // signInWithFacebook();
          // Provider.of<StateOfInteraction>(context, listen: false)
          //     .stateChanged(1);
        },
        child:
            Text('GO', style: TextStyle(fontSize: 24, color: Colors.grey[900])),
        style: OutlinedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(24),
        ),
      ),
    );
  }
}

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken!.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
