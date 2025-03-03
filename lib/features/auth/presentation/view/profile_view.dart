import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_event.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildAccountSettings(context),
            const SizedBox(height: 80), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext contextProfile) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              // Using image from AuthApiModel
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/100'),
                // This would use the 'image' field from your model
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle profile picture change
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Using userName from AuthApiModel
          const Text(
            'GameMaster5000', // This would be userName from model
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // Using fullName from AuthApiModel in place of level info
          const Text(
            'John Doe', // This would be fullName from model
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              _showEditProfileDialog(contextProfile);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          // Using email from AuthApiModel
          _buildSettingItem(
            icon: Icons.email,
            title: 'Email Address',
            subtitle: 'gamer5000@example.com', // This would be email from model
            onTap: () => _showEditEmailDialog(context),
          ),
          // Using password from AuthApiModel
          _buildSettingItem(
            icon: Icons.vpn_key,
            title: 'Password',
            subtitle: 'Last changed 3 months ago',
            onTap: () => _showChangePasswordDialog(context),
          ),
          // Adding phoneNo from AuthApiModel
          _buildSettingItem(
            icon: Icons.phone,
            title: 'Phone Number',
            subtitle: '+1 123-456-7890', // This would be phoneNo from model
            onTap: () => _showEditPhoneDialog(context),
          ),
          // Keeping linked accounts section
          _buildSettingItem(
            icon: Icons.login_outlined,
            title: 'Linked Accounts',
            subtitle: 'Steam, Xbox, PlayStation',
            onTap: () {
              // Open linked accounts settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1E88E5),
                size: 20,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // Dialog methods
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  EditProfileDialog(context: context,);
      },
    );
  }

  void _showEditEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Email Address'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: 'gamer5000@example.com'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save email changes
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save password changes
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // New dialog for editing phone number
  void _showEditPhoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Phone Number'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: '+1 123-456-7890'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

// Updated EditProfileDialog to match the AuthApiModel fields

class EditProfileDialog extends StatefulWidget {
  BuildContext context;
   EditProfileDialog({super.key, required this.context});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController phNo = TextEditingController();
  TextEditingController userNameCont = TextEditingController();
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

  TextEditingController fullName = TextEditingController();

  @override
  void dispose() {
    emailCont.dispose();
    passwordCont.dispose();
    phNo.dispose();
    userNameCont.dispose();
    fullName.dispose();
    super.dispose();
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
      context.read<UserBloc>().add(
            UploadImageEvent(context: context, img: _img!),
          );
    }
    Navigator.pop(innercontext);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://via.placeholder.com/100'),
            ),
            TextButton(
              onPressed: () {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize:
                            MainAxisSize.min, // Prevent infinite width
                        children: [
                          Flexible(
                            // Add Flexible to buttons
                            child: ElevatedButton.icon(
                              onPressed: () {
                                checkCameraPermission();
                                _handleImageSelection(
                                    context, ImageSource.camera);
                              },
                              icon: const Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                              label: const Text('Camera',
                                  style: TextStyle(color: Colors.white)),
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
                              icon:
                                  const Icon(Icons.image, color: Colors.white),
                              label: const Text('Gallery',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Change Picture'),
            ),
            const SizedBox(height: 10),
            // Full Name field from AuthApiModel
            TextField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              controller: fullName,
            ),
            const SizedBox(height: 10),
            // Username field from AuthApiModel
            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: userNameCont,
            ),

            const SizedBox(height: 10),
            // Username field from AuthApiModel
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: emailCont,
            ),
            const SizedBox(height: 10),
            // Phone Number field from AuthApiModel
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              controller: phNo,
            ),
            const SizedBox(height: 10),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: passwordCont,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final userDataResult = await tokenSharedPrefs.getUserData();
            userDataResult.fold(
              (failure) {
                // Handle failure to get user data
                showMySnackBar(
                  context: context,
                  message: 'Failed to get user data: ${failure.message}',
                  color: Colors.red,
                );
              },
              (userData) {
                final userId = userData['userId'];
                if (userId != null &&
                    userId.isNotEmpty &&
                    emailCont.text.isNotEmpty &&
                    passwordCont.text.isNotEmpty) {
                  context.read<UserBloc>().add(UpdateUser(
                      context: context,
                      fullName: fullName.text,
                      userId: userId,
                      userName: userNameCont.text,
                      email: emailCont.text,
                      phoneNo: phNo.text,
                      password: passwordCont.text));

                  showMySnackBar(
                    context: context,
                    message: 'Successfully edited details',
                    color: Colors.green,
                  );

                  // Navigate back to the previous screen
                  Navigator.pop(context, true);
                } else {
                  // Show error if fields are empty or user data is invalid
                  showMySnackBar(
                    context: context,
                    message: 'Please fill in all fields',
                    color: Colors.red,
                  );
                }
              },
            );
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E88E5),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
