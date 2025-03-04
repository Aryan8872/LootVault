import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_event.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = getIt<UserBloc>();
    final tokenSharedPrefs = getIt<TokenSharedPrefs>();
    
    // Fetch user data when the widget is first built
    _fetchUserData(context, userBloc, tokenSharedPrefs);

    return BlocProvider.value(
      value: userBloc,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF0F4F9),
            body: RefreshIndicator(
              onRefresh: () async {
                await _fetchUserData(context, userBloc, tokenSharedPrefs);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildProfileHeader(context, state, tokenSharedPrefs, userBloc),
                    _buildAccountSettings(context, state),
                    const SizedBox(height: 80), // Bottom padding
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _fetchUserData(BuildContext context, UserBloc userBloc, TokenSharedPrefs tokenSharedPrefs) async {
    final userDataResult = await tokenSharedPrefs.getUserData();
    return userDataResult.fold(
      (failure) {
        showMySnackBar(
          context: context,
          message: 'Failed to fetch user data: ${failure.message}',
          color: Colors.red,
        );
        return Future.value();
      },
      (userData) {
        final userId = userData['userId'];
        if (userId != null) {
          userBloc.add(GetUserData(context: context, userId: userId));
        }
        return Future.value();
      },
    );
  }

  Widget _buildProfileHeader(
    BuildContext context, 
    UserState state, 
    TokenSharedPrefs tokenSharedPrefs,
    UserBloc userBloc
  ) {
    ImageProvider profileImage;
    if (state.isSuccess && state.image != null && state.image!.isNotEmpty) {
      profileImage = NetworkImage(state.image!);
    } else {
      profileImage = const AssetImage('assets/images/avatar_placeholder.png');
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: profileImage,
                onBackgroundImageError: (exception, stackTrace) {
                  debugPrint('Error loading profile image: $exception');
                },
                backgroundColor: Colors.grey.shade300,
                child: state.isSuccess && state.image != null && state.image!.isNotEmpty
                    ? null
                    : const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: InkWell(
                  onTap: () async {
                    final didUpdate = await _showEditProfileDialog(context, state, tokenSharedPrefs);
                    if (didUpdate == true) {
                      // Force refresh profile data
                      _fetchUserData(context, userBloc, tokenSharedPrefs);
                    }
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
          Text(
            state.isSuccess && state.username.isNotEmpty ? state.username : 'Username',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            state.isSuccess && state.fullName.isNotEmpty ? state.fullName : 'Full Name',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              final didUpdate = await _showEditProfileDialog(context, state, tokenSharedPrefs);
              if (didUpdate == true) {
                // Force refresh profile data
                _fetchUserData(context, userBloc, tokenSharedPrefs);
              }
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

  Widget _buildAccountSettings(BuildContext context, UserState state) {
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
          _buildSettingItem(
            icon: Icons.email,
            title: 'Email Address',
            subtitle: state.isSuccess && state.email.isNotEmpty ? state.email : 'No email provided',
            isEditable: false,
          ),
          _buildSettingItem(
            icon: Icons.vpn_key,
            title: 'Password',
            subtitle: 'Last changed 3 months ago',
            isEditable: false,
          ),
          _buildSettingItem(
            icon: Icons.phone,
            title: 'Phone Number',
            subtitle: state.isSuccess && state.phoneNo.isNotEmpty ? state.phoneNo : 'No phone number provided',
            isEditable: false,
          ),
          _buildSettingItem(
            icon: Icons.login_outlined,
            title: 'Linked Accounts',
            subtitle: 'Steam, Xbox, PlayStation',
            isEditable: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isEditable = true,
    VoidCallback? onTap,
  }) {
    return Padding(
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
          if (isEditable)
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
        ],
      ),
    );
  }

  Future<bool?> _showEditProfileDialog(
    BuildContext context, 
    UserState state,
    TokenSharedPrefs tokenSharedPrefs
  ) async {
    // Return true if profile was updated, false otherwise
    return showDialog<bool>(
      context: context,
      builder: (context) => BlocProvider.value(
        value: getIt<UserBloc>(),
        child: EditProfileDialog(
          initialState: state,
          tokenSharedPrefs: tokenSharedPrefs,
        ),
      ),
    );
  }
}

class EditProfileDialog extends StatefulWidget {
  final UserState initialState;
  final TokenSharedPrefs tokenSharedPrefs;
  
  const EditProfileDialog({
    super.key,
    required this.initialState,
    required this.tokenSharedPrefs,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailCont;
  late TextEditingController passwordCont;
  late TextEditingController phNo;
  late TextEditingController userNameCont;
  late TextEditingController fullName;

  File? _img;
  String? imagePath;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with existing data
    emailCont = TextEditingController(text: widget.initialState.email);
    passwordCont = TextEditingController();
    phNo = TextEditingController(text: widget.initialState.phoneNo);
    userNameCont = TextEditingController(text: widget.initialState.username);
    fullName = TextEditingController(text: widget.initialState.fullName);
  }

  @override
  void dispose() {
    emailCont.dispose();
    passwordCont.dispose();
    phNo.dispose();
    userNameCont.dispose();
    fullName.dispose();
    super.dispose();
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          imagePath = image.path;
          _img = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () {
                  _browseImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _browseImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isUploading = true;
      });
      
      final userDataResult = await widget.tokenSharedPrefs.getUserData();
      userDataResult.fold(
        (failure) {
          setState(() {
            _isUploading = false;
          });
          showMySnackBar(
            context: context,
            message: 'Failed to get user data: ${failure.message}',
            color: Colors.red,
          );
        },
        (userData) async {
          final userId = userData['userId'];
          if (userId != null && 
              emailCont.text.isNotEmpty &&
              passwordCont.text.isNotEmpty) {
            
            // Extract filename from image path if available
            String? filename;
            if (imagePath != null) {
              filename = imagePath!.split('/').last;
              
              // If there's a new image, upload it first
              if (_img != null) {
                context.read<UserBloc>().add(UploadImageEvent(
                  context: context,
                  img: _img!,
                ));
                
                // Small delay to ensure image upload is processed
                await Future.delayed(const Duration(milliseconds: 500));
              }
            }

            // Update user data
            context.read<UserBloc>().add(UpdateUser(
              context: context,
              image: filename,
              fullName: fullName.text,
              userId: userId,
              userName: userNameCont.text,
              email: emailCont.text,
              phoneNo: phNo.text,
              password: passwordCont.text,
            ));

            // Return true to indicate profile was updated
            Navigator.pop(context, true);
            
            // Show success message
            showMySnackBar(
              context: context,
              message: 'Profile updated successfully',
              color: Colors.green,
            );
          } else {
            setState(() {
              _isUploading = false;
            });
            showMySnackBar(
              context: context,
              message: 'Please fill in all required fields',
              color: Colors.red,
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construct the image widget for display
    Widget profileImage;
    if (_img != null) {
      // Show selected image
      profileImage = CircleAvatar(
        radius: 40,
        backgroundImage: FileImage(_img!),
      );
    } else if (widget.initialState.isSuccess && 
               widget.initialState.image != null && 
               widget.initialState.image!.isNotEmpty) {
      // Show existing profile image from network
      profileImage = CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(widget.initialState.image!),
        onBackgroundImageError: (exception, stackTrace) {
          debugPrint('Error loading profile image: $exception');
        },
      );
    } else {
      // Show placeholder
      profileImage = CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey.shade300,
        child: const Icon(Icons.person, size: 40, color: Colors.grey),
      );
    }

    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  profileImage,
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: InkWell(
                      onTap: _showImageSourceSheet,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                controller: fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                controller: userNameCont,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: emailCont,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                controller: phNo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                controller: passwordCont,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), // Return false to indicate no update
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isUploading ? null : _saveProfile, // Disable when uploading
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E88E5),
          ),
          child: _isUploading 
            ? const SizedBox(
                width: 20, 
                height: 20, 
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
              ) 
            : const Text('Save'),
        ),
      ],
    );
  }
}