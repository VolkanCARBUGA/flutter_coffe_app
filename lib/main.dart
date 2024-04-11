import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffe_app/firebase_options.dart';
import 'package:flutter_coffe_app/model/user.dart';
import 'package:flutter_coffe_app/screens/wrapper.dart';
import 'package:flutter_coffe_app/services/auth_services.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
  value: AuthServices().user,
 initialData: null,
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Wrapper(),
  ),
);

  }
}

