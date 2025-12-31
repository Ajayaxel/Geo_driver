import 'package:flutter/material.dart';
import 'package:logistics/widgets/shipment_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
                 SizedBox(height: 18,),
              const HederWidget(),
              const SizedBox(height: 10),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search shipments',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Stats Cards
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _buildStatCard(
                      '2',
                      'Active',
                      const Color(0xffE3F2FD),
                      Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      '3',
                      'Completed',
                      const Color(0xffE8F5E9),
                      Colors.green,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      '1',
                      'Priority',
                      const Color(0xffFFF3E0),
                      Colors.orange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Active Shipments Title
              const Text(
                'Active Shipments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Shipment List
              const ShipmentCard(
                shipmentId: '#SH-2024-001',
                priority: 'High',
                origin: 'Kinshasa, DRC',
                destination: 'Cape Town, South Africa',
                status: 'Assigned',
                time: '2hr ago',
              ),
              const ShipmentCard(
                shipmentId: '#SH-2024-001',
                priority: 'High',
                origin: 'Kinshasa, DRC',
                destination: 'Cape Town, South Africa',
                status: 'Assigned',
                time: '2hr ago',
              ),
              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String count,
    String label,
    Color bgColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class HederWidget extends StatelessWidget {
  const HederWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xffD9D9D9),
              backgroundImage: NetworkImage(
                "https://img.freepik.com/premium-photo/cute-anime-boy-wallpaper_776894-110627.jpg?semt=ais_hybrid&w=740&q=80",
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Hey, hakim',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.network(
                      'https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Hand%20gestures/Waving%20Hand.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xffEEEEEE)),
          ),
          child: const Icon(Icons.notifications_none, color: Colors.black),
        ),
      ],
    );
  }
}
