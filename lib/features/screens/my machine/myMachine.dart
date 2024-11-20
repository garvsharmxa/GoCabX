import 'package:flutter/material.dart';
import '../../authentication/login/widgets/divider.dart';
import 'widgets/HeaderWithProfile.dart';
import 'widgets/searchbox.dart';

class Mymachine extends StatefulWidget {
  const Mymachine({super.key});

  @override
  State<Mymachine> createState() => _AddMachineWidgetState();
}

class _AddMachineWidgetState extends State<Mymachine> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWithProfile(),
              SizedBox(height: 16),
              Text('Add Machine:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              const SizedBox(height: 16),
              const Text(
                  'अपनी मशीन को जोड़ने के लिए सीरियल नंबर दर्ज करें या मशीन पर मौजूद QR कोड स्कैन करें।',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const Text('सीरियल नंबर दर्ज करें',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        const SizedBox(height: 12),
                        searchBox(
                            textController: _textController,
                            textFieldFocusNode: _textFieldFocusNode),
                        const SizedBox(height: 24),
                        divider(text: 'Or'),
                        const SizedBox(height: 16),
                        
                      ],
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
}
