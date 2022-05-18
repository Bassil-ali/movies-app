import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/auth_controller.dart';
import 'package:my_movies_app/screens/login_screen.dart';
import 'package:my_movies_app/widgets/custom_text_field.dart';
import 'package:my_movies_app/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.find<AuthController>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _hidePasswordConfirmation = true;
  Map<String, dynamic> _registerData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        buildTopBanner(),
        buildForm(),
      ]),
    );
  }

  Widget buildTopBanner() {
    return Container(
      height: 250,
      color: Colors.amber,
      child: Stack(
        // alignment: Alignment.bottomLeft,
        children: <Widget>[
          InkWell(
            onTap: () {
              _nameController.text = 'user1';
              _emailController.text = 'user1@app.com';
              _passwordController.text = 'password';
              _passwordConfirmationController.text = 'password';
            },
            child: Center(
              child: Text('Register', style: TextStyle(fontSize: 25, color: Colors.black)),
            ),
          ),
          Positioned(
            top: 10,
            left: 1,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          )
        ],
      ),
    );
  } // end of TopBanner

  Widget buildForm() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        // autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: <Widget>[
            //name
            CustomTextField(
              label: 'Name',
              controller: _nameController,
              textInputType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name field is required';
                }
              },
            ),

            //email
            CustomTextField(
              label: 'Email',
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email field is required';
                }
              },
            ),

            //password
            CustomTextField(
              label: 'Password',
              obscureText: _hidePassword,
              controller: _passwordController,
              textInputType: TextInputType.text,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                icon: _hidePassword == true ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password field is required';
                }
              },
            ),

            //password_confirmation
            CustomTextField(
              label: 'Confirm password',
              obscureText: _hidePasswordConfirmation,
              controller: _passwordConfirmationController,
              textInputType: TextInputType.text,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePasswordConfirmation = !_hidePasswordConfirmation;
                  });
                },
                icon: _hidePasswordConfirmation == true
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password confirmation field is required';
                }
              },
            ),

            PrimaryButton(
              label: 'Register',
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  _registerData['name'] = _nameController.text;
                  _registerData['email'] = _emailController.text;
                  _registerData['password'] = _passwordController.text;
                  _registerData['password_confirmation'] = _passwordConfirmationController.text;
                  authController.register(registerData: _registerData);
                }
              },
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.off(() => LoginScreen());
              },
              child: Text('Already have an account ?'),
            ),
          ],
        ),
      ),
    );
  } // end of Form
} //end of widget
