import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/widget/shadow_inputbox.dart';
import 'package:loot_vault/features/auth/presentation/view/register_view.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _largeGap = const SizedBox(height: 25);
  final _normalgap = const SizedBox(height: 18);
  final _smallgap = const SizedBox(height: 10);

  final TextEditingController _emailController =
      TextEditingController(text: "i@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "ishiki123");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 247, 255, 1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Logo
                    SizedBox(
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipOval(
                            child: Image.asset(
                              './assets/images/backgroundless_logo.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    _largeGap,
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                    _largeGap,

                    // Email field with validation
                    ShadowInputbox(
                      labelText: "Email",
                      prefixIcon: Icons.email,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      inputTextStyle:
                          const TextStyle(color: Colors.black, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Simple email validation
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    _normalgap,

                    // Password field with validation
                    ShadowInputbox(
                      labelText: "Password",
                      fillColor: Colors.white,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      prefixIcon: Icons.password_rounded,
                      labelStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      inputTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    _smallgap,

                    // Forgot password area
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text("Forgot password ?")],
                    ),
                    _normalgap,

                    // Sign in button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // If the form is valid, navigate to the home screen
                          context.read<LoginBloc>().add(LoginUserEvent(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text));
                        }
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _smallgap,

                    // Don't have an account section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () => {
                            context.read<LoginBloc>().add(
                                NavigateRegisterScreenEvent(
                                    context: context,
                                    destination: const RegisterView()))
                          },
                          child: const Text(
                            "Create one",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
