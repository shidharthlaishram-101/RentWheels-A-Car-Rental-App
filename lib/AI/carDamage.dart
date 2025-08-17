import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:rentwheels/add_vehicle.dart';

class CarDamage extends StatefulWidget {
  const CarDamage({super.key});

  @override
  _CarDamageState createState() => _CarDamageState();
}

class _CarDamageState extends State<CarDamage> {
  File? _image; // Variable to store the selected image

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery); // Pick image from gallery

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Car Damage Assessment',
          style: GoogleFonts.mulish(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Show Image.asset only if no image is uploaded
            if (_image == null)
              AspectRatio(
                aspectRatio: 5 / 2,
                child: Image.asset(
                  'assets/images/car_repair.png',
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(height: 50),
            // Display the uploaded image if available
            if (_image != null)
              Column(
                children: [
                  Image.file(
                    _image!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            // Upload button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text("Upload Image"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor: Colors.blue, // Button color
                textStyle:
                GoogleFonts.mulish(fontSize: 16, fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                /*if(_image != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProcessingPage(image: _image!))
                  );
                }*/
              },
              label: const Text("Process Image"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor: Colors.blue, // Button color
                textStyle:
                GoogleFonts.mulish(fontSize: 16, fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            // Placeholder text or instructions
            Text(
              "Please upload an image of the car to assess damages.",
              style: GoogleFonts.mulish(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
