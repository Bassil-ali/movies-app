import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/auth_controller.dart';
import 'package:my_movies_app/screens/register_screen.dart';
import 'package:my_movies_app/widgets/custom_text_field.dart';
import 'package:my_movies_app/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthController>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  Map<String, dynamic> _loginData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[buildTopBanner(), buildForm()]),
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
              _emailController.text = 'super_admin@app.com';
              _passwordController.text = 'password';
            },
            child: Center(
              child: Text('Login', style: TextStyle(fontSize: 25, color: Colors.black)),
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
            PrimaryButton(
              label: 'Login',
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  _loginData['email'] = _emailController.text;
                  _loginData['password'] = _passwordController.text;
                  authController.login(loginData: _loginData);
                }
              },
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(
                  () => RegisterScreen(),
                  preventDuplicates: false,
                );
              },
              child: Text('Create new account'),
            ),
          ],
        ),
      ),
    );
  } // end of Form
} //end of widget
