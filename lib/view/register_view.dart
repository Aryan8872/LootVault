import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loot_vault/core/common/shadow_inputbox.dart';

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




 final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController(text: "9815935689");
  final TextEditingController _passwordController = TextEditingController(text: "hari123");
  final TextEditingController _retypePasswordController = TextEditingController(text: "hari123");
  final TextEditingController _emailController = TextEditingController(text: "hari@gmail.com");
  final TextEditingController _fullNameController = TextEditingController(text: "hari bahadur");


  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }
  // Form validators
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 3) {
      return 'Full name should be at least 3 characters';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters long';
    }
    return null;
  }

  String? _retypePasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Real-time validation for password and retype password
  void _onPasswordChanged(String value) {
    setState(() {});
  }

  void _onRetypePasswordChanged(String value) {
    setState(() {});
  }


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
                                  './assets/images/backgroundless_logo.png')),
                        ),
                      ),
                    ),
                    _largeGap,
                    const Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 24),
                    ),
                    _largeGap,

                    // Fullname TextField with validation
                   ShadowInputbox(
                    labelText: 'Full Name',
                    prefixIcon: Icons.person,
                    controller: _fullNameController,
                    validator: _fullNameValidator,
                
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                    _normalgap,

                    // Email TextField with validation
                     ShadowInputbox(
                labelText: 'Email',
                prefixIcon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                onChanged: (value) {
                  setState(() {});
                },
              ),
                    _normalgap,

                    // Phone TextField with validation
                    ShadowInputbox(
                    labelText: 'Phone Number',
                    prefixIcon: Icons.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: _phoneValidator,
                    onChanged: (value) {
                    setState(() {});
                },
              ),
                    _normalgap,

                    // Password TextField with validation
                    ShadowInputbox(
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      controller: _passwordController,
                      obscureText: true,
                      validator: _passwordValidator,
                      onChanged: _onPasswordChanged,
                    ),
                    _normalgap,

                    // Confirm Password TextField with validation
                   ShadowInputbox(
                  labelText: 'Retype Password',
                  prefixIcon: Icons.lock,
                  controller: _retypePasswordController,
                  obscureText: true,
                  validator: _retypePasswordValidator,
                  onChanged: _onRetypePasswordChanged,
                  ),
                    _smallgap,
                    _normalgap,

                    // Sign Up Button
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, perform actions
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Account created sucessfully',style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 107, 255, 1),
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

                    // Already have an account section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w500),
                          ),
                        )
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
