import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

class loginWidget extends StatefulWidget {
  // const loginWidget({Key? key}) : super(key: key);

  @override
  _loginWidgetState createState() => _loginWidgetState();
}

class _loginWidgetState extends State<loginWidget> {
  GlobalKey<FormBuilderState> _formKey = GlobalKey();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            height: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text and Logo

                      //Card with login/Signup
                      SingleChildScrollView(
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 20,
                            ),
                            child: Column(children: [
                              //Sign Up / Log In
                              Text(
                                isLogin ? "Log In" : "Sign Up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height: 35,
                              ),
                              if (!isLogin)
                                FormBuilderTextField(
                                  name: "fname",
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                    hintText: "First Name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    focusColor: Colors.black,
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              if (!isLogin) SizedBox(height: 15),
                              if (!isLogin)
                                FormBuilderTextField(
                                  name: "lname",
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    focusColor: Colors.black,
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              // ]),
                              if (!isLogin) SizedBox(height: 15),
                              // ]),

                              FormBuilderTextField(
                                name: "mail",
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: "E-Mail",
                                  hintStyle: TextStyle(color: Colors.black),
                                  focusColor: Colors.black,
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              FormBuilderTextField(
                                name: "password",
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.black),
                                  focusColor: Colors.black,
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),

                              if (!isLogin)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FormBuilderTextField(
                                      name: "confirmPassword",
                                      style: TextStyle(color: Colors.black87),
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        focusColor: Colors.black,
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        contentPadding: EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              SizedBox(
                                height: 25,
                              ),

                              RaisedButton(
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                  ),
                                  child: isLogin
                                      ? Text("Log In")
                                      : Text("Sign Up"),
                                ),
                                color: Colors.black87,
                                splashColor: Colors.white54,
                                elevation: 5,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      isLogin
                                          ? "Create a User"
                                          : "Already A User",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          isLogin = !isLogin;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                        ),
                                        child: isLogin
                                            ? Text("Sign Up")
                                            : Text("Log In"),
                                      ),
                                      color: Colors.black87,
                                      splashColor: Colors.white54,
                                      elevation: 5,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ])
                            ]),
                          ),
                        ),
                      ),

                      //Maybe text with copyright or whatevs in small fontSize
                    ]),
              )),
            ),
          )),
    );
  }
}
