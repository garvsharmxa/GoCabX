import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/widgets/colors/color.dart';
import '../../home/widgets/nextScreenButton.dart';
import 'DriverRegistrationComp.dart';

class DrivingLicensePage extends StatefulWidget {
  const DrivingLicensePage({super.key});

  @override
  State<DrivingLicensePage> createState() => _DrivingLicensePageState();
}

class _DrivingLicensePageState extends State<DrivingLicensePage> {
  File? _dlFront;
  File? _dlBack;

  Future<void> _pickImage(ImageSource source, bool isFront) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        if (isFront) {
          _dlFront = File(image.path);
        } else {
          _dlBack = File(image.path);
        }
      });
    }
  }

  void _showImagePickerOptions(bool isFront) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blueAccent),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, isFront);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.greenAccent),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, isFront);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadContainer({
    required String label,
    required File? image,
    required VoidCallback onTap,
  }) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: image != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

      const Icon(Icons.file_open_outlined, size: 50),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Please upload a clear image',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Only in JPG/PNG Format',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          "Driving License Upload",
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Hi ",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "Lorem",
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ", Ready to Become a BuzzCab's Roadie?",
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            Text(
              "Upload Driving License Front",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            buildUploadContainer(
              label: "DL FRONT",
              image: _dlFront,
              onTap: () => _showImagePickerOptions(true),
            ),
            Text(
              "Upload Driving License Back",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            buildUploadContainer(
              label: "DL BACK",
              image: _dlBack,
              onTap: () => _showImagePickerOptions(false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Nextscreenbutton(
          onPressed: () {
            if (_dlFront != null && _dlBack != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Driving License uploaded!')),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DriverRegistrationComp(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please upload both front and back of DL'),
                ),
              );
            }
          },
          buttonText: 'Next',
        ),
      ),
    );
  }
}
