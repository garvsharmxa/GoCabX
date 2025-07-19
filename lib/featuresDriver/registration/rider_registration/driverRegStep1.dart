import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/featuresDriver/registration/rider_registration/UploadDocPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverRegStep1 extends StatefulWidget {
  const DriverRegStep1({super.key});

  @override
  State<DriverRegStep1> createState() => _DriverRegStep1State();
}

class Vehicle {
  final String name;
  final IconData icon;

  const Vehicle({
    required this.name,
    required this.icon,
  });
}

class _DriverRegStep1State extends State<DriverRegStep1> {
  int selectedVehicle = 0;

  final List<Vehicle> vehicles = const [
    Vehicle(name: "Bike", icon: Icons.motorcycle),
    Vehicle(name: "Auto", icon: Icons.local_taxi_outlined),
    Vehicle(name: "Cab", icon: Icons.directions_car),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<String> filteredVehicles = [];

  final Map<String, List<String>> vehicle = {
    'A': [
      'Activa 5G (Scooter)',
      'Activa 4G Shine',
      'Activa 6G',
    ],
    'B': [
      'Bajaj 5G (Scooter)',
      'Bajaj 4G Shine',
      'Bajaj 6G',
    ],
    'Auto': [
      'Auto Rickshaw (3 Wheeler)',
      'Piaggio Ape (Auto)',
      'Eicher Polaris (Auto)',
    ],
    'Car': [
      'Maruti Suzuki Swift (Car)',
      'Honda City (Car)',
      'Hyundai i20 (Car)',
      'Toyota Innova (Car)',
      'Tata Nexon (Car)',
      'Mahindra Scorpio (Car)',
    ],
  };

  @override
  void initState() {
    super.initState();
    // Initially, set filteredVehicles to Bike data
    filteredVehicles = vehicle['A']! + vehicle['B']!;
  }

  void _filterVehicles(String query) {
    setState(() {
      filteredVehicles = vehicle.values
          .expand((list) => list)
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectVehicleType(int index) {
    setState(() {
      selectedVehicle = index;
      // Update filteredVehicles based on selected vehicle type
      switch (index) {
        case 0: // Bike
          filteredVehicles = vehicle['A']! + vehicle['B']!;
          break;
        case 1: // Auto
          filteredVehicles = vehicle['Auto']!;
          break;
        case 2: // Car
          filteredVehicles = vehicle['Car']!;
          break;
      }
    });
  }

  Widget _buildVehicleCard(Vehicle vehicle, int index) {
    final bool isSelected = selectedVehicle == index;
    return GestureDetector(
      onTap: () => _selectVehicleType(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSelected
                  ? [AppColors.secondary, AppColors.primary]
                  : [Colors.grey.shade300, Colors.grey.shade200],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                vehicle.icon,
                size: 25,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                vehicle.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Hi ",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Lorem",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1F9686),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ", Ready to Become a BuzzCab's Roadie?",
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "We're Excited to Have You on Board!",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  "assets/images/content/driver_registration.png",
                  scale: 3,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Vehicle Details",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
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
              const SizedBox(height: 10),
              Text(
                "Search Vehicle Model",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: _filterVehicles,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search any name...',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListView(
                      shrinkWrap: true, // Avoid using Expanded here
                      children: filteredVehicles.map((vehicle) {
                        return ListTile(
                          leading: Icon(
                            vehicle.contains('Scooter')
                                ? Icons.electric_scooter
                                : Icons.motorcycle,
                          ),
                          title: Text(vehicle),
                          subtitle: Text(
                            'Seats: 2 ${vehicle.contains("Scooter") ? "(Rider + 1 Passenger)" : ""}',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UploadDocPage()), // Wrap UploadDocPage() in a builder function
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

