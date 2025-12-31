import 'package:flutter/material.dart';
import 'package:logistics/widgets/btn.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF6F6F6),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
              child: Column(
                children: [
                  SizedBox(height: isTablet ? 32 : 24),

                  // Profile Avatar with Camera Icon
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement image picker
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image picker coming soon!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: isTablet ? 60 : 50,
                              backgroundColor: const Color(0xffD9D9D9),
                              backgroundImage: const NetworkImage(
                                "https://img.freepik.com/premium-photo/cute-anime-boy-wallpaper_776894-110627.jpg?semt=ais_hybrid&w=740&q=80",
                              ),
                            ),
                            Container(
                              width: isTablet ? 120 : 100,
                              height: isTablet ? 120 : 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.3),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: isTablet ? 36 : 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        Text(
                          'Tap to change',
                          style: TextStyle(
                            fontSize: isTablet ? 16 : 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isTablet ? 40 : 32),

                  // Form Fields
                  _buildTextField(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    icon: Icons.person_outline,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isTablet ? 16 : 12),

                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isTablet ? 16 : 12),

                  _buildTextField(
                    controller: _phoneController,
                    hintText: 'Phone',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isTablet ? 16 : 12),

                  _buildTextField(
                    controller: _addressController,
                    hintText: 'Base Address',
                    icon: Icons.location_on_outlined,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isTablet ? 40 : 32),
                ],
              ),
            ),
          ),

          // Save Changes Button
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: isTablet ? 24 : 20,
            ),
            child: Btn(text: "Save Changes", onPressed: () {}),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isTablet,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: isTablet ? 16 : 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: isTablet ? 16 : 14,
          ),
          prefixIcon: Icon(
            icon,
            color: Color(0xff000000),
            size: isTablet ? 28 : 24,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 16,
            vertical: isTablet ? 18 : 16,
          ),
        ),
      ),
    );
  }
}
