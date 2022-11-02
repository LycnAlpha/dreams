import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.Inputtype,
    required this.inputAction,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType Inputtype;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          controller: controller, //email controler
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
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          style: TextStyle(fontSize: 15, color: Colors.white, height: 1.5),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          obscureText: obscureText,
        ),
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10.0),
    //   child: Container(
    //     height: size.height * 0.08,
    //     width: size.width * 0.8,
    //     decoration: BoxDecoration(
    //       color: Colors.grey[500]!.withOpacity(0.5),
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     child: Center(
    //       child: TextField(
    //         controller: controller,
    //         decoration: InputDecoration(
    //           border: InputBorder.none,
    //           prefixIcon: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //             child: Icon(
    //               icon,
    //               size: 28,
    //               color: Colors.white,
    //             ),
    //           ),
    //           hintText: hint,
    //           hintStyle: kobodyText,
    //         ),
    //         keyboardType: Inputtype,
    //         textInputAction: inputAction,
    //       ),
    //     ),
    //   ),
    // );
  }
}
