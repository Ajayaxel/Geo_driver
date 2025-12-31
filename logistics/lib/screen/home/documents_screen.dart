import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  late List<Map<String, dynamic>> _requiredDocuments;
  late List<Map<String, dynamic>> _optionalDocuments;
  String? _selectedDocName;

  @override
  void initState() {
    super.initState();
    _requiredDocuments = [
      {'name': 'Packing List', 'status': 'Required', 'isUploaded': false},
      {'name': 'Commercial Invoice', 'status': 'Required', 'isUploaded': false},
      {'name': 'Bill of Lading', 'status': 'Required', 'isUploaded': false},
      {
        'name': 'Certificate of Origin',
        'status': 'Required',
        'isUploaded': false,
      },
      {'name': 'QA Certificate', 'status': 'Required', 'isUploaded': false},
      {'name': 'Export Permit', 'status': 'Required', 'isUploaded': false},
      {'name': 'Customs Clearance', 'status': 'Required', 'isUploaded': false},
    ];
    _optionalDocuments = [
      {
        'name': 'Insurance Certificate',
        'status': 'Optional',
        'isUploaded': false,
      },
    ];
    _selectedDocName = 'QA Certificate';
  }

  int get _uploadedCount {
    int count = 0;
    for (var doc in _requiredDocuments) {
      if (doc['isUploaded']) count++;
    }
    for (var doc in _optionalDocuments) {
      if (doc['isUploaded']) count++;
    }
    return count;
  }

  int get _requiredCompleteCount {
    int count = 0;
    for (var doc in _requiredDocuments) {
      if (doc['isUploaded']) count++;
    }
    return count;
  }

  int get _totalDocuments =>
      _requiredDocuments.length + _optionalDocuments.length;
  int get _totalRequired => _requiredDocuments.length;

  Future<void> _handleUpload(Map<String, dynamic> doc) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        doc['isUploaded'] = true;
        doc['status'] = 'Uploaded';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _requiredCompleteCount);
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context, _requiredCompleteCount),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Documents',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '#SH-2024-001',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xffD20000),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'High',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildStatItem(
                      'Documents Uploaded',
                      '$_uploadedCount/$_totalDocuments',
                      isTablet,
                    ),
                    const SizedBox(width: 24),
                    _buildStatItem(
                      'Required Complete',
                      '$_requiredCompleteCount/$_totalRequired',
                      isTablet,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Required Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Required Documents List
              ..._requiredDocuments.map(
                (doc) => _buildDocumentCard(
                  name: doc['name'],
                  status: doc['status'],
                  isUploaded: doc['isUploaded'],
                  isTablet: isTablet,
                  isSelected: _selectedDocName == doc['name'],
                  onTap: () => setState(() => _selectedDocName = doc['name']),
                  onUpload: () => _handleUpload(doc),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Optional Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ..._optionalDocuments.map(
                (doc) => _buildDocumentCard(
                  name: doc['name'],
                  status: doc['status'],
                  isUploaded: doc['isUploaded'],
                  isTablet: isTablet,
                  isSelected: _selectedDocName == doc['name'],
                  onTap: () => setState(() => _selectedDocName = doc['name']),
                  onUpload: () => _handleUpload(doc),
                ),
              ),

              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Documents are automatically synced with Admin, Buyer, and Compliance records.',
                  style: TextStyle(fontSize: 13, color: Color(0xff616161)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: isTablet ? 14 : 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isTablet ? 20 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentCard({
    required String name,
    required String status,
    required bool isUploaded,
    required bool isTablet,
    required VoidCallback onUpload,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xffFFCC00), width: 2)
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.description,
                color: isUploaded ? const Color(0xffBA983F) : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: isTablet ? 13 : 11,
                      color: isUploaded
                          ? const Color(0xff4CAF50)
                          : const Color(0xffD20000),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (isUploaded)
              const Icon(Icons.check_circle, color: Color(0xff4CAF50), size: 28)
            else
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: onUpload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff616161),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
