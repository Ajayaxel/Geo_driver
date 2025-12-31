import 'package:flutter/material.dart';
import 'package:logistics/screen/home/home_screen.dart';
import 'package:logistics/widgets/shipment_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // Sample data for Active shipments
  final List<Map<String, String>> activeShipments = [
    {
      'shipmentId': '#SH-2024-001',
      'priority': 'High',
      'origin': 'Kinshasa, DRC',
      'destination': 'Cape Town, South Africa',
      'status': 'Assigned',
      'time': '2hr ago',
    },
    {
      'shipmentId': '#SH-2024-002',
      'priority': 'Medium',
      'origin': 'Kinshasa, DRC',
      'destination': 'Cape Town, South Africa',
      'status': 'Assigned',
      'time': '2hr ago',
    },
  ];

  // Sample data for Completed shipments
  final List<Map<String, String>> completedShipments = [
    {
      'shipmentId': '#SH-2024-001',
      'priority': 'High',
      'origin': 'Kinshasa, DRC',
      'destination': 'Cape Town, South Africa',
      'status': 'Assigned',
      'time': '2hr ago',
    },
    {
      'shipmentId': '#SH-2024-002',
      'priority': 'Medium',
      'origin': 'Kinshasa, DRC',
      'destination': 'Cape Town, South Africa',
      'status': 'Assigned',
      'time': '2hr ago',
    },
    {
      'shipmentId': '#SH-2024-003',
      'priority': 'Low',
      'origin': 'Kinshasa, DRC',
      'destination': 'Cape Town, South Africa',
      'status': 'Assigned',
      'time': '2hr ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isTablet ? 24 : 18),
              // Header
              const HederWidget(),
              SizedBox(height: isTablet ? 24 : 20),

              // Title
              Text(
                'Shipment History',
                style: TextStyle(
                  fontSize: isTablet ? 28 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),

              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: isTablet ? 16 : 14),
                  decoration: InputDecoration(
                    hintText: 'Search shipments',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: isTablet ? 16 : 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: isTablet ? 28 : 24,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isTablet ? 16 : 12,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),

              // Tab Bar
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(4),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w500,
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Active'),
                          const SizedBox(width: 6),
                          Text(
                            '${activeShipments.length}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Completed'),
                          const SizedBox(width: 6),
                          Text(
                            '${completedShipments.length}',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),

              // Tab Bar View
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Active Tab
                    _buildShipmentList(activeShipments, isTablet),
                    // Completed Tab
                    _buildShipmentList(completedShipments, isTablet),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShipmentList(
    List<Map<String, String>> shipments,
    bool isTablet,
  ) {
    if (shipments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: isTablet ? 80 : 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No shipments found',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: isTablet ? 100 : 80),
      itemCount: shipments.length,
      itemBuilder: (context, index) {
        final shipment = shipments[index];
        return Padding(
          padding: EdgeInsets.only(bottom: isTablet ? 16 : 12),
          child: ShipmentCard(
            shipmentId: shipment['shipmentId']!,
            priority: shipment['priority']!,
            origin: shipment['origin']!,
            destination: shipment['destination']!,
            status: shipment['status']!,
            time: shipment['time']!,
          ),
        );
      },
    );
  }
}
