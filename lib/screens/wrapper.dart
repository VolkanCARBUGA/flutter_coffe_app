import 'package:flutter/material.dart';
import 'package:flutter_coffe_app/model/user.dart';
import 'package:flutter_coffe_app/screens/auth/auth.dart';
import 'package:flutter_coffe_app/screens/home/home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    debugPrint(user.toString());

    if (user == null) {
      return  Authenticate();
    }else
return Home();
    
  }
}