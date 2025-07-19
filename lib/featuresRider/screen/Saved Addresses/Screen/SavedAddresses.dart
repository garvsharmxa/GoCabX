import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../../Service/Controllers/saved_addresses_controller.dart';

class SavedAddresses extends StatefulWidget {
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  final SavedAddressesController controller = Get.put(SavedAddressesController());
  GoogleMapController? _mapController;

  @override
  void dispose() {
    // Properly dispose of the map controller
    _mapController?.dispose();
    // Remove the controller when disposing
    Get.delete<SavedAddressesController>();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController mapController) {
    if (!controller.mapController.isCompleted) {
      controller.mapController.complete(mapController);
      _mapController = mapController;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text("Select delivery location",
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.black)),
      ),
      body: Stack(
        children: [
          // Use a Container with a key to ensure proper widget lifecycle
          Container(
            key: const ValueKey('google_map_container'),
            child: Obx(() => GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: controller.currentLocation.value, zoom: 15),
              markers: controller.selectedMarker.value != null
                  ? {controller.selectedMarker.value!}
                  : {},
              myLocationEnabled: true,
              myLocationButtonEnabled: false, // Disable default button to avoid conflicts
              compassEnabled: true,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              onTap: (LatLng position) {
                controller.currentLocation.value = position;
                controller.setMarker(position);
                controller.getAddressFromLatLng(position);
                controller.saveLocation(position);
              },
            )),
          ),
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: controller.fetchSuggestions,
                    decoration: InputDecoration(
                      hintText: "Search location...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                Obx(() => controller.suggestions.isNotEmpty
                    ? Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.location_on, color: AppColors.primary),
                        title: Text(
                          controller.suggestions[index]["description"],
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () => controller.selectLocation(
                            controller.suggestions[index]["place_id"]),
                      );
                    },
                  ),
                )
                    : const SizedBox()),
              ],
            ),
          ),
          Positioned(
            bottom: 170,
            left: 20,
            right: 20,
            child: Obx(() => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: controller.isLoading.value ? null : controller.useCurrentLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                icon: controller.isLoading.value
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.primary),
                )
                    : const Icon(Icons.my_location),
                label: Text(
                  controller.isLoading.value
                      ? "Fetching location..."
                      : "Use Current Location",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            )),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_pin, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() => Text(
                          controller.selectedAddress.value,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showSaveLocationBottomSheet(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("CONFIRM LOCATION",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveLocationBottomSheet(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "Save Address",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title (e.g., Home, Work)",
                    prefixIcon: Icon(Icons.label_outline, color: AppColors.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone_outlined, color: AppColors.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Obx(() => TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: controller.selectedAddress.value),
                  decoration: InputDecoration(
                    labelText: "Address",
                    prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                  maxLines: 2,
                )),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String title = titleController.text.trim();
                      String phone = phoneController.text.trim();
                      if (title.isEmpty || phone.isEmpty) {
                        Get.snackbar("Error", "All fields are required!",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.withOpacity(0.8),
                            colorText: Colors.white);
                        return;
                      }
                      controller.saveLocationWithDetails(title, controller.selectedAddress.value, phone);
                      Navigator.pop(context);
                      Get.snackbar("Success", "Location saved successfully!",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green.withOpacity(0.8),
                          colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Save Place",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}