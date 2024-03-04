import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/widgets/show_image.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
