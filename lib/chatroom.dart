// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, use_super_parameters, duplicate_ignore, body_might_complete_normally_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Chatroom extends StatelessWidget {
  Chatroom({required this.chatRoomId, required this.userMap});

  final Map<String, dynamic> userMap;

  final String chatRoomId;

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": _auth.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
        FirebaseStorage.instance.ref().child("images").child("$fileName.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});
      log(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      log("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.video_call,
                  color: Colors.white,
                )),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
          title: StreamBuilder<DocumentSnapshot>(
            stream: _firestore
                .collection(
                  "users",
                )
                .doc(
                  userMap['uid'],
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                // ignore: avoid_unnecessary_containers
                return Container(
                  child: Column(
                    children: [
                      Text(
                        userMap['name'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        snapshot.data!['status'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("chatroom")
                    .doc(chatRoomId)
                    .collection("chats")
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              // ignore: sized_box_for_whitespace
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 15,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => getImage(),
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                        onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, context) {
    return map["type"] == "text"
        ? Container(
            width: size.width,
            alignment: map["sendby"] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.black),
              child: Text(
                map["message"],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map["sendby"] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowImage(
                  imageUrl: map["message"],
                ),
              )),
              child: Container(
                  height: size.height / 2.5,
                  width: size.width / 2,
                  decoration: BoxDecoration(border: Border.all()),
                  alignment: map["messages"] != "" ? null : Alignment.center,
                  child: map["message"] != ""
                      ? Image.network(
                          map["message"],
                          fit: BoxFit.cover,
                        )
                      : const CircularProgressIndicator()),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
