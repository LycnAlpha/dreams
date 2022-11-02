import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dreams/pallette.dart';
import 'package:dreams/widgets/backgroundImage.dart';
import 'package:dreams/widgets/roundedButton.dart';
import 'package:dreams/widgets/textInputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dreams/Utils/utils.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailcontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/regis.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
            title: Text(
              'Forgot Password',
              style: kobodyText,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Text(
                        'Enter your email we will send instruction to reset your password',
                        style: kobodyText,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      controller: emailcontroler,
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      Inputtype: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Send',
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: emailcontroler.text);

                        showSnackBar(
                            context, "Password reset link sent to the email");
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
