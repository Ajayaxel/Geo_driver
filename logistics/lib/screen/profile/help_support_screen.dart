import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F6F6),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
        centerTitle: true,
        title: Text(
          'Help & Support',
          style: TextStyle(
            color: Colors.black,
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isTablet ? 24 : 16),
            Text(
              'How can we help?',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isTablet ? 16 : 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildContactItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Live Chat',
                    subtitle: 'Chat with our support team',
                    onTap: () {},
                    isTablet: isTablet,
                  ),
                  const Divider(height: 1, color: Color(0xffEEEEEE)),
                  _buildContactItem(
                    icon: Icons.phone_outlined,
                    title: 'Phone Support',
                    subtitle: '+971 5524 55232',
                    onTap: () {},
                    isTablet: isTablet,
                  ),
                  const Divider(height: 1, color: Color(0xffEEEEEE)),
                  _buildContactItem(
                    icon: Icons.mail_outline,
                    title: 'Email Support',
                    subtitle: 'support@goe.com',
                    onTap: () {},
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),
            SizedBox(height: isTablet ? 32 : 24),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isTablet ? 16 : 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildFaqItem(
                    question: 'How do I start a pickup?',
                    answer:
                        'Navigate to the shipment details screen and tap "Start Pickup". Follow the on-screen instructions to confirm your arrival, take photos, and verify the container seal.',
                    isTablet: isTablet,
                    initiallyExpanded: false,
                  ),
                  const Divider(height: 1, color: Color(0xffEEEEEE)),
                  _buildFaqItem(
                    question: 'What documents do I need to upload?',
                    answer:
                        'You need to upload the Bill of Lading, Weight Bridge Ticket, and any relevant customs documents as specified in the shipment details.',
                    isTablet: isTablet,
                  ),
                  const Divider(height: 1, color: Color(0xffEEEEEE)),
                  _buildFaqItem(
                    question: 'How do I report an issue?',
                    answer:
                        'Tap on "Raise Issue" in the shipment details screen and select the type of issue you are facing.',
                    isTablet: isTablet,
                  ),
                  const Divider(height: 1, color: Color(0xffEEEEEE)),
                  _buildFaqItem(
                    question: 'Can I work offline?',
                    answer:
                        'Yes, you can perform most actions offline. Data will be synced once you are back online.',
                    isTablet: isTablet,
                  ),
                  const Divider(height: 1, color: Color(0xffEEEEEE)),
                  _buildFaqItem(
                    question: 'How do I chat with admin?',
                    answer:
                        'Go to the messages tab and select the admin contact to start a conversation.',
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isTablet,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? 20 : 16,
        vertical: isTablet ? 8 : 4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.black, size: isTablet ? 28 : 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: isTablet ? 18 : 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildFaqItem({
    required String question,
    required String answer,
    required bool isTablet,
    bool initiallyExpanded = false,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        title: Text(
          question,
          style: TextStyle(
            fontSize: isTablet ? 17 : 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        childrenPadding: EdgeInsets.only(
          left: isTablet ? 20 : 16,
          right: isTablet ? 20 : 16,
          bottom: isTablet ? 20 : 16,
        ),
        expandedAlignment: Alignment.topLeft,
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: isTablet ? 15 : 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
