import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitfn,
    this._isLoading
  );

  final bool _isLoading;

  final void Function(String email, String password, String username,
      bool isLoggedIn, BuildContext ctx) submitfn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogedIn = true;
  String _userEmail = '';
  String _userName = '';
  String _password = '';

  void _trySubmit() {
    final isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isvalid) {
      _formKey.currentState!.save();
      widget.submitfn(_userEmail.trim(), _password.trim(), _userName.trim(),
          _islogedIn, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(12),
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              InputDecoration(labelText: 'Email Address'),
                          onSaved: (value) {
                            _userEmail = value!;
                          },
                        ),
                        if (!_islogedIn)
                          TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value!.length < 5) {
                                return 'UserName must be atleast 5 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'UserName'),
                            onSaved: (value) {
                              _userName = value!;
                            },
                          ),
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Password must be atleast 7 characters long!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (widget._isLoading)
                            CircularProgressIndicator(),
                        if (!widget._isLoading) 
                        ElevatedButton(
                            onPressed: _trySubmit,
                            child: Text(_islogedIn ? 'Login' : 'Signup')),
                        if (!widget._isLoading)
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _islogedIn = !_islogedIn;
                              });
                            },
                            child: Text(_islogedIn
                                ? 'Create new account'
                                : 'I already have an account'))
                      ],
                    )))),
      ),
    );
  }
}
