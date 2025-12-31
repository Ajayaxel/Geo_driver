import 'package:flutter/material.dart';
import 'package:logistics/screen/profile/personal_screen.dart';
import 'package:logistics/screen/profile/settings_screen.dart';
import 'package:logistics/screen/profile/help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: isTablet ? 32 : 10),
              // Title
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isTablet ? 32 : 10),

              // Profile Avatar
              CircleAvatar(
                radius: isTablet ? 60 : 50,
                backgroundColor: const Color(0xffD9D9D9),
                backgroundImage: const NetworkImage(
                  "https://img.freepik.com/premium-photo/cute-anime-boy-wallpaper_776894-110627.jpg?semt=ais_hybrid&w=740&q=80",
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),

              // User Name
              Text(
                'Hakim Sadike',
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Logistic Driver',
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: isTablet ? 32 : 15),

              // Stats Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
                child: Row(
                  children: [
                    _buildStatCard(
                      '24',
                      'Completed',
                      const Color(0xff2B8EFF),
                      isTablet,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      '3',
                      'In Progress',
                      const Color(0xffFEAB10),
                      isTablet,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      '98%',
                      'Success Rate',
                      const Color(0xff08A800),
                      isTablet,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 32 : 24),

              // Menu Items
              Container(
                margin: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      'Personal',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalScreen(),
                          ),
                        );
                      },
                      isTablet: isTablet,
                    ),
                    const Divider(height: 1, color: Color(0xffEEEEEE)),
                    _buildMenuItem(
                      'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      isTablet: isTablet,
                    ),
                    const Divider(height: 1, color: Color(0xffEEEEEE)),
                    _buildMenuItem(
                      'Terms and conditions',
                      onTap: () {},
                      isTablet: isTablet,
                    ),
                    const Divider(height: 1, color: Color(0xffEEEEEE)),
                    _buildMenuItem(
                      'Help & Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpSupportScreen(),
                          ),
                        );
                      },
                      isTablet: isTablet,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),

              // Sign Out
              Container(
                margin: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildMenuItem(
                  'Sign Out',
                  onTap: () {
                    _showSignOutDialog(context);
                  },
                  isTablet: isTablet,
                  textColor: const Color(0xffD20000),
                ),
              ),
              SizedBox(height: isTablet ? 32 : 24),

              // Version
              Text(
                'Global Ore Exchange v1.0.0',
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: isTablet ? 100 : 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    Color valueColor,
    bool isTablet,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 20 : 16,
          horizontal: isTablet ? 16 : 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: isTablet ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isTablet ? 14 : 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title, {
    required VoidCallback onTap,
    required bool isTablet,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 20 : 16,
          vertical: isTablet ? 18 : 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
                color: textColor ?? Colors.black,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: textColor ?? Colors.grey,
              size: isTablet ? 28 : 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to login screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed out successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Color(0xffD20000)),
            ),
          ),
        ],
      ),
    );
  }
}
