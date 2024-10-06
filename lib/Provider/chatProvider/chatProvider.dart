import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Model/Res/Constants/firebase.dart';
import '../../Model/data/chatModel/chatRoomModel.dart';
import '../../Model/data/chatModel/messageModel.dart';
import '../../Model/data/chatModel/userChatModel.dart';



class ChatProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String? currentUserId = "admin@tabibinet.com";

  List<MessageModel> _messages = [];
  List<UserchatModel> _users = [];
  List<ChatRoomModel> _chatRooms = [];
  Map<String, int> _unreadMessageCounts = {};

  bool? _isUserBlock;

  List<MessageModel> get messages => _messages;
  List<UserchatModel> get users => _users;
  List<ChatRoomModel> get chatRooms => _chatRooms;
  Map<String, int> get unreadMessageCounts => _unreadMessageCounts;

  bool get isUserBlock => _isUserBlock!;

  ChatProvider() {
    _loadUsers();
    _loadMessages();
    loadChatRooms();
  }

  void userBlock(bool isUserBlock) {
    _isUserBlock = isUserBlock;
    notifyListeners();
  }

  UploadTask uploadAudio(var audioFile, String fileName) {
    Reference reference = _storage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(audioFile);
    return uploadTask;
  }

  Future<void> loadChatRooms() async {
    log("Chat Room Load");
    final currentUserEmail = currentUserId;
    QuerySnapshot snapshot = await _firestore
        .collection('chatRooms')
        .where('users', arrayContains: currentUserEmail)
        .get();

    final chatRooms = snapshot.docs.map((doc) {
      return ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    // Retrieve unread message counts
    await Future.wait(chatRooms.map((chatRoom) async {
      chatRoom.unreadMessageCount = await _getUnreadMessageCount(chatRoom.id);
      _unreadMessageCounts[chatRoom.id] = chatRoom.unreadMessageCount;
    }));

    _chatRooms = chatRooms;
    notifyListeners();
  }

  Stream<List<ChatRoomModel>> getChatRoomsStream() {
    final currentUserEmail = currentUserId;
    return _firestore
        .collection('chatRooms')
        .where('users', arrayContains: currentUserEmail)
        .snapshots()
        .asyncMap((snapshot) async {
      final chatRooms = snapshot.docs.map((doc) {
        final chatRoom = ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        chatRoom.unreadMessageCount = _unreadMessageCounts[chatRoom.id] ?? 0;
        return chatRoom;
      }).toList();
      // Sort chat rooms by the timestamp of the latest message in descending order
      chatRooms.sort((a, b) => b.lastTimestamp.compareTo(a.lastTimestamp));
      return chatRooms;
    });
  }


  Future<int> _getUnreadMessageCount(String chatRoomId) async {
    final currentUserEmail = currentUserId;
    final messagesSnapshot = await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('read', isEqualTo: false)
        .where('sender', isNotEqualTo: currentUserEmail)
        .get();

    return messagesSnapshot.docs.length;
  }

  Future<int> getUnreadMessageCount(String chatRoomId) async {
    log("Chat ID ${chatRoomId}");
    final currentUserEmail = currentUserId;
    final messagesSnapshot = await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('read', isEqualTo: false)
        .where('sender', isNotEqualTo: currentUserEmail)
        .get();

    return messagesSnapshot.docs.length;
  }

  Future<void> _loadUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    _users = snapshot.docs
        .map((doc) => UserchatModel(
      id: doc.id,
      name: doc['name'] ?? "",
      email: doc['email'] ?? "",
      profileUrl: doc['profileUrl'] ?? "",
      userUid: doc['userUid'] ?? "",
    ))
        .toList();
    notifyListeners();
  }

  Future<void> _loadMessages() async {
    QuerySnapshot snapshot = await _firestore.collection('messages')
        .orderBy('timestamp').get();
    _messages = snapshot.docs.map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    notifyListeners();
  }


  // // Send location message
  // Future<void> sendLocationMessage({
  //   required String chatRoomId,
  //   required String otherEmail,
  // }) async {
  //   final currentUserEmail = getCurrentUid().toString();
  //   PermissionStatus status = await Permission.locationWhenInUse.request();
  //
  //   if (status.isGranted) {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //
  //     final locationMessage = {
  //       'text': 'Location: (${position.latitude}, ${position.longitude})',
  //       'latitude': position.latitude,
  //       'longitude': position.longitude,
  //       'sender': currentUserEmail,
  //       'timestamp': FieldValue.serverTimestamp(),
  //       'read': false,
  //       'delivered': false,
  //       'type': 'location',
  //     };
  //
  //     await _firestore
  //         .collection('chatRooms')
  //         .doc(chatRoomId)
  //         .collection('messages')
  //         .add(locationMessage);
  //     await _firestore.collection('chatRooms').doc(chatRoomId).update({
  //       'lastMessage': 'Location message',
  //       'isMessage': otherEmail,
  //       'lastTimestamp': FieldValue.serverTimestamp(),
  //     });
  //
  //     showToast("Location sent successfully!");
  //   } else {
  //     showToast("Location permission denied.");
  //   }
  // }


  Future<void> sendMessage({required String chatRoomId,required String message,
    required String otherEmail,required String type}) async {
    final currentUserEmail = currentUserId;
    log("currentUseremaill is  ::: $currentUserId");


    try {
      final newMessage = {
        'text': message,
        'sender': currentUserEmail,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'delivered': false,
        'type': type, // Include type in the message data
      };
      await _firestore.collection('chatRooms').doc(chatRoomId).collection('messages').add(newMessage);
      await _firestore.collection('chatRooms').doc(chatRoomId).update({
        'lastMessage': message,
        'isMessage': otherEmail,
        'lastTimestamp': FieldValue.serverTimestamp(),
      });
    }catch (e) {
      log("Error sending message: $e");

    }
  }


  Future<void> sendFileMessage({required String chatRoomId, required String filePath, required String type, required String otherEmail}) async {
    final currentUserEmail = currentUserId;
    final file = File(filePath);
    final fileName = file.uri.pathSegments.last;

    // Upload file to Firebase Storage
    final ref = _storage.ref().child('chatFiles/$chatRoomId/$fileName');
    await ref.putFile(file);

    final fileUrl = await ref.getDownloadURL();

    final newMessage = {
      'text': fileName,
      'sender': currentUserEmail,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
      'delivered': false,
      'type': type,
      'url': fileUrl,
    };
    await _firestore.collection('chatRooms').doc(chatRoomId).collection('messages').add(newMessage);
    await _firestore.collection('chatRooms').doc(chatRoomId).update({
      'lastMessage': fileName,
      'isMessage': otherEmail,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }




  Future<void> sendVoiceMessage({
    required String chatRoomId,
    required String text,
    required String otherEmail,
  }) async {
    log("Enter Voice Server Message");
    final currentUserEmail = currentUserId;


    final newMessage = {
      'text': text, // Store file URL in 'text'
      'sender': currentUserEmail,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
      'delivered': false,
      'type': 'voice', // Indicate message type
    };

    await _firestore.collection('chatRooms').doc(chatRoomId).collection('messages').add(newMessage);
    await _firestore.collection('chatRooms').doc(chatRoomId).update({
      'lastMessage': 'Voice message',
      'isMessage': otherEmail,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendOfferMessage({
    required String price,
    required String tax,
    required String fees,
    required String total,
    required String details,
    required String chatRoomId,
    required String otherEmail,
  }) async {
    log("Enter Voice Server Message");
    final currentUserEmail = currentUserId;


    final newMessage = {
      'text': price,
      'tax': tax,
      'fees': fees,
      'total': total,
      'details': details,
      'offerStatus': "pending",
      'sender': currentUserEmail,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
      'delivered': false,
      'type': 'offer', // Indicate message type
    };

    await _firestore.collection('chatRooms').doc(chatRoomId).collection('messages').add(newMessage);
    await _firestore.collection('chatRooms').doc(chatRoomId).update({
      'lastMessage': 'Offer message',
      'isMessage': otherEmail,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }


  Future<void> blockUser({
    required String chatRoomId,
    required String otherEmail,
  }) async {

    await _firestore.collection('chatRooms').doc(chatRoomId).update({
      'lastMessage': 'user blocked',
      'isMessage': otherEmail,
      'lastTimestamp': FieldValue.serverTimestamp(),
      'userStatus': "block",
    });
    userBlock(false);
  }

  Future<void> updateOfferMessage({
    required String status,
    required String messageID,
    required String chatRoomId,
    required String otherEmail,
  }) async {
    log("Enter Offer Server Message");
    final newMessage = {
      'offerStatus': status, // Store file URL in 'text'
    };

    await _firestore.collection('chatRooms').doc(chatRoomId).collection('messages')
        .doc(messageID).update(newMessage);
    await _firestore.collection('chatRooms').doc(chatRoomId).update({
      'lastMessage': 'Offer has been $status',
      'isMessage': otherEmail,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }

  // Future<void> downloadFile(String url, String fileName,
  //     {String? fallbackUrl}) async {
  //   PermissionStatus status = await Permission.storage.request();
  //
  //   if (status.isGranted) {
  //     try {
  //       log("Downloading File: $url");
  //
  //       // Get the application documents directory
  //       final dir = await getApplicationDocumentsDirectory();
  //       final file = File('${dir.path}/$fileName');
  //
  //       // Make an HTTP GET request to download the file
  //       final response = await http.get(Uri.parse(url));
  //
  //       if (response.statusCode == 200) {
  //         // Write the file to the local filesystem
  //         await file.writeAsBytes(response.bodyBytes);
  //         log("File downloaded: ${file.path}");
  //         showToast("File downloaded: ${file.path}");
  //       } else {
  //         log("Failed to download file: ${response.statusCode}");
  //         showToast("Failed to download file: ${response.statusCode}");
  //         if (fallbackUrl != null) {
  //           openWebPage(fallbackUrl);
  //         }
  //       }
  //     } catch (e) {
  //       log("Error downloading file: $e");
  //       showToast("Error downloading file: $e");
  //       if (fallbackUrl != null) {
  //         openWebPage(fallbackUrl);
  //       }
  //     }
  //   } else if (status.isDenied) {
  //     log("Storage permission denied.");
  //     showToast("Storage permission denied. Please grant storage permission to download the file.");
  //     if (fallbackUrl != null) {
  //       openWebPage(fallbackUrl);
  //     }
  //   } else if (status.isPermanentlyDenied) {
  //     log("Storage permission is permanently denied, opening app settings.");
  //     showToast("Storage permission is permanently denied. Please enable it in settings.");
  //     bool opened = await openAppSettings();
  //     log("Opened app settings: $opened");
  //   } else if (status.isRestricted) {
  //     log("Storage permission is restricted, cannot request permission.");
  //     showToast("Storage permission is restricted, cannot request permission.");
  //     if (fallbackUrl != null) {
  //       openWebPage(fallbackUrl);
  //     }
  //   }
  // }

  Future<void> deleteMessage(String chatRoomId,
      String messageId) async {
    try {
      await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .delete();
      notifyListeners();
    } catch (e) {
      log("Error deleting message: $e");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Future<void> openWebPage(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     throw 'Could not launch $url';
  //   }
  // }
  //
  // Future<void> launchWebUrl({required String url}) async {
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> updateDeliveryStatus(String chatRoomId) async {
    final currentUserEmail = currentUserId;
    final messageDocs = await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('sender', isNotEqualTo: currentUserEmail)
        .get();

    for (var doc in messageDocs.docs) {
      if (!(doc['delivered'] as bool)) {
        await doc.reference.update({'delivered': true});
      }
    }
  }

  Future<void> updateMessageStatus(String chatRoomID) async{
    log("message ${chatRoomID} : run");
    await _firestore.collection("chatRooms").doc(chatRoomID).update({"isMessage" : "seen"});
  }

  Future<void> markMessageAsRead(String chatRoomId) async {
    final currentUserEmail = currentUserId;
    final messageDocs = await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('sender', isNotEqualTo: currentUserEmail)
        .get();

    for (var doc in messageDocs.docs) {
      if (!(doc['read'] as bool)) {
        await doc.reference.update({'read': true});
      }
    }
    await loadChatRooms(); // Refresh chat rooms to update unread counts
  }

  Future<String> createChatRoom(String otherUserEmail,String lastMessage) async {
    final chatRoom = await _firestore.collection('chatRooms').add({
      'users': [currentUserId, otherUserEmail],
      'lastMessage': lastMessage,
      'lastTimestamp': FieldValue.serverTimestamp(),
      'isMessage': currentUserId,
      'userStatus': "active",
    });
    return chatRoom.id;
  }

  String getChatRoomId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode
        ? '$user1-$user2'
        : '$user2-$user1';
  }

  Stream<QuerySnapshot> getChatRooms() {
    return _firestore
        .collection('chatRooms')
        .where('users', arrayContains: currentUserId)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<String> createOrGetChatRoom(String otherUserEmail,String lastMessage) async {
    final currentUserEmail = currentUserId;
    final chatRoomId = getChatRoomId(currentUserEmail!, otherUserEmail);

    final chatRoomDoc = _firestore.collection('chatRooms').doc(chatRoomId);
    final chatRoomSnapshot = await chatRoomDoc.get();

    if (!chatRoomSnapshot.exists) {
      await chatRoomDoc.set({
        'users': [currentUserEmail, otherUserEmail],
        'lastMessage': lastMessage,
        'isMessage': currentUserId,
        'lastTimestamp': FieldValue.serverTimestamp(),
        'userStatus': "active",
      });
    }
    return chatRoomId;
  }

  Future<String> getUserStatus(String chatRoomID) async {
    String? userStatus = "";
    final chatRoomDoc = _firestore.collection('chatRooms').doc(chatRoomID);
    final chatRoomSnapshot = await chatRoomDoc.get();

    if(chatRoomSnapshot.exists){
      userStatus = chatRoomSnapshot.data()?['userStatus'] ?? "active";
      if(userStatus == "active"){
        userBlock(true);
      }else{
        userBlock(false);
      }
    }else{
      userBlock(false);
      userStatus = "active";
    }
    return userStatus!;
  }




  int _collectionLength = 0;
  int get collectionLength => _collectionLength;

  Future<void> getCollectionLength(String chatRoomId) async {
    log('Enter');
    final currentUserEmail = currentUserId;
    final collectionRef =
    FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId)
        .collection("messages")
        .where("read" , isEqualTo: false)
        .where('sender', isNotEqualTo: currentUserEmail);
    QuerySnapshot snapshot = await collectionRef.get();
    _collectionLength = snapshot.size;
    notifyListeners();
  }









  String _chatRoomId = "";
  String _otherUserEmail = "";

  String get chatRoomId => _chatRoomId;
  String get otherUserEmail => _otherUserEmail;


  void setResponse({required String chatRoomId,required String otherUserEmail}){
    _chatRoomId = chatRoomId;
    _otherUserEmail = otherUserEmail;
    notifyListeners();
  }











  ///////////////////chat new//////////


  ChatRoomModel? _selectedChatRoom;
  String? _selectedUserEmail;



  // Getter for selected chat room
  ChatRoomModel? get selectedChatRoom => _selectedChatRoom;
  String? get selectedUserEmail => _selectedUserEmail;

  // Setter for selected chat room
  void setSelectedChatRoom(ChatRoomModel chatRoom, String userEmail) {
    _selectedChatRoom = chatRoom;
    _selectedUserEmail = userEmail;
    notifyListeners(); // Notify consumers about the change
  }

  // Stream for getting messages of the selected chat room
  Stream<List<MessageModel>> getFMessages(String chatRoomId) {
    // Fetch messages from your backend (e.g., Firebase) based on chatRoomId
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp',descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(),doc.id))
        .toList());
  }
  UserchatModel getUserDetailsByEmail(String email) {
    return users.firstWhere((user) => user.email == email, orElse: () => UserchatModel(
      id: '',
      name: 'Unknown',
      email: email,
      profileUrl: '',
      userUid: '',
      isOnline: false,
    ));
  }

}