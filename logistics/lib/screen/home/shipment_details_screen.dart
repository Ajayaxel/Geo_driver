import 'package:flutter/material.dart';
import 'package:logistics/widgets/btn.dart';
import 'package:logistics/screen/home/documents_screen.dart';
import 'package:logistics/screen/home/pickup_process_screen.dart';

enum ShipmentStatus {
  assigned,
  pickedUp,
  atExportFacility,
  customsCleared,
  inTransit,
  arrivedAtDestination,
  delivered,
}

class ShipmentDetailsScreen extends StatefulWidget {
  const ShipmentDetailsScreen({super.key});

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  int _uploadedCount = 0;
  final int _totalCount = 7;
  ShipmentStatus _status = ShipmentStatus.assigned;

  void _showToast(String message, Color color) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        right: 16,
        left: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  String _getButtonText() {
    switch (_status) {
      case ShipmentStatus.assigned:
        return "Start Pickup";
      case ShipmentStatus.pickedUp:
        return "At Export Facility";
      case ShipmentStatus.atExportFacility:
        return "Customs Cleared";
      case ShipmentStatus.customsCleared:
        return "Start Transit";
      case ShipmentStatus.inTransit:
        return "Confirm Arrival";
      case ShipmentStatus.arrivedAtDestination:
        return "Confirm Delivery";
      case ShipmentStatus.delivered:
        return "Delivered";
    }
  }

