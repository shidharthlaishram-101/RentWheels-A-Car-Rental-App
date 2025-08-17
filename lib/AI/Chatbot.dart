import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _messageController = TextEditingController();

  void sendMessage(String message) {
    if (message.isEmpty) return;

    setState(() {
      // User's message
      messages.add({'sender': 'user', 'text': message});

      // Chatbot's response
      messages.add({'sender': 'bot', 'text': getBotResponse(message)});
    });

    _messageController.clear();
  }

  String getBotResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();

    if (userMessage.contains('rent')) {
      return 'I can help you rent a car. Please let me know the dates.';
    } else if (userMessage.contains('available cars')) {
      return 'We have a wide selection of cars, including sedans, and SUVs. Would you like me to show the list?';
    } else if (userMessage.contains('price')) {
      return 'Our prices start from \$20/day for economy cars. Let me know your budget and preferences!';
    } else if (userMessage.contains('support')) {
      return 'You can reach our support team at support@rentwheels.com or call us at 123-456-7890.';
    } else {
      return 'I didn\'t quite understand that. Can you please rephrase or ask about renting, pricing, or support?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            'Chat with RentWheels Assistant',
            style: GoogleFonts.mulish(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.black : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message['text']!,
                      style: GoogleFonts.mulish(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send_sharp),
                  color: Colors.black,
                  onPressed: () => sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
