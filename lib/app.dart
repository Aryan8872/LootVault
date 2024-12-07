import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loot_vault/view/login_view.dart';
import 'package:loot_vault/view/register_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:"/",
      routes: {
        "/":(context)=> const LoginView(),
        "/register":(context) => const RegisterView(),
      },
      theme: ThemeData(
        appBarTheme:const AppBarTheme(

        ),
        textTheme: const TextTheme(

        ),
      ),


    );
  }
}