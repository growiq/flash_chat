import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/rounded_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController? logo_controller;
  AnimationController? color_controller;
  Animation? logo_animation;
  Animation? color_animation;

  @override
  void initState() {
    super.initState();

    color_controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    logo_controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    logo_animation =
        CurvedAnimation(parent: logo_controller!, curve: Curves.decelerate);

    color_animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(color_controller!);

    logo_controller?.forward();
    color_controller?.forward();

    // controller?.addStatusListener((status) {
    //   if(status == AnimationStatus.completed) {
    //     controller?.reverse(from: 1.0);
    //   } else if(status == AnimationStatus.dismissed) {
    //     controller?.forward();
    //   }
    // });

    logo_controller?.addListener(() {
      setState(() {});
    });

    color_controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    logo_controller?.dispose();
    color_controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_animation!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logo_animation!.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: const ['Flash Chat'],
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              title: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void getMessages() async {
//   final messages = await _firestore.collection('messages').get();
//
//   print(messages);
//
//   for (var message in messages.docs) {
//     print(message.data());
//   }
// }

// void messagesStream() async {
//   await for (var snapshot in _firestore.collection('messages').snapshots()) {
//     for (var message in snapshot.docs) {
//       print(message.data());
//     }
//   }
// }