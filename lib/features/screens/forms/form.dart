import 'package:flutter/material.dart';
import '../my machine/widgets/HeaderWithProfile.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _hourlyChargeController = TextEditingController();

  @override
  void dispose() {
    _headlineController.dispose();
    _detailsController.dispose();
    _locationController.dispose();
    _hourlyChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWithProfile(),
                const SizedBox(height: 16.0),
                const Text(
                  'Request Submission:',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Post your requirements to get request from the renters near you',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 24.0),
                _buildTextField('Headline', _headlineController),
                const SizedBox(height: 16.0),
                _buildTextField('Details', _detailsController, maxLines: 5),
                const SizedBox(height: 16.0),
                _buildTextField('Location', _locationController),
                const SizedBox(height: 16.0),
                _buildTextField('Hourly Charge', _hourlyChargeController),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 3,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange),
                            child: const Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        // flex: 1,
                        child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Cancel')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
            label: Text(label),
          ),
        ),
      ],
    );
  }
}
