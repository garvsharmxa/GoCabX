import 'package:buzzcab/featuresDriver/home/widgets/nextScreenButton.dart';
import 'package:buzzcab/featuresRider/screen/CabBookingFlow/Screens/RideOngoingScreen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDetails extends StatefulWidget {
  final LatLng LocationA;
  final LatLng LocationB;
  const RideDetails({
    super.key,
    required this.LocationA,
    required this.LocationB,
  });

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class Vehicle {
  final String name;
  final String seats;
  final String price;
  final IconData icon;
  final String time;
  final String duration;

  const Vehicle({
    required this.name,
    required this.seats,
    required this.price,
    required this.icon,
    required this.time,
    required this.duration,
  });
}

class _RideDetailsState extends State<RideDetails> {
  int selectedVehicle = 0;
  String locationAName = "Fetching...";
  String locationBName = "Fetching...";

  @override
  void initState() {
    super.initState();
    _fetchLocationNames();
  }

  void _fetchLocationNames() async {
    String nameA = await _getLocationName(widget.LocationA);
    String nameB = await _getLocationName(widget.LocationB);
    setState(() {
      locationAName = nameA;
      locationBName = nameB;
    });
  }

  Future<String> _getLocationName(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.name}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Error getting location: $e");
    }
    return "Unknown Location";
  }

  final List<Vehicle> vehicles = const [
    Vehicle(
      name: "Bike",
      seats: "(Rider + 1 Passenger)",
      price: "\u20B980",
      icon: Icons.motorcycle,
      time: "15-20 mins",
      duration: "25 Mins",
    ),
    Vehicle(
      name: "Auto Rickshaw",
      seats: "Availability Upto 3 Seats",
      price: "\u20B950",
      icon: Icons.directions_bus_filled,
      time: "15-20 mins",
      duration: "25 Mins",
    ),
    Vehicle(
      name: "Car: Standard",
      seats: "Seats: Upto 4 Seats ",
      price: "\u20B9150",
      icon: Icons.directions_car,
      time: "15-20 mins",
      duration: "25 Mins",
    ),
  ];

  // Color constants
  final Color selectedColor = const Color(0xff211F96);
  final Color unselectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    final Color backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
            size: 25,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Your Ride Details",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.5),
              child: Container(
                height:
                    size.height * 0.19, // Dynamic height (adjustable as needed)
                width: size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xff262626)
                      : const Color(0xffEBEBF6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    _buildIconRow(
                        "${locationAName}", size, backgroundColor, textColor),
                    const Spacer(),
                    _buildIconRow2(
                        "${locationBName}", size, backgroundColor, textColor),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
              child: Text(
                "Choose Preferred Vehicle:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(vehicles.length, (index) {
                  final vehicle = vehicles[index];
                  return _buildVehicleCard(vehicle, index);
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 15, left: 15),
        child: Nextscreenbutton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RideOngoingScreen(LocationA: widget.LocationA, LocationB: widget.LocationB,)));
            },
            buttonText: "Confirm Ride"),
      ),
    );
  }

  Widget _buildIconRow(
      String location, Size size, Color backgroundColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          _buildIconBox(
              50, const Color(0xff1F9686), Icons.location_on_outlined),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          location, // Updated to show fetched location name
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          _buildIconBox2(50, textColor, Icons.search),
        ],
      ),
    );
  }

  Widget _buildIconRow2(
      String location, Size size, Color backgroundColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          _buildIconBox(
              50, const Color(0xff1F9686), Icons.location_on_outlined),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          location, // Updated to show fetched location name
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          _buildIconBox2(50, textColor, Icons.search),
        ],
      ),
    );
  }

  Widget _buildIconBox(double size, Color color, IconData icon) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildIconBox2(double size, Color color, IconData icon) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildVehicleCard(Vehicle vehicle, int index) {
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicle = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25, // Dynamic height
          width: MediaQuery.of(context).size.width *
              0.5, // Adjust width dynamically
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: selectedVehicle == index
                  ? [Colors.black, const Color(0xff1B8678)]
                  : [const Color(0xffE9F4F3), const Color(0xffE9F4F3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Icon(
                vehicle.icon,
                size: 50,
                color: selectedVehicle == index ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 10),
              Text(
                vehicle.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: selectedVehicle == index ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                vehicle.seats,
                style: TextStyle(
                  fontSize: 12,
                  color: selectedVehicle == index
                      ? Colors.white70
                      : Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 60,
                height: 35,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: selectedVehicle == index
                      ? Colors.white
                      : const Color(0xff1F9686),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    vehicle.price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedVehicle == index
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  _buildInfoRow(
                      Icons.location_on_outlined, vehicle.time, index),
                  const Spacer(),
                  _buildInfoRow(Icons.access_time, vehicle.duration, index),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: selectedVehicle == index ? Colors.white : Colors.black,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: selectedVehicle == index ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
