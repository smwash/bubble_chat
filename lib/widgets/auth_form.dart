import 'dart:io';

import 'package:bubble_chat/constants.dart';
import 'package:bubble_chat/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm({this.submitFn, this.isLoading});
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;

  void _getPickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _trySubmit() {
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No Image Selected'),
          backgroundColor: Colors.red[300],
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userName.trim(), _userPassword.trim(),
          _userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kSecWhiteColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isLogin) UserImagePicker(imagePickFn: _getPickedImage),
            TextFormField(
              key: ValueKey('userEmail'),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Please Enter A valid Email Address';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: kIconColor,
                ),
              ),
              onSaved: (value) {
                _userEmail = value;
              },
            ),
            SizedBox(height: 10.0),
            if (!_isLogin)
              TextFormField(
                key: ValueKey('userName'),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.isEmpty || value.length < 4) {
                    return 'Please enter atleast 4 characters';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'UserName',
                  prefixIcon: Icon(
                    Icons.person,
                    color: kIconColor,
                  ),
                ),
                onSaved: (value) {
                  _userName = value;
                },
              ),
            SizedBox(height: 10.0),
            TextFormField(
              key: ValueKey('userPassword'),
              validator: (value) {
                if (value.isEmpty || value.length < 7) {
                  return 'Password must be atleast 7 character long';
                }
                return null;
              },
              obscureText: _obscureText,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: kIconColor,
                ),
                suffixIcon: IconButton(
                  icon: _obscureText
                      ? Icon(
                          Icons.visibility_off,
                          color: kButtonColor.withOpacity(0.6),
                        )
                      : Icon(
                          Icons.visibility,
                          color: kButtonColor.withOpacity(0.6),
                        ),
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              onSaved: (value) {
                _userPassword = value;
              },
            ),
            SizedBox(height: 10.0),
            if (widget.isLoading)
              SpinKitThreeBounce(
                color: kIconColor,
                size: MediaQuery.of(context).size.height * 0.07,
              ),
            if (!widget.isLoading)
              RaisedButton(
                  elevation: 0.0,
                  color: kButtonColor,
                  child: Text(_isLogin ? 'LogIn' : 'SignUp'),
                  onPressed: _trySubmit),
            SizedBox(height: 5.0),
            if (!widget.isLoading)
              FlatButton(
                child: Text(
                  _isLogin ? 'Create an account?' : 'I already have an account',
                  style: TextStyle(color: kButtonColor),
                ),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
