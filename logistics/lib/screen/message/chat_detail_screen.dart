import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String role;
  final String imageUrl;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some demo messages
    _messages.addAll([
      ChatMessage(
        text:
            "Shipment has been assigned to you. Please confirm pickup by 3 PM.",
        isMe: false,
        time: "09:11",
        senderName: widget.name,
        senderRole: widget.role,
      ),
      ChatMessage(
        text: "Confirmed. I will arrive at the pickup location by 2 PM.",
        isMe: true,
        time: "09:12",
      ),
      ChatMessage(
        text: "Great! Please upload seal photos when you arrive.",
        isMe: false,
        time: "09:11",
        senderName: widget.name,
        senderRole: widget.role,
      ),
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text.trim(),
          isMe: true,
          time: TimeOfDay.now().format(context).substring(0, 5),
        ),
      );
    });

    _messageController.clear();

    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF6F6F6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 8,
                vertical: 8,
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  // Avatar
                  CircleAvatar(
                    radius: isTablet ? 26 : 22,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                  const SizedBox(width: 12),
                  // Name and status
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.role,
                              style: TextStyle(
                                fontSize: isTablet ? 14 : 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Online",
                          style: TextStyle(
                            fontSize: isTablet ? 14 : 12,
                            color: const Color(0xff4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 32 : 16,
                vertical: 16,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(message: message, isTablet: isTablet);
              },
            ),
          ),
          // Input area
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: 12,
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Attachment button
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement attachment picker
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Attachment feature coming soon!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.grey[600],
                        size: isTablet ? 28 : 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text input
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: isTablet ? 16 : 14),
                        decoration: InputDecoration(
                          hintText: "Type here",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: isTablet ? 16 : 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 20 : 16,
                            vertical: isTablet ? 14 : 12,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(isTablet ? 14 : 10),
                      decoration: const BoxDecoration(
                        color: Color(0xffBA983F),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: isTablet ? 24 : 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String? senderName;
  final String? senderRole;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.senderName,
    this.senderRole,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isTablet;

  const ChatBubble({super.key, required this.message, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * (isTablet ? 0.5 : 0.7);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: message.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.all(isTablet ? 16 : 12),
            decoration: BoxDecoration(
              color: message.isMe ? const Color(0xffBA983F) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(message.isMe ? 16 : 4),
                bottomRight: Radius.circular(message.isMe ? 4 : 16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender name for received messages
                if (!message.isMe && message.senderName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffC49E5D),
                        ),
                        children: [
                          TextSpan(text: "${message.senderName} "),
                          TextSpan(
                            text: message.senderRole ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Message text
                Text(
                  message.text,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    color: message.isMe ? Colors.white : Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Time
          Text(
            message.time,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
