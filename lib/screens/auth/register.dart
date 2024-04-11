// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffe_app/screens/home/home.dart';
import 'package:flutter_coffe_app/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_coffe_app/screens/auth/sign_in.dart';
import 'package:flutter_coffe_app/services/auth_services.dart';
import 'package:flutter_coffe_app/shared/constants.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        // backgroundColor: Colors.brown[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.brown,
          toolbarHeight: MediaQuery.of(context).size.height * 1 / 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0)),
          ),
          elevation: 0.0,
          titleSpacing: 0.0,
          title: Text(
            'Kahve Dünyası',
            style: GoogleFonts.kaushanScript(
                fontSize: MediaQuery.of(context).size.width * 0.1,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),

          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                
              ),
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size:MediaQuery.of(context).size.width * 0.09,
                fill: 1,
              ),
              label: Text(
                'Giriş Yap',
                style: GoogleFonts.kaushanScript(
                    color: Colors.white,
                    fontSize:  MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                widget.toggleView();
                // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>SignIn(
                //   toggleView: widget.toggleView,
                // )));
              },
            )
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: SignInForm(
              loading: loading,

            )));
  }
}

class SignInForm extends StatefulWidget {
  
  bool loading = false;

  SignInForm({

    Key? key,
    required this.loading
    
    
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  var email="";
  var password="";
  var errorMessage = "";
  var authServices = AuthServices();
  var name="";
   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: formKey,
          child: Column(children: <Widget>[
            Image.asset(
            'assets/app_icon.png',
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            fit: BoxFit.contain,
            color: Colors.brown,
          ),
          SizedBox(
            height: 20.0,
          ),
            TextFormField(
              autofocus: true,
              
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen İsminizi Giriniz';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: inputDecoration.copyWith(
                  labelText: "İsim",
                  suffixIcon: Icon(Icons.person, color: Colors.white),


                )),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen E Posta Adresinizi Giriniz';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: inputDecoration.copyWith(
                  labelText: "E Posta",
                  suffixIcon: Icon(Icons.email, color: Colors.white),
                )),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
                validator: (value) {
                  if (value!.length <= 6 || value.isEmpty) {
                    return 'Lütfen Sifrenizi Giriniz Ve En Az 6 Karakter Olmalıdır';
                  }
                  return null;
                },
                obscureText: true,
                obscuringCharacter: "*",
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: inputDecoration.copyWith(
                  labelText: "Sifre",
                  suffixIcon: Icon(
                    Icons.password,
                    color: Colors.white,
                  ),

                )),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                   
                    widget.loading = true;
                  });
                  var user = await authServices.registerWithEmailAndPassword(
                      email, password);
                  if (user == null) {
                    setState(() {
                      errorMessage = "Kayıt İşlemi Başarısız";
                      widget.loading = false;
                    });
                  } else {
                    setState(() {
                      widget.loading = true;
                    });
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) => Home()));
                  }
                }
              },
              child: Text(
                'Kayıt Ol',
                style: GoogleFonts.kaushanScript(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Text(
              errorMessage,
              style: GoogleFonts.kaushanScript(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ])),
    );
  }
}
