import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _largeGap = const SizedBox(height: 25);
  final _normalgap = const SizedBox(height: 18);
  final _smallgap = const SizedBox(height: 10);
  final _cornerRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1), //0xFFE6E8EB  //0xFFD3D3D3  //0xFFE6E6FA
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //logo
                SizedBox(
                    child: CircleAvatar(
                  radius: 56, //radius of avatar
                  backgroundColor: Colors.green, //color
                  child: Padding(
                    padding: const EdgeInsets.all(5), // Border radius
                    child: ClipOval(
                        child: Image.asset(
                            './assets/images/backgroundless_logo.png')),
                  ),
                )),


                // const Text(
                //   "Welcome to",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 16),
                // ),

                // const Text(
                //   "LootVault",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.w800,
                //       fontSize: 24),
                // ),

                _largeGap,

                const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),

                _largeGap,

                //username texfield

                 Container(
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(26), 
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, 
                        offset: Offset(0, 4), 
                        blurRadius: 6, 
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: const BorderSide(
                            width: 0), 
                      ),

                      filled: true,
                      fillColor:
                          Colors.white, 
                      prefixIcon: const Icon(
                        Icons.person_2_rounded,
                        size: 20,
                      ),
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.black), 
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10), 
                    ),
                  ),
                ),


                _normalgap,


                // Password TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(26), 
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, 
                        offset: Offset(0, 4), 
                        blurRadius: 6, 
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: true, 
                    decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0 
                        ),
                      ),

                      filled: true,
                      fillColor:
                          Colors.white, 
                      prefixIcon: const Icon(
                        Icons.password,
                        size: 20,
                      ),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.black), // Label color
                      contentPadding:const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10), 
                    ),
                  ),
                ),


                _smallgap,


                // forgot password area

                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot password ?")],
                ),

                _normalgap,

                // sign in button

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 107, 255, 1),
                    borderRadius: BorderRadius.circular(_cornerRadius),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                _smallgap,

                //dont have an account section

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Create one",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