  Future<void> _handleAction() async {
    switch (_status) {
      case ShipmentStatus.assigned:
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PickupProcessScreen()),
        );
        if (result == true) {
          setState(() {
            _status = ShipmentStatus.pickedUp;
            _uploadedCount = 7;
          });
          _showToast("Pickup Completed Successfully", Colors.green);
        }
        break;
      case ShipmentStatus.pickedUp:
        setState(() => _status = ShipmentStatus.atExportFacility);
        _showToast("At Export Facility Reached", Colors.green);
        break;
      case ShipmentStatus.atExportFacility:
        setState(() => _status = ShipmentStatus.customsCleared);
        _showToast("Customs Cleared Successfully", Colors.green);
        break;
      case ShipmentStatus.customsCleared:
        setState(() => _status = ShipmentStatus.inTransit);
        _showToast("Transit Started", Colors.green);
        break;
      case ShipmentStatus.inTransit:
        setState(() => _status = ShipmentStatus.arrivedAtDestination);
        _showToast("Arrival Confirmed", Colors.green);
        break;
      case ShipmentStatus.arrivedAtDestination:
        setState(() => _status = ShipmentStatus.delivered);
        _showToast("Delivered Successfully", Colors.green);
        break;
      case ShipmentStatus.delivered:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xffEEEEEE)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipment Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '#SH-2024-001',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'High',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xffEEEEEE)),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shipment Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Information Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildInfoGrid(),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xffF9F9F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Kinshasa, DRC',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  child: Text(
                                    'Cape Town, South Africa',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Shipment Timeline',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Timeline
                    _buildTimelineItem(
                      title: 'Shipment Assigned',
                      subtitle: '10:00 AM, Dec 16',
                      icon: Icons.check_circle,
                      iconColor: Colors.green,
                      isFirst: true,
                      isActive: true,
                      index: 0,
                    ),
                    _buildTimelineItem(
                      title: 'Picked Up',
                      subtitle: _status.index >= ShipmentStatus.pickedUp.index
                          ? '11:30 AM, Dec 16'
                          : null,
                      icon: _status.index >= ShipmentStatus.pickedUp.index
                          ? Icons.check_circle
                          : Icons.access_time,
                      iconColor: _status.index >= ShipmentStatus.pickedUp.index
                          ? Colors.green
                          : Colors.orange,
                      isActive: true,
                      index: 1,
                    ),
                    _buildTimelineItem(
                      title: 'At Export Facility',
                      subtitle:
                          _status.index >= ShipmentStatus.atExportFacility.index
                          ? '11:30 AM, Dec 16'
                          : null,
                      icon:
                          _status.index >= ShipmentStatus.atExportFacility.index
                          ? Icons.check_circle
                          : (_status == ShipmentStatus.pickedUp
                                ? Icons.access_time
                                : null),
                      iconColor:
                          _status.index >= ShipmentStatus.atExportFacility.index
                          ? Colors.green
                          : (_status == ShipmentStatus.pickedUp
                                ? Colors.orange
                                : null),
                      isActive: _status.index >= ShipmentStatus.pickedUp.index,
                      index: 2,
                    ),
                    _buildTimelineItem(
                      title: 'Customs Cleared',
                      subtitle:
                          _status.index >= ShipmentStatus.customsCleared.index
                          ? '11:30 AM, Dec 16'
                          : null,
                      icon: _status.index >= ShipmentStatus.customsCleared.index
                          ? Icons.check_circle
                          : (_status == ShipmentStatus.atExportFacility
                                ? Icons.access_time
                                : null),
                      iconColor:
                          _status.index >= ShipmentStatus.customsCleared.index
                          ? Colors.green
                          : (_status == ShipmentStatus.atExportFacility
                                ? Colors.orange
                                : null),
                      isActive:
                          _status.index >=
                          ShipmentStatus.atExportFacility.index,
                      index: 3,
                    ),
                    _buildTimelineItem(
                      title: 'In Transit',
                      subtitle: _status.index >= ShipmentStatus.inTransit.index
                          ? '11:30 AM, Dec 16'
                          : null,
                      icon: _status.index >= ShipmentStatus.inTransit.index
                          ? Icons.check_circle
                          : (_status == ShipmentStatus.customsCleared
                                ? Icons.access_time
                                : null),
                      iconColor: _status.index >= ShipmentStatus.inTransit.index
                          ? Colors.green
                          : (_status == ShipmentStatus.customsCleared
                                ? Colors.orange
                                : null),
                      isActive:
                          _status.index >= ShipmentStatus.customsCleared.index,
                      index: 4,
                    ),
                    _buildTimelineItem(
                      title: 'Arrived at Destination',
                      subtitle:
                          _status.index >=
                              ShipmentStatus.arrivedAtDestination.index
                          ? '11:30 AM, Dec 16'
                          : null,
                      icon:
                          _status.index >=
                              ShipmentStatus.arrivedAtDestination.index
                          ? Icons.check_circle
                          : (_status == ShipmentStatus.inTransit
                                ? Icons.access_time
                                : null),
                      iconColor:
                          _status.index >=
                              ShipmentStatus.arrivedAtDestination.index
                          ? Colors.green
                          : (_status == ShipmentStatus.inTransit
                                ? Colors.orange
                                : null),
                      isActive: _status.index >= ShipmentStatus.inTransit.index,
                      index: 5,
                    ),
                    _buildTimelineItem(
                      title: 'Delivered',
                      subtitle: _status.index >= ShipmentStatus.delivered.index
                          ? '11:30 AM, Dec 16'
                          : null,
                      icon: _status.index >= ShipmentStatus.delivered.index
                          ? Icons.check_circle
                          : (_status == ShipmentStatus.arrivedAtDestination
                                ? Icons.access_time
                                : null),
                      iconColor: _status.index >= ShipmentStatus.delivered.index
                          ? Colors.green
                          : (_status == ShipmentStatus.arrivedAtDestination
                                ? Colors.orange
                                : null),
                      isActive:
                          _status.index >=
                          ShipmentStatus.arrivedAtDestination.index,
                      isLast: true,
                      index: 6,
                    ),

                    const SizedBox(height: 15),

                    // Documents Section
                    InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DocumentsScreen(),
                          ),
                        );
                        if (result != null && result is int) {
                          setState(() {
                            _uploadedCount = result;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.description,
                              color: Color(0xffBA983F),
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Documents',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '$_uploadedCount/$_totalCount Uploaded',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    if (_status != ShipmentStatus.delivered)
                      Btn(
                        text: _getButtonText(),
                        onPressed: () => _handleAction(),
                      ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.chat_bubble_outline,
                                size: 20,
                              ),
                              label: const Text('Chat Supplier'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff757575),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xffEEEEEE),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Raise Issue',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoGrid() {
    return Column(
      children: [
        Row(
          children: [
            _buildInfoItem('Batch ID', 'BATCH-456'),
            _buildInfoItem('Mineral Type', 'Cobalt Ore'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildInfoItem('Weight', '25,000 kg'),
            _buildInfoItem('Containers', '2 units'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildInfoItem('Buyer', 'Global Mining Corp'),
            _buildInfoItem('Supplier', 'Congo Minerals Ltd'),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    String? subtitle,
    IconData? icon,
    Color? iconColor,
    bool isFirst = false,
    bool isLast = false,
    bool isActive = false,
    int index = 0,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  if (!isFirst)
                    Expanded(
                      child: CustomPaint(
                        size: const Size(2, double.infinity),
                        painter: DashedLinePainter(
                          color: isActive
                              ? Colors.green
                              : const Color(0xffEEEEEE),
                        ),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: icon != null
                        ? Icon(icon, color: iconColor, size: 24)
                        : Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xffE0E0E0),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xff757575),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: CustomPaint(
                        size: const Size(2, double.infinity),
                        painter: DashedLinePainter(
                          color: isActive
                              ? Colors.green
                              : const Color(0xffEEEEEE),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isActive ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Always render a SizedBox to maintain height and prevent expansion jumps
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      )
                    else
                      const SizedBox(
                        height: 14,
                      ), // Placeholder height for subtitle
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    this.dashHeight = 5,
    this.dashSpace = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
