import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String check = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        username: _userNameController.text,
        bio: _bioController.text,
        file: _image!);

    if (check != 'success') {
      showSnackBar(context, check);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.blueAccent,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                TextFieldInput(
                    textEditingController: _userNameController,
                    hintText: 'Enter your user name',
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: 'Enter your Email',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(height: 24),
                TextFieldInput(
                    textEditingController: _passController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    isPass: true),
                const SizedBox(height: 24),
                TextFieldInput(
                    textEditingController: _bioController,
                    hintText: 'Enter your bio',
                    textInputType: TextInputType.text),
                const SizedBox(height: 12),
                InkWell(
                  onTap: signUpUser,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Center(
                            child: Text('Sign Up'),
                          ),
                          decoration: ShapeDecoration(
                            color: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text('Already have an account?'),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: navigateToLogIn,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
