import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffe_app/screens/auth/register.dart';
import 'package:flutter_coffe_app/services/auth_services.dart';
import 'package:flutter_coffe_app/shared/constants.dart';
import 'package:flutter_coffe_app/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key, required this.toggleView});
  final Function toggleView;
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                
              ),
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.09,
                fill: 1,
              ),
              label: Text(
                'Kayıt Ol',
                style: GoogleFonts.kaushanScript(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                widget.toggleView();
                // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>Register(
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
   
   
    required this.loading,


    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
var email="";
  var password="";
  var errorMessage = "";
  var authServices = AuthServices();
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(children: [
            
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
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen e-posta adresinizi giriniz.';
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
                  suffixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                )),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
                validator: (value) {
                  if (value!.length <= 6 || value.isEmpty) {
                    return 'Şifreniz 6 karakterden uzun olmalıdır.';
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
                  suffixIcon: Icon( Icons.password, color: Colors.white),
                )),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    widget.loading = true;
                  });
                  var user = await authServices.signInWithEmailAndPassword(
                      email, password);
                  if (user == null) {
                    setState(() {
                      errorMessage = "Giriş İşlemi Başarısız";
                      widget.loading = false;
                    });
                  } else {

                  }
                }
              },
              child: Text(
                'Giriş Yap',
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
            SizedBox(
              height: 20.0,
            ),
            Text(
              errorMessage,
              style: GoogleFonts.kaushanScript(
                  color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),
            )
          ])),
    );
  }
}
