import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/aV0wErxuOyAquSXVJwUL/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircleAvatar());
          }
          final docs = streamSnapshot.data!.docs;
          print(docs);
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) => Container(
                  padding: EdgeInsets.all(8),
                  child: Text(docs[index]['text'])));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/aV0wErxuOyAquSXVJwUL/messages')
              .add({'text': 'This was added by clicking the button!!'});            
        },
      ),
    );
  }
}
