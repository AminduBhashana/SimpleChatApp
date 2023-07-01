
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Services/sqlHelper.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/models/userModel.dart';
import 'package:intl/intl.dart';

class MyChatScreen extends StatefulWidget {
    const MyChatScreen({super.key});
  

  @override
  State<MyChatScreen> createState() => _MyChatScreenState();
}

class _MyChatScreenState extends State<MyChatScreen> {

  static  String _user = "";
  List<String> messages = [];
  final String receiver_name = Get.arguments  ;
  DateTime date = DateTime.now().subtract(const Duration(minutes: 3,days: 3));
  List<Map<String,dynamic>> messageList= [];
  List<Map<String,dynamic>> userList = [] ;
       
  TextEditingController messageController = TextEditingController();

  void sendMessage() {
    String message = messageController.text.trim();  
    if (message.isNotEmpty) {
      setState(() {
      _addMessage();
      messages.add(message);
      _showMessages();
      });
      messageController.clear();
    }
  }
  Future<void> _addMessage() async{
        await SQLHelper.addMessages(
        _user,receiver_name,messageController.text);
  }
  
  void _showMessages() async {
    final data = await SQLHelper.getMessages(_user,receiver_name);
    setState(() {
      messageList = data;
    });  
  }

  void reFreshment() async {
  String? userEmail = DataStorage.currentUser?.userEmail;
  String? username = await SQLHelper().getSingleUsername(userEmail ?? 'No user found');
  setState(() {
      _user = username!;  
     });// Print the retrieved username
}

@override
  void initState() {
    super.initState();
    reFreshment();
    setState(() {
      reFreshment();
      _showMessages();
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title:  Text("$receiver_name",style: const TextStyle(color: kPrimaryColor,fontSize: 25,fontWeight: FontWeight.bold)),),     
      body: Column(
        children: [
          Expanded(
            
      child: ListView.builder(
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              final message = messageList[index]['message'].toString();
              final sender = messageList[index]['sender'].toString();
              final createdAt =
                  DateTime.parse(messageList[index]['createdAt'].toString());
              final formattedDate =
                  DateFormat('MMM d, HH:mm').format(createdAt);

              final isSentMessage = sender == _user;

        return Align(
                alignment: isSentMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: isSentMessage
                      ? kPrimaryLightColor
                      : const Color.fromARGB(255, 200, 200, 200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        16.0), // Adjust the radius as needed
                    side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5), // Add a border if you like
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 100), // Adjust the minimum width as needed
                      child: Column(
                        crossAxisAlignment: isSentMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(message,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              maxLines: null),
                          const SizedBox(
                              height:
                                  7), // Adjust spacing between message and time if needed
                          Text(formattedDate,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 69, 69, 69))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                 child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    filled: true,
                    fillColor: kPrimaryLightColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintStyle: const TextStyle(color: Colors.white70),
                  ),
                )                 
                ),            
                const SizedBox(width: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  onPressed: sendMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }
