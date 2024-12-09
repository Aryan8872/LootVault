import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loot_vault/widgets/shadow_inputbox.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _largeGap = const SizedBox(height: 25);
  final _normalgap = const SizedBox(height: 18);
  final _smallgap = const SizedBox(height: 10);
  final _cornerRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(
          240, 247, 255, 1), //0xFFE6E8EB  //0xFFD3D3D3  //0xFFE6E6FA
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

                

                _largeGap,

                const Text(
                  "REGISTER",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),

                _largeGap,

                //username texfield

                const ShadowInputbox(
                  labelText: "Fullname",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10
                  ),
                  fillColor: Colors.white,
                  prefixIcon: Icons.abc_rounded,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                  inputTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),
                  ),

                                  _normalgap,

                const ShadowInputbox(
                  labelText: "Email",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  fillColor: Colors.white,
                  prefixIcon: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  inputTextStyle: TextStyle(color: Colors.black, fontSize: 16),
                ),

              
                _normalgap,

                const ShadowInputbox(
                  labelText: "Phone Number",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  fillColor: Colors.white,
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.number,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  inputTextStyle: TextStyle(color: Colors.black, fontSize: 16),                  
                  ),


                _normalgap,

                // Password TextField

                  const ShadowInputbox(
                  labelText: "Password",
                  obscureText: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  fillColor: Colors.white,
                  prefixIcon: Icons.password,
                  keyboardType: TextInputType.number,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  inputTextStyle: TextStyle(color: Colors.black, fontSize: 16),
                ),
               


                _normalgap,

                 
                const ShadowInputbox(
                  labelText: "Re-type Password",
                  obscureText: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  fillColor: Colors.white,
                  prefixIcon: Icons.password,
                  keyboardType: TextInputType.number,
                  
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  inputTextStyle: TextStyle(color: Colors.black, fontSize: 16),
                ),



                _smallgap,
                _normalgap,

                // sign up button
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 107, 255, 1),
                      borderRadius: BorderRadius.circular(_cornerRadius),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

                _smallgap,

                //dont have an account section

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () =>{
                        Navigator.pushNamed(context, "/")
                        
                      },
                      style: const ButtonStyle(
                        
                      ),
                      child: const Text("Login",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.w500),
                      
                      ),
                     
                    )
                  ],
                ),





              ],
            ),
          ),
        ),
      )),
    );
  }
}
