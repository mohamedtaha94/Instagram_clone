import 'package:flutter/material.dart';
import 'package:hii/generated/l10n.dart';


class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _websiteController = TextEditingController();
    final TextEditingController _bioController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _genderController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            S.of(context).Cancel,
            style: const TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
        title: Text(
          S.of(context).EditProfile,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Call a method to handle profile update
              _updateProfile(
                  context,
                  _nameController.text,
                  _usernameController.text,
                  _websiteController.text,
                  _bioController.text,
                  _emailController.text,
                  _phoneController.text,
                  _genderController.text);
            },
            child: Text(
              S.of(context).Done,
              style: const TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          S.of(context).ChangeProfilePicture,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildEditableFieldWithDivider(
                    S.of(context).Name, _nameController),
                _buildEditableFieldWithDivider(
                    S.of(context).Username, _usernameController),
                _buildEditableFieldWithDivider(
                    S.of(context).Website, _websiteController),
                _buildEditableFieldWithDivider(
                  S.of(context).Bio,
                  _bioController,
                  maxLines: 3,
                  isFullWidthDivider: true,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).SwitchtoProfessionalAccount,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).PrivateInformation,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildEditableFieldWithDivider(
                    S.of(context).Email, _emailController),
                _buildEditableFieldWithDivider(
                    S.of(context).Phone, _phoneController),
                _buildEditableFieldWithDivider(
                    S.of(context).Gender, _genderController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile(
    BuildContext context,
    String name,
    String username,
    String website,
    String bio,
    String email,
    String phone,
    String gender,
  ) {
    // Handle profile update logic here
    // For example, send data to the backend or save it locally

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).Profileupdatedsuccessfully)),
    );

    // Close the screen
    Navigator.of(context).pop();
  }

  Widget _buildEditableFieldWithDivider(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    bool isFullWidthDivider = false,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        isFullWidthDivider
            ? Divider(
                thickness: 1,
                color: Colors.grey[300],
              )
            : Row(
                children: [
                  const SizedBox(width: 80),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
/*
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _websiteController = TextEditingController();
    final TextEditingController _bioController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _genderController = TextEditingController();

    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:  Text(
              S.of(context).Cancel,
              style:const TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ),
          title:  Text(
            S.of(context).EditProfile,
            style:const  TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                // Trigger the update profile function
                context.read<EditProfileCubit>().updateProfile(
                  name: _nameController.text,
                  username: _usernameController.text,
                  website: _websiteController.text,
                  bio: _bioController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  gender: _genderController.text,
                );
              },
              child: Text(
                S.of(context).Done,
                style:const  TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                Navigator.of(context).pop(); // Close the screen on success
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(S.of(context).Profileupdatedsuccessfully)),
                );
              } else if (state is EditProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/profile.jpg'),
                              ),
                              TextButton(
                                onPressed: () {},
                                child:  Text(
                                  S.of(context).Profileupdatedsuccessfully,
                                  style:const  TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                         const SizedBox(height: 20),
                        _buildEditableFieldWithDivider(S.of(context).Name, _nameController),
                        _buildEditableFieldWithDivider(S.of(context).Username, _usernameController),
                        _buildEditableFieldWithDivider(S.of(context).Website, _websiteController),
                        _buildEditableFieldWithDivider(
                          S.of(context).Bio,
                          _bioController,
                          maxLines: 3,
                          isFullWidthDivider: true,
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child:  Text(
                            S.of(context).SwitchtoProfessionalAccount,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 20),
                         Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).PrivateInformation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildEditableFieldWithDivider(S.of(context).Email, _emailController),
                        _buildEditableFieldWithDivider(S.of(context).Phone, _phoneController),
                        _buildEditableFieldWithDivider(S.of(context).Gender, _genderController),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEditableFieldWithDivider(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    bool isFullWidthDivider = false,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        isFullWidthDivider
            ? Divider(
                thickness: 1,
                color: Colors.grey[300],
              )
            : Row(
                children: [
                  const SizedBox(width: 80),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}*/