import 'package:flutter/material.dart';
import 'package:loot_vault/widgets/shadow_inputbox.dart';

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
                ShadowInputbox(
                  labelText: "Email",
                  prefixIcon: Icons.email,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  contentPadding: const EdgeInsets.symmetric(vertical:20 ,horizontal:10 ),
                  keyboardType: TextInputType.emailAddress,
                  controller: TextEditingController(),
                  inputTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
                ),


                _normalgap,

                //password field

                const ShadowInputbox(
                  labelText:"Password" ,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  prefixIcon: Icons.password_rounded,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                  inputTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),

                  ),
                       

                _smallgap,

                // forgot password area

                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot password ?")],
                ),

                _normalgap,

                // sign in button

                GestureDetector(
                  onTap: ()=> {
                    Navigator.pushNamed(context, "/home")
                    
                  },
                  child: Container(
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
                ),

                _smallgap,

                //dont have an account section

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    const SizedBox(
                      width: 8,
                    ),
                    
                    TextButton(
                      onPressed: () => {
                        Navigator.pushNamed(context, "/register")
                      },
                      child: const Text("Create one",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.w500),
                    )
                     
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
