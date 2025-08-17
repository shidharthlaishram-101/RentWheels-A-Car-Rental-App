import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentwheels/AI/Chatbot.dart';
import 'package:rentwheels/HatchbackPage.dart';
import 'package:rentwheels/SUVPage.dart';
import 'package:rentwheels/SedanPage.dart';
import 'package:rentwheels/carInfopage.dart';
import 'package:rentwheels/components/drawer.dart';
import 'package:rentwheels/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentwheels/car_type.dart';
import 'package:rentwheels/newly_added_car.dart';
import 'package:rentwheels/date_time.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Showroom extends StatefulWidget {
  const Showroom({super.key});

  @override
  State<Showroom> createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> {
  final currentuser = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }


  List<Car> cars = getCarList();
  List<Dealer> dealers = getDealerList();
  List<carType> carTypes = getCarTypeList();

  Future<String> getDownloadURL(String gsUri) async {
    String path = gsUri.replaceFirst('gs://rentwheels-32bd9.firebasestorage.app/', '');
    return await FirebaseStorage.instance.ref(path).getDownloadURL();
  }

  Future<List<Map<String, dynamic>>> fetchTopCars() async {
    // Fetch the first 4 cars from the 'Cars' collection
    final snapshot = await FirebaseFirestore.instance
        .collection('Cars')
        .limit(4) // Limit to 4 cars
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }

  Future<void> _refresh() async {
    setState(() {

    });
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        endDrawer: MyDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "RentWheels",
            style: GoogleFonts.mulish(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Center(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DateTimeSelectionPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Search by Date & Time",
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.blue,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TOP CARS",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 280,
                              child: FutureBuilder<List<Map<String, dynamic>>>(
                                future: fetchTopCars(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return const Center(child: Text("Error fetching cars"));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Center(child: Text("No cars available"));
                                  }

                                  final cars = snapshot.data!;

                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cars.length,
                                    itemBuilder: (context, index) {
                                      final car = cars[index];


                                      final carId = car['id'];

                                      return GestureDetector(
                                        onTap: () {
                                          if (carId != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CarInfoPage(CarId: carId),
                                              ),
                                            );
                                          } else {
                                            print("Car ID is null for car at index $index");
                                          }
                                        },
                                        child: buildCar(car, index),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const NewlyAddedCars()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.all(24),
                                  height: 110,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Newly Added",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Cars",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        height: 50,
                                        width: 50,
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CHOOSE BY CAR TYPE",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 150,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                children: buildCarTypeList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to Add Vehicle page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatbotPage()),
                  );
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: const Icon(Icons.mark_unread_chat_alt, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCar(Map<String, dynamic> car, int index) {
    final String imageUrl = (car['imageURLs'] != null &&
        car['imageURLs'] is List &&
        car['imageURLs'].isNotEmpty &&
        car['imageURLs'][0] != null)
        ? car['imageURLs'][0]
        : 'https://via.placeholder.com/150';

    final carId = car['id'];

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl), // Use the validated imageUrl
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['model'] ?? 'Unknown Car',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  car['price'] != null
                      ? "₹${car['price']}/day"
                      : "Price not available",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    if (carId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarInfoPage(CarId: carId),
                        ),
                      );
                    } else {
                      print("Car ID is null!");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





  List<Widget> buildCarTypeList() {
    List<Widget> list = [];
    for (var i = 0; i < carTypes.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => getCarTypePage(carTypes[i].car_type),
              ),
            );
          },
          child: buildCarType(carTypes[i], i),
        ),
      );
    }
    return list;
  }

  Widget getCarTypePage(String carType) {
    switch (carType) {
      case 'SUV':
        return SUVPage();
      case 'Sedan':
        return SedanPage();
      case 'Hatchback':
        return HatchbackPage();
      default:
        throw Exception('Invalid car type: $carType');
    }

  }
}
