import 'package:flutter/material.dart'; // Import this to use gradients

import '../logic/chat_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            Center(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.green, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: const Text(
                  'Dev Agent', // Changed text
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),

            // List Of messages

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: ChatLogic.userMessages.length,
                  itemBuilder: (context, index) {
                    final message = ChatLogic.userMessages[index];
                    return Row(
                      mainAxisAlignment: message.isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: message.isUser
                                ? const Color.fromARGB(
                                    255, 29, 78, 216) // User question color
                                : const Color.fromARGB(
                                    255, 31, 41, 55), // Bot answer color
                          ),
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isUser
                                  ? Colors.white
                                  : Colors.white, // Text color
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Type your message

            Container(
              height: 80,
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Type your message...',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(
                                255, 29, 78, 216), // Border color
                            width: 1, // Border width
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelStyle: const TextStyle(
                          color:
                              Color.fromARGB(255, 29, 78, 216), // Label color
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                  onPressed: () async{
                    final newMessage = messageController.text;
                    await ChatLogic.sendMessage(newMessage);
                    setState(() {});
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      backgroundColor:
          const Color.fromARGB(255, 197, 226, 251), // Background color
    );
  }
}
