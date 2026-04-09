import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 🔴 APPBAR WITH SETTINGS
      appBar: AppBar(
        title: const Text("SAVE"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text("Logout"),
              ),
            ],
          )
        ],
      ),

      // 📍 BODY
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ✨ QUOTE
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "“Every second matters. We help you save lives faster.”",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),

          // 🏥 HOSPITAL LIST
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('hospitals').snapshots(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No hospitals found"));
                }

                final hospitals = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: hospitals.length,
                  itemBuilder: (context, index) {
                    final data = hospitals[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.local_hospital, color: Colors.red),
                        title: Text(data['name']),
                        subtitle: Text(
                          "${data['distance']} km • ${data['type']}",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // 🚑 FLOATING BUTTON (BOTTOM RIGHT)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/emergency');
        },
        child: const Icon(Icons.local_hospital),
      ),
    );
  }
}