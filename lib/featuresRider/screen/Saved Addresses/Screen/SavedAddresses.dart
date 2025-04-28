import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../../Service/Controllers/saved_addresses_controller.dart';

class SavedAddresses extends StatelessWidget {
  final SavedAddressesController controller =
  Get.put(SavedAddressesController());

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
          Obx(() => GoogleMap(
            onMapCreated: (controller) =>
                this.controller.mapController.complete(controller),
            initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value, zoom: 15),
            markers: controller.selectedMarker.value != null
                ? {controller.selectedMarker.value!}
                : {},
            myLocationEnabled: true,
            onTap: (LatLng position) {
              controller.currentLocation.value = position;
              controller.setMarker(position);
              controller.getAddressFromLatLng(position);
              controller.saveLocation(position);
            },
          )),
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Column(
              children: [
                TextField(
                  controller: controller.searchController,
                  onChanged: controller.fetchSuggestions,
                  decoration: InputDecoration(
                    hintText: "Search location...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                  ),
                ),
                Obx(() => controller.suggestions.isNotEmpty
                    ? Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            controller.suggestions[index]["description"]),
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
            child: Obx(() => ElevatedButton.icon(
              onPressed: controller.useCurrentLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                      ),
                      child: const Text("CONFIRM LOCATION",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Save Address",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title (e.g., Home, Work)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: controller.selectedAddress.value),
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String title = titleController.text.trim();
                      String phone = phoneController.text.trim();
                      if (title.isEmpty || phone.isEmpty) {
                        Get.snackbar("Error", "All fields are required!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.8),
                            colorText: Colors.white);
                        return;
                      }
                      controller.saveLocationWithDetails(title, controller.selectedAddress.value, phone);
                      Navigator.pop(context);
                      Get.snackbar("Success", "Location saved successfully!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green.withOpacity(0.8),
                          colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text("Save Place",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
