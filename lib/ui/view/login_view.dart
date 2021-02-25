import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_connects/businees_logic/view_models/login_viewmodel.dart';
import 'package:tp_connects/ui/view/home_view.dart';

class LoginView extends StatefulWidget {
  LoginView({
    Key key,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _passwordCtrl = TextEditingController(), _usernameCtrl = TextEditingController();
  LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void didChangeDependencies() {
    _loginViewModel.getUserDetails().then((value) {
      if (value != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => _loginViewModel,
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: Padding(
            padding: EdgeInsets.only(
                left: 32.0,
                top: 32.0,
                right: 32.0,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom == 0.0 ? 32.0 : MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      TextFormField(
                        controller: _usernameCtrl,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String value) =>
                            value.trim().isNotEmpty ? null : "Enter a valid username or phone number",
                        decoration: InputDecoration(
                            labelText: "Username or phone number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value.length >= 6 ? null : "Password should be greater than 6 character",
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              await model.userLogin(_usernameCtrl.text, _passwordCtrl.text);
                              print("userDetails :: ${model.defaultResponse}  ${child.runtimeType}");

                              if (model.defaultResponse.status) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
                              } else {
                                _scaffoldKey.currentState
                                    .showSnackBar(SnackBar(content: Text("${model.defaultResponse.userResponse}")));
                              }
                            } on Exception catch (e) {
                              print(e);
                            }
                          } else {}
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Forgot your password?",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.green,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Don't have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).disabledColor, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "  Register",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
