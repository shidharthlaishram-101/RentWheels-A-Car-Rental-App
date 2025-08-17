import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentwheels/AI/carDamage.dart';
import 'package:rentwheels/admin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentwheels/admin_profile.dart';
import 'package:rentwheels/services/adminNotif.dart';
import 'my_list_tile.dart';

class adminDrawer extends StatelessWidget {
  const adminDrawer({super.key});

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
                      builder: (context) => AdminNotif(),
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
                      builder: (context) => AdminProfile(),
                    ),
                  );
                },
              ),
              MyListTile(
                icon: Icons.car_crash_outlined,
                text: 'CAR DAMAGE ASSESSMENT',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarDamage()),
                  );
                },
              ),
              /*MyListTile(
                icon: Icons.chat,
                text: 'C H A T B O T',
                onTap: () {
                  // Placeholder for chatbot functionality
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
