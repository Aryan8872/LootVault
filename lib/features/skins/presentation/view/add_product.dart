import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController gameDescriptionController =
      TextEditingController();
  final TextEditingController gameNameController = TextEditingController();
  final TextEditingController gamePriceController = TextEditingController();
  final TextEditingController gameCategoryController = TextEditingController();
  GameCategoryEntity? _categoryDropdown;

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
    return null;
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
      context.read<GameBloc>().add(
            UploadGameImage(context: context, file: _img!),
          );
    }
    Navigator.pop(innercontext);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: isTablet ? _buildTabletLayout() : _buildMobileLayout(),
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildGeneralInformation(),
              const SizedBox(height: 24),
              _buildPricingSection(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildMediaSection(),
              const SizedBox(height: 24),
              _buildCategorySection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMediaSection(),
        const SizedBox(height: 24),
        _buildGeneralInformation(),
        const SizedBox(height: 24),
        _buildPricingSection(),
        const SizedBox(height: 24),
        _buildCategorySection(),
        const SizedBox(height: 18),
        _buildButton()
      ],
    );
  }

  Widget _buildGeneralInformation() {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: gameNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 4,
              controller: gameDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingSection() {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pricing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: gamePriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Base Price',
                      prefixText: '\$ ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Discount Percentage',
                      suffixText: '%',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaSection() {
    return Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min, // Prevent infinite width
                  children: [
                    Flexible(
                      // Add Flexible to buttons
                      child: ElevatedButton.icon(
                        onPressed: () {
                          checkCameraPermission();
                          _handleImageSelection(context, ImageSource.camera);
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
                          _handleImageSelection(context, ImageSource.gallery);
                        },
                        icon: const Icon(Icons.image, color: Colors.white),
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
        child: SizedBox(
          width: 144, // Fixed width
          height: 144, // Fixed height
          child: CircleAvatar(
            radius: 52,
            backgroundImage: _img != null
                ? FileImage(_img!)
                : const AssetImage('assets/images/upload_image.jpg')
                    as ImageProvider,
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.categories.isEmpty) {
                  return const Text('No categories available.');
                }
                return DropdownButtonFormField<GameCategoryEntity>(
                  items: state.categories
                      .map((e) => DropdownMenuItem<GameCategoryEntity>(
                            value: e,
                            child: Text(e.categoryName),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Game Category',
                    border: OutlineInputBorder(),
                  ),
                  value: _categoryDropdown,
                  onChanged: (value) {
                    setState(() {
                      _categoryDropdown = value!;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

Widget _buildButton() {
  return ElevatedButton(
    onPressed: () {
      final gameState = context.read<GameBloc>().state;
      final imageName = gameState.imageName;

      // ✅ Null checks before proceeding
      if (_categoryDropdown == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category.')),
        );
        return;
      }

      if (imageName == null) {
        print("image is empty--------------------------------------------------------------------------------");
        showMySnackBar(context: context, message: "imahe name is null hyaa");
        return;
      }

      context.read<GameBloc>().add(AddGame(
          gameName: gameNameController.text,
          gameDescription: gameDescriptionController.text,
          gameImagePath: imageName,
          category: _categoryDropdown!.categoryId,
          gamePrice: gamePriceController.text));
    },
    style: const ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.save),
        SizedBox(width: 8),
        Text('Save', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}

}
