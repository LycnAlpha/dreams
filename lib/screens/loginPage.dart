import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:dreams/widgets/widgets.dart';
import 'package:dreams/pallette.dart';
import 'package:dreams/resources/authMethods.dart';
import 'package:dreams/responsive/mobileScreenLayout.dart';
import 'package:dreams/responsive/responsiveLayout.dart';
import 'package:dreams/responsive/webScreenLayout.dart';
import 'package:dreams/Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailcontroler = TextEditingController();
    final TextEditingController passwordcontroler = TextEditingController();
    bool _isLoading = false;

    @override
    void dispose() {
      super.dispose();
      emailcontroler.dispose();
      passwordcontroler.dispose();
    }

    void loginUser() async {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().loginUser(
          email: emailcontroler.text, password: passwordcontroler.text);
      if (res == 'success') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ),
            ),
            (route) => false);

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "    Invalide Email or Password !");
      }
    }

    void loginGoogleUser() async {
      setState(() {
        _isLoading = true;
      });

      if (await AuthMethods().signInWithGoogle() != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ),
            ),
            (route) => false);

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "    Invalide Email or Password !");
      }
    }

    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/login.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Image.asset("assets/lg.png", height: 145.0),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    TextInputField(
                      controller: emailcontroler,
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      Inputtype: TextInputType.text,
                      inputAction: TextInputAction.next,
                      obscureText: false,
                    ),
                    TextInputField(
                      controller: passwordcontroler,
                      icon: FontAwesomeIcons.lock,
                      hint: 'Password',
                      obscureText: true,
                      Inputtype: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, 'ForgotPassword'),
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                fontSize: 15, color: Colors.white, height: 1.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                        buttonName: 'LOGIN',
                        onPressed: () async {
                          if (emailcontroler.text == "admin@dreams.com" &&
                              passwordcontroler.text == "admin@123") {
                            String respond = await AuthMethods().loginUser(
                                email: emailcontroler.text,
                                password: passwordcontroler.text);
                            Navigator.pushNamed(context, 'AdminPanel');
                          } else {
                            loginUser();
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text(
                    'Create a New Account',
                    style: kobodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RoundedButton_Google_signin(
                  buttonName: 'Sign in with Google',
                  onPressed: () async {
                    loginGoogleUser();
                  }),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}
