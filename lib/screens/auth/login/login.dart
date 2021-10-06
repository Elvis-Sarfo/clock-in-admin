import 'package:clock_in_admin/components/cus_text_form_field.dart';
import 'package:clock_in_admin/components/custom_alert_dailog.dart';
import 'package:clock_in_admin/components/error_message.dart';
import 'package:clock_in_admin/components/main_button.dart';
import 'package:clock_in_admin/controllers/page_route.controller.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/screens/main/main_screen.dart';
import 'package:clock_in_admin/services/auth_services.dart';
import 'package:clock_in_admin/services/database_services.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:clock_in_admin/utils/form_validator.dart';
import 'package:clock_in_admin/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String? _email, _password, _errorMsg;
  bool _isLoading = false;

  _togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Center(
        child: Stack(
          children: [
            //content
            _buildContent(context, _width, _height),

            //Circle Avatar
            _buildLogo(),
          ],
        ),
      ),
    );
  }

  _buildContent(BuildContext context, double _width, double _height) {
    return Container(
      padding: const EdgeInsets.only(
        left: Constants.padding,
        top: Constants.avatarRadius + Constants.padding,
        right: Constants.padding,
        bottom: Constants.padding,
      ),
      constraints: BoxConstraints(
        maxWidth: Responsive.isMobile(context) ? _width * 0.95 : _width * 0.3,
        maxHeight: _height,
      ),
      margin: const EdgeInsets.only(top: Constants.avatarRadius),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[700] ?? Styles.primaryColor,
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Login With Your Credentials',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        //student field
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.person,
                              color: Styles.primaryColor),
                          hintText: 'Email',
                          onSaved: (value) {
                            _email = value;
                          },
                          onChange: (value) {
                            setState(() {
                              _errorMsg = '';
                            });
                          },
                          validator: validateEmail,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //password field
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.lock,
                              color: Styles.primaryColor),
                          suffixIcon: InkWell(
                            onTap: _togglePassword,
                            child: Icon(
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Styles.primaryColor,
                            ),
                          ),
                          hintText: 'Password',
                          isPasswordFeild: hidePassword ? true : false,
                          onChange: (value) {
                            setState(() {
                              _errorMsg = '';
                            });
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Required';
                            }
                            return null;
                          },
                        ),
                        if (_errorMsg != null && _errorMsg!.isNotEmpty)
                          ErrorMessage(
                            title: 'Error',
                            msg: _errorMsg,
                          ),

                        MainButton(
                          isLoading: _isLoading,
                          color: Styles.primaryColor,
                          title: 'LOGIN',
                          tapEvent: () async {
                            await _login(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    try {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          var userCredential = await Auth.loginWithEmailAndPassword(
            _email!,
            _password!,
          );

          if (userCredential is UserCredential) {
            var snapshot = await FirestoreDB.getDocByField(
              'admins',
              'email',
              _email,
            );

            if (snapshot.docs.isNotEmpty) {
              var admin = snapshot.docs.first.data();
              context
                  .read<PageRouteController>()
                  .setAdminUsername(admin['firstname']);
              sendToPage(context, MainScreen());
            } else {
              setState(() {
                _isLoading = false;
                _errorMsg = 'You are not registered';
              });
            }
          } else {
            setState(() {
              _isLoading = false;
              _errorMsg = 'Invalid credentials';
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
        _errorMsg = e.toString();
      });
    }
  }

  _buildLogo() {
    return Positioned(
      left: Constants.padding,
      right: Constants.padding,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: Constants.avatarRadius,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                Constants.avatarRadius,
              ),
            ),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
