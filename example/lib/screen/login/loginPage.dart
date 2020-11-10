import 'dart:developer';

import 'package:HubboxVpnApp/data/database_helper.dart';
import 'package:HubboxVpnApp/models/User.dart';
import 'package:HubboxVpnApp/screen/home/HomePage.dart';
import 'package:HubboxVpnApp/screen/login/login_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth.dart';
import '../../global.dart' as globals;
import '../../global.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginScreenContract, AuthStateListener {
  final formKey = new GlobalKey<FormState>();

  // final scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext _ctx;
  LoginScreenPresenter _presenter;
  bool _isLoading = false;
  bool _isRembemerMe = false;
  String _username, _password;

  // remberMe
  bool get rememberMe => _isRembemerMe;

  void handleRememberMe(bool value) {
    print("Handle Rember Me");
    _isRembemerMe = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
      },
    );
    setState(() {});
  }

  _LoginPageState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    // var currentScaffold = globalScaffoldKey.currentState;
    // currentScaffold
    //     .hideCurrentSnackBar(); // If there is a snackbar visible, hide it before the new one is shown.
    // currentScaffold.showSnackBar(SnackBar(content: Text(text)));
    globals.ScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  Widget remberMeCheckBox() {
    return Row(children: <Widget>[
      Checkbox(
        value: _isRembemerMe,
        onChanged: handleRememberMe,
      ),
      Expanded(child: Text("Remember me", style: TextStyle(color: Colors.black87))),
    ]);
    return CheckboxListTile(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      checkColor: Theme.of(context).primaryColor,
      value: _isRembemerMe,
      onChanged: handleRememberMe,
      title: Text(
        "Remember me",
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 14),
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final username = TextFormField(
      onSaved: (val) => _username = val,
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: 'hbbx-',
      validator: (val) {
        return val.length < 5 ? "Username must have atleast 5 chars" : null;
      },
      decoration: InputDecoration(
        hintText: 'Hubbox Account Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      onSaved: (val) => _password = val,
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: _submit,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final form = new Form(
        key: formKey,
        child: new Column(children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          username,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 24.0),
          _isLoading ? new CircularProgressIndicator() : loginButton,
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: remberMeCheckBox(),
            ),
            Expanded(
              child: forgotLabel,
            )
          ]),
        ]));

    return Scaffold(
      backgroundColor: Colors.white,
      key: globals.ScaffoldKey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[form],
        ),
      ),
    );
  }

  @override
  void onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN) Navigator.of(_ctx).pushReplacementNamed(HomePage.tag);
    if (state == AuthState.LOGGED_OUT) AuthStateProvider().dispose(this);
  }

  @override
  void dispose() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.dispose(this);
    super.dispose();
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  Future<void> onLoginSuccess(User user) async {
    // _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    if (_isRembemerMe) {
      var db = new DatabaseHelper();
      try {
        await db.saveUser(user);
      } catch (error, stackTrace) {
        await sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    }
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}
