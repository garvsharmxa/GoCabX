import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/colors/color.dart';
import '../../home/widgets/nextScreenButton.dart';
import 'DriverRegistrationComp.dart';
import 'DrivingLicensePage.dart';

class AadharPage extends StatefulWidget {
  const AadharPage({super.key});

  @override
  State<AadharPage> createState() => _AadharPageState();
}

class _AadharPageState extends State<AadharPage> {
  File? _aadharFront;
  File? _aadharBack;

  Future<void> _pickImage(ImageSource source, bool isFront) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        if (isFront) {
          _aadharFront = File(image.path);
        } else {
          _aadharBack = File(image.path);
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
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
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
                leading:
                    const Icon(Icons.photo_library, color: Colors.greenAccent),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, isFront);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Widget buildUploadContainer({
      required String label,
      required File? image,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_open_outlined,size: 50,),

                    SvgPicture.asset("assets/images/content/image 5.svg"),
                    const SizedBox(height: 10),
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      'Please upload a clear image',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDarkMode ? Colors.white : Colors.black,
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

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Hi ",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: isDarkMode ? Colors.white : Colors.black,
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
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Upload Aadhar Card Front",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            buildUploadContainer(
              label: "AADHAR FRONT",
              image: _aadharFront,
              onTap: () => _showImagePickerOptions(true),
            ),
            Text(
              "Upload Aadhar Card Back",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            buildUploadContainer(
              label: "AADHAR BACK",
              image: _aadharBack,
              onTap: () => _showImagePickerOptions(false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Nextscreenbutton(
          onPressed: () {
            if (_aadharFront != null && _aadharBack != null) {
              // Upload logic goes here

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Both images submitted successfully!')),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const  DrivingLicensePage(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Please upload both front and back of Aadhar card')),
              );
            }
          },
          buttonText: 'Next',
        ),
      ),
    );
  }
}
