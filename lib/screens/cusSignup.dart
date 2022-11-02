import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dreams/pallette.dart';
import 'package:dreams/services/authService.dart';
import 'package:dreams/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  bool status = false;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final currUser = FirebaseAuth.instance.currentUser;

  /*final imgRef = FirebaseStorage.instance
      .ref()
      .child("images/img1.jpg")
      .putFile(File("images/img1.jpg"));*/

  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  late File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailcontroler = TextEditingController();
    final TextEditingController passwordcontroler = TextEditingController();
    final TextEditingController _namecontroller = TextEditingController();
    final TextEditingController _dobcontroller = TextEditingController();
    final TextEditingController _mobilecontroller = TextEditingController();
    final TextEditingController _controller = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/regis.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            //uncomment this and
                            // backgroundImage: _imageFile == null
                            //     ? AssetImage("assets/profile.jpeg")
                            //     : FileImage(File(_imageFile.path))
                            //         as ImageProvider,
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kblue,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet()),
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: kWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                      controller: _namecontroller,
                      icon: FontAwesomeIcons.user,
                      hint: 'Full Name',
                      obscureText: false,
                      Inputtype: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controller: _dobcontroller,
                      icon: FontAwesomeIcons.calendar,
                      hint: 'Date of Birth',
                      obscureText: false,
                      Inputtype: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controller: emailcontroler,
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      obscureText: false,
                      Inputtype: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controller: _mobilecontroller,
                      icon: FontAwesomeIcons.mobile,
                      hint: 'Mobile Number',
                      obscureText: false,
                      Inputtype: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controller: _controller,
                      icon: FontAwesomeIcons.calendar,
                      hint: 'Confirm Password',
                      obscureText: true,
                      Inputtype: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: 'Register',
                      onPressed: () async {
                        if (emailcontroler.text == _controller.text) {
                          await authService.createUserWithEmailAndPassword(
                              emailcontroler.text, passwordcontroler.text);

                          authService.signInWithEmailAndPassword(
                              emailcontroler.text, passwordcontroler.text);

                          final uid = currUser!.uid;

                          print(uid);

                          users
                              .add({
                                'Full name': _namecontroller.text,
                                'DoB': _dobcontroller.text,
                                'Email': emailcontroler.text,
                                'Mobile Number': _mobilecontroller.text,
                                'Vendor': false,
                                'userID': uid
                              })
                              .then((value) => print("user added"))
                              .catchError((error) =>
                                  print("Failed to add user: $error"));

                          Navigator.pop(context);
                        }
                        ;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: kobodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Login',
                            style: kobodyText.copyWith(
                                color: kblue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Padding _textBuilder(TextEditingController controler, String title,
      IconData icon, bool _obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          maxLines: 8,
          controller: controler, //email controler
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Icon(
                icon,
                size: 15,
                color: Colors.white,
              ),
            ),
            hintText: title,
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          style: TextStyle(fontSize: 15, color: Colors.white, height: 1.5),
          keyboardType: TextInputType.multiline,
          obscureText: _obscureText,
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageFile = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }
}
