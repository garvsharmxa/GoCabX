import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RiderSetting extends StatefulWidget {
  const RiderSetting({super.key});

  @override
  _RiderSettingState createState() => _RiderSettingState();
}

class _RiderSettingState extends State<RiderSetting> {
  String selectedVehicle = "Bike";
  final List<String> vehicles = ["Bike", "Auto", "Car"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : Colors.white;
    final Color iconBgColor = isDark ? Color(0xff262626) : Color(0xff212121);
    const Color iconColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text("Settings",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: textColor)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/content/profile.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe", // Replace with the actual name
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: textColor),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                          onTap: () {
                            // Add edit functionality here
                          },
                          child: Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Color(0xff1F9686),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: const Divider(),
              ),
              _buildSettingTile(Icons.lock, "Change Password", textColor,
                  iconColor, iconBgColor,
                  onTap: () {}),
              _buildSwitchTile(Icons.notifications, "Push Notifications", true,
                  (value) {}, textColor, iconColor, iconBgColor),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: const Divider(),
              ),
              _buildVehicleDropdown(textColor, iconColor, iconBgColor),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: const Divider(),
              ),
              _buildSettingTile(Icons.history, "Ride History", textColor,
                  iconColor, iconBgColor,
                  onTap: () {}),
              _buildSettingTile(Icons.account_balance_wallet,
                  "Payments & Earnings", textColor, iconColor, iconBgColor,
                  onTap: () {}),
              _buildSwitchTile(Icons.directions_car, "Switch to Rider Mode",
                  false, (value) {}, textColor, iconColor, iconBgColor),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: const Divider(),
              ),
              _buildSettingTile(
                  Icons.help_outline, "FAQs", textColor, iconColor, iconBgColor,
                  onTap: () {}),
              _buildSettingTile(Icons.support_agent, "Help & Support",
                  textColor, iconColor, iconBgColor,
                  onTap: () {}),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: const Divider(),
              ),
              _buildSettingTile(
                  Icons.logout, "Logout", Colors.red, Colors.red, iconBgColor,
                  onTap: () {}),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Card(
                  color: const Color(0xffEBEBFF),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff211F96),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.chat_bubble, color: Colors.white),
                    ),
                    title: const Text(
                      "We're available 24/7 to assist you.",
                      style: TextStyle(
                        color: Color(0xff211F96),
                      ),
                    ),
                    subtitle: const Text(
                      "Feel free to reach out anytime!",
                      style: TextStyle(
                        color: Color(0xff211F96),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, Color textColor,
      Color iconColor, Color iconBgColor,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: _buildIconContainer(icon, iconColor, iconBgColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    bool value,
    Function(bool) onChanged,
    Color textColor,
    Color iconColor,
    Color iconBgColor,
  ) {
    return ListTile(
      leading: _buildIconContainer(icon, iconColor, iconBgColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.green, // Customize color as needed
        trackColor: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildVehicleDropdown(
      Color textColor, Color iconColor, Color iconBgColor) {
    return ListTile(
      leading:
          _buildIconContainer(Icons.directions_car, iconColor, iconBgColor),
      title: Text("Vehicle Type", style: TextStyle(color: textColor)),
      trailing: DropdownButton<String>(
        value: selectedVehicle,
        items: vehicles.map((String vehicle) {
          return DropdownMenuItem<String>(
            value: vehicle,
            child: Text(vehicle, style: TextStyle(color: textColor)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedVehicle = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildIconContainer(
      IconData icon, Color iconColor, Color iconBgColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}
