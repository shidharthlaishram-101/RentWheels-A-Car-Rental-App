import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentwheels/AI/Chatbot.dart';
import 'package:rentwheels/components/my_list_tile.dart';
import 'package:rentwheels/notification.dart';
import 'package:rentwheels/profile.dart';
import 'package:rentwheels/services/bookings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser!;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "WELCOME",
                      style: GoogleFonts.mulish(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //const SizedBox(height: 20),
                    Icon(
                      Icons.person,
                      size: 64,
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentuser.email!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(color: Colors.grey[800], fontSize: 10),
                    ),

                  ],
                ),
              ),
              MyListTile(
                icon: Icons.notifications,
                text: 'N O T I F I C A T I O N S',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                },
              ),
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
              ),
              MyListTile(
                icon: Icons.car_rental,
                text: 'BOOKED CARS & REVIEW',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YourBookings(),
                    ),
                  );
                },
              ),
              /*MyListTile(
                icon: Icons.chat,
                text: 'C H A T B O T',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatbotPage(),
                    ),
                  );
                },
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Confirm Logout',
                        style: GoogleFonts.mulish(fontWeight: FontWeight.bold),
                      ),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('No',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            signUserOut();
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
