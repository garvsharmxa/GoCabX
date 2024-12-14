import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  SvgPicture _getSvgForButton(String title) {
    switch (title) {
      case 'Home':
        return SvgPicture.asset("assets/icons/Frame.svg");
      case 'Active Rides':
        return SvgPicture.asset("assets/icons/Frame-1.svg");
      case 'History':
        return SvgPicture.asset("assets/icons/Frame-2.svg");
      case 'BuzzWallet':
        return SvgPicture.asset("assets/icons/Frame-3.svg");
      case 'Settings':
        return SvgPicture.asset("assets/icons/Frame-4.svg");
      case 'Profile':
        return SvgPicture.asset("assets/icons/Frame-5.svg");
      default:
        return SvgPicture.asset(
            "assets/icons/default.svg"); // Provide a default SVG
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : Colors.white;

    final List<String> buttonTitles = [
      "Home",
      "Active Rides",
      "History",
      "BuzzWallet",
      "Settings",
      "Profile"
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF25B29F),
              child: SvgPicture.asset('assets/icons/Vector.svg',
                  width: 50, height: 22),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 20,
              backgroundColor: isDark ? Colors.white : const Color(0xFF121212),
              child: Icon(Icons.close, color: backgroundColor),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: ClipOval(
                  child: Image.network(
                    "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, color: Colors.red, size: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Garv Sharma",
              style: TextStyle(
                  fontSize: 20, color: textColor, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Divider(
                thickness: 1.5,
                color: isDark ? Colors.white : const Color(0xFF121212),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: buttonTitles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: InkWell(
                      onTap: () {
                        debugPrint('${buttonTitles[index]} button pressed');
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            // Use the SvgPicture returned by _getSvgForButton directly
                            _getSvgForButton(buttonTitles[index]),
                            const SizedBox(
                                width: 10), // Space between icon and text
                            Text(
                              buttonTitles[index],
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                // Use the SvgPicture returned by _getSvgForButton directly

                const SizedBox(width: 10), // Space between icon and text
                Text(
                  "buttonTitles[index]",
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
