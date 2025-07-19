import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../home/widgets/CustomAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;

  DateTime get today => DateTime.now();
  DateTime get sevenDaysAgo => today.subtract(const Duration(days: 7));
  DateTime get thirtyDaysAgo => today.subtract(const Duration(days: 30));

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Color getBackgroundColor(Brightness brightness) =>
      brightness == Brightness.dark
          ? const Color(0xFF1A202C)
          : const Color(0xFFF8FAFF);

  Color getCardColor(Brightness brightness) =>
      brightness == Brightness.dark ? const Color(0xFF2D3748) : Colors.white;

  Color getTextPrimary(Brightness brightness) =>
      brightness == Brightness.dark ? Colors.white : const Color(0xFF2D3748);

  Color getTextSecondary(Brightness brightness) => brightness == Brightness.dark
      ? const Color(0xFFA0AEC0)
      : const Color(0xFF4A5568);

  Color getTextTertiary(Brightness brightness) => brightness == Brightness.dark
      ? const Color(0xFF718096)
      : const Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    // Get system brightness
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Apply theme colors based on system brightness
    final backgroundColor = getBackgroundColor(brightness);
    final cardColor = getCardColor(brightness);
    final textPrimary = getTextPrimary(brightness);
    final textSecondary = getTextSecondary(brightness);
    final textTertiary = getTextTertiary(brightness);
    final iconTertiary = isDarkMode
        ? Colors.white
        : const Color(0xFF4A5568); // Icon color for tertiary text

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        actionWidgets: [
          // Notification button (removed dark mode toggle)
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: Stack(
                children: [
                  Icon(Iconsax.notification, color: textPrimary, size: 22),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53E3E),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 8,
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Online Status Toggle
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isOnline
                    ? const Color(0xFF48BB78)
                    : const Color(0xFF718096),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (isOnline
                            ? const Color(0xFF48BB78)
                            : const Color(0xFF718096))
                        .withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isOnline ? "You're Online!" : "You're Offline",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isOnline
                              ? "Ready to accept rides"
                              : "Tap to go online",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isOnline,
                    onChanged: (value) {
                      setState(() {
                        isOnline = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.white.withOpacity(0.3),
                    inactiveThumbColor: Colors.white70,
                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Welcome Section with Date
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Good Morning, Garv!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Today: ${formatDate(today)}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.car,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Quick Actions
            Row(
              children: [
                Icon(Iconsax.flash_1, color: textSecondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    icon: Iconsax.location,
                    label: "Set \nRoute",
                    color: const Color(0xFF4299E1),
                    onTap: () {},
                    isDarkMode: isDarkMode,
                    cardColor: cardColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: QuickActionCard(
                    icon: Iconsax.gas_station,
                    label: "Find \nFuel",
                    color: const Color(0xFFED8936),
                    onTap: () {},
                    isDarkMode: isDarkMode,
                    cardColor: cardColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: QuickActionCard(
                    icon: Iconsax.call,
                    label: "SOS \nHelp",
                    color: const Color(0xFFE53E3E),
                    onTap: () {},
                    isDarkMode: isDarkMode,
                    cardColor: cardColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Earnings Section with Date Ranges
            Row(
              children: [
                Icon(Iconsax.wallet_3, color: textSecondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Earnings Summary",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                EarningsCard(
                  label: "Today",
                  amount: "₹550",
                  date: formatDate(today),
                  gradient: const [Color(0xFF48BB78), Color(0xFF38A169)],
                  icon: Iconsax.calendar_1,
                ),
                EarningsCard(
                  label: "Last 7 Days",
                  amount: "₹3,900",
                  date: "${formatDate(sevenDaysAgo)} - ${formatDate(today)}",
                  gradient: const [Color(0xFF4299E1), Color(0xFF3182CE)],
                  icon: Iconsax.calendar_2,
                ),
                EarningsCard(
                  label: "Last 30 Days",
                  amount: "₹15,200",
                  date: "${formatDate(thirtyDaysAgo)} - ${formatDate(today)}",
                  gradient: const [Color(0xFFED8936), Color(0xFFDD6B20)],
                  icon: Iconsax.calendar,
                ),
                const EarningsCard(
                  label: "All Time",
                  amount: "₹75,400",
                  date: "Total Earnings",
                  gradient: [Color(0xFF9F7AEA), Color(0xFF805AD5)],
                  icon: Iconsax.coin,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Today's Performance
            Row(
              children: [
                Icon(Iconsax.chart, color: textSecondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Today's Performance",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                RideStatCard(
                  label: "Total Rides",
                  value: "8",
                  icon: Iconsax.car,
                  color: const Color(0xFF4299E1),
                  isDarkMode: isDarkMode,
                  cardColor: cardColor,
                ),
                const SizedBox(width: 12),
                RideStatCard(
                  label: "Completed",
                  value: "7",
                  icon: Iconsax.tick_circle,
                  color: const Color(0xFF48BB78),
                  isDarkMode: isDarkMode,
                  cardColor: cardColor,
                ),
                const SizedBox(width: 12),
                RideStatCard(
                  label: "Cancelled",
                  value: "1",
                  icon: Iconsax.close_circle,
                  color: const Color(0xFFE53E3E),
                  isDarkMode: isDarkMode,
                  cardColor: cardColor,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Vehicle Status & Health
            Row(
              children: [
                Icon(Iconsax.car, color: textSecondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Vehicle Status",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VehicleStatusItem(
                          icon: Iconsax.gas_station,
                          label: "Fuel",
                          value: "78%",
                          color: const Color(0xFF48BB78),
                          isDarkMode: isDarkMode,
                          textColor: textTertiary,
                        ),
                      ),
                      Expanded(
                        child: VehicleStatusItem(
                          icon: Iconsax.car,
                          label: "Car Health",
                          value: "Good",
                          color: const Color(0xFF4299E1),
                          isDarkMode: isDarkMode,
                          textColor: textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: VehicleStatusItem(
                          icon: Iconsax.speedometer,
                          label: "Mileage",
                          value: "21km",
                          color: const Color(0xFFED8936),
                          isDarkMode: isDarkMode,
                          textColor: textTertiary,
                        ),
                      ),
                      Expanded(
                        child: VehicleStatusItem(
                          icon: Iconsax.shield_tick,
                          label: "Insurance",
                          value: "Valid",
                          color: const Color(0xFF48BB78),
                          isDarkMode: isDarkMode,
                          textColor: textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Driver Profile
            Row(
              children: [
                Icon(Iconsax.profile_circle, color: textSecondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Driver Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  InfoRow(
                    iconColor: iconTertiary,
                    label: "Vehicle Type",
                    value: "Sedan",
                    icon: Iconsax.car,
                    valueColor: const Color(0xFF4299E1),
                    isDarkMode: isDarkMode,
                    textColor: iconTertiary,
                  ),
                  InfoRow(
                    iconColor: iconTertiary,
                    label: "Vehicle Number",
                    value: "RJ 14 AB 1234",
                    icon: Iconsax.code,
                    valueColor: textSecondary,
                    isDarkMode: isDarkMode,
                    textColor: iconTertiary,
                  ),
                  InfoRow(
                    iconColor: iconTertiary,
                    label: "Driver Rating",
                    value: "4.8 ★",
                    icon: Iconsax.star1,
                    valueColor: const Color(0xFFED8936),
                    isDarkMode: isDarkMode,
                    textColor: iconTertiary,
                  ),
                  InfoRow(
                    iconColor: iconTertiary,
                    label: "Online Duration",
                    value: "6h 45min",
                    icon: Iconsax.clock,
                    valueColor: const Color(0xFF48BB78),
                    isDarkMode: isDarkMode,
                    textColor: iconTertiary,
                  ),
                  InfoRow(
                    iconColor: iconTertiary,
                    label: "License Status",
                    value: "Valid",
                    icon: Iconsax.card,
                    valueColor: const Color(0xFF48BB78),
                    isDarkMode: isDarkMode,
                    textColor: iconTertiary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ================== Custom Widgets ==================

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isDarkMode;
  final Color cardColor;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isDarkMode,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? const Color(0xFFA0AEC0)
                    : const Color(0xFF4A5568),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EarningsCard extends StatelessWidget {
  final String label;
  final String amount;
  final String date;
  final List<Color> gradient;
  final IconData icon;

  const EarningsCard({
    super.key,
    required this.label,
    required this.amount,
    required this.date,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                icon,
                color: Colors.white70,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white60,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class RideStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDarkMode;
  final Color cardColor;

  const RideStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.isDarkMode,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode
                    ? const Color(0xFFA0AEC0)
                    : const Color(0xFF718096),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDarkMode;
  final Color textColor;

  const VehicleStatusItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDarkMode,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color valueColor;
  final bool isDarkMode;
  final Color textColor;
  final Color iconColor;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.valueColor,
    required this.isDarkMode,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF4A5568)
                  : const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
