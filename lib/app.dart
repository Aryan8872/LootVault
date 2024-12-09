import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loot_vault/view/login_view.dart';


class MyApp extends StatelessWidget {
  final bool isDark ;
  const MyApp({super.key,this.isDark=false});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:"/",
      routes: {
        "/":(context)=> const LoginView(),

      
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