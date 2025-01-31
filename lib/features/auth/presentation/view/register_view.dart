import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/widget/shadow_inputbox.dart';
import 'package:loot_vault/features/auth/presentation/view/login_view.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

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

  // Real-time validation for password and retype password
  void _onPasswordChanged(String value) {
    setState(() {});
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  String? imagePath;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          imagePath = image.path.split('/').last;
          print("path set $imagePath");
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handleImageSelection(
      BuildContext innercontext, ImageSource source) async {
    await _browseImage(source);
    print("Selected image: $_img");
    if (_img != null) {
      context.read<RegisterBloc>().add(
            UploadImageEvent(context: context, img: _img!),
          );
    }
    Navigator.pop(innercontext);
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
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (innercontext) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: double.infinity, // Constrain the width
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize
                                      .min, // Prevent infinite width
                                  children: [
                                    Flexible(
                                      // Add Flexible to buttons
                                      child: ElevatedButton.icon(
                                        
                                        onPressed: () {
                                          checkCameraPermission();
                                          _handleImageSelection(
                                              context, ImageSource.camera);
                                        },
                                        icon: const Icon(Icons.camera,color: Colors.white,),
                                        label: const Text('Camera',style:TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    Flexible(
                                      // Add Flexible to buttons
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          checkCameraPermission();
                                          _handleImageSelection(
                                              context, ImageSource.gallery);
                                        },
                                        icon: const Icon(Icons.image,color: Colors.white),
                                        label: const Text('Gallery',style:TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 144, // Fixed width
                          height: 144, // Fixed height
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: _img != null
                                ? FileImage(_img!)
                                : const AssetImage(
                                        'assets/images/upload_image.jpg')
                                    as ImageProvider,
                          ),
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
                    ShadowInputbox(
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                      controller: _usernameController,
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

                    _smallgap,
                    _normalgap,

                    // Sign Up Button
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, perform actions

                          context.read<RegisterBloc>().add(RegisterUser(
                              context: context,
                              fullName: _fullNameController.text,
                              userName: _usernameController.text,
                              image: imagePath,    
                              email: _emailController.text,
                              phoneNo: _phoneController.text,
                              password: _passwordController.text));
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(const SnackBar(
                          //   content: Text(
                          //     'Account created sucessfully',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          //   backgroundColor: Colors.green,edge     
                          // ));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: getIt<LoginBloc>(),
                                    child: const LoginView(),
                                  ),
                                ));
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
