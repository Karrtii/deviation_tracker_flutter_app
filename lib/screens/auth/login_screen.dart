import 'package:deviation_tracker_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:deviation_tracker_flutter_app/services/webservices/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({Key? key, required this.loginUser, required this.register}) : super(key: key);
  //
  // final Function(UserModel? user) loginUser;
  // final Function() register;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _authService = AuthService();
  final _authStorage = UserLocalStorageService();

  final _formKey = GlobalKey<FormState>();

  String _userEmail = "", _password = "", _errorMessage = "";
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     // IconButton(
      //     //   onPressed: (){
      //     //     Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      //     //   },
      //     //   icon: SvgPicture.asset("assets/images/lego-brick.svg", color: Colors.white, height: 20,),
      //     // )
      //   ],
      // ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/sgrebg.png"),
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: colorGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2.2, defaultPadding, defaultPadding/2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "Email address is required"),
                              EmailValidator(errorText: "Email is in wrong format")
                            ]
                          ),
                          obscureText: false,
                          onChanged: (userEmail){
                            setState(() {
                              _userEmail = userEmail;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email Address"
                          ),
                        ),
                        SizedBox(height: defaultPadding,),
                        TextFormField(
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "Password field is required"),
                              MinLengthValidator(5, errorText: "Password must have at least 5 characters")
                            ]
                          ),
                          obscureText: true,
                          onChanged: (password) {
                            setState(() {
                              _password = password;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"
                          ),
                        ),
                        SizedBox(height: defaultPadding/2,),
                        Row(
                          children: [
                            Text("Don't have account yet?"),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/register");
                              },
                              child: Text("Click here to register!"),
                            )
                          ],
                        ),
                        SizedBox(height: defaultPadding/2,),
                        _error ? Text(_errorMessage, style: TextStyle(color: Colors.red),) : Container(),
                        _error ? SizedBox(height: defaultPadding/2,) : Container(),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if(_formKey.currentState!.validate()) {
                                var user = await _authService.loginUser(
                                    _userEmail, _password);
                                if (user == null) {
                                  print("Error");
                                  _error = true;
                                  _errorMessage = "Wrong password or account does not exist";
                                }
                                else {
                                  _error = true;
                                  await _authStorage.saveUser(user);
                                  Navigator.of(context).pushReplacementNamed("/home");
                                }
                              }
                            },
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(primary: Colors.purple),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.14,
                ),
                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              )
          ),
        ],
      ),
    );
  }
}
