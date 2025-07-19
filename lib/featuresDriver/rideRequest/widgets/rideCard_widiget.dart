import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/widgets/colors/color.dart';
import '../../../common/widgets/colors/color.dart';
import 'dot_line.dart';
import 'rideBook_cardWidget.dart';
import 'rideCard_DataModel.dart';

class RideCard extends StatefulWidget {
  final RideModel ride;
  final Size size;

  RideCard(this.ride, this.size);

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: widget.size.height * 0.01,
                horizontal: widget.size.width * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [
                    const Color(0xFF2D3748),
                    const Color(0xFF1A202C),
                  ]
                      : [
                    Colors.white,
                    const Color(0xFFF7FAFC),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Gradient overlay for visual depth
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              AppColors.primary.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(widget.size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(isDarkMode),
                          SizedBox(height: widget.size.height * 0.02),
                          _buildTimeSection(isDarkMode),
                          SizedBox(height: widget.size.height * 0.02),
                          _buildLocationSection(isDarkMode),
                          SizedBox(height: widget.size.height * 0.025),
                          _buildInfoSection(isDarkMode),
                          SizedBox(height: widget.size.height * 0.02),
                          _buildFareSection(isDarkMode),
                          SizedBox(height: widget.size.height * 0.025),
                          _buildActionButtons(isDarkMode),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.size.width * 0.03,
            vertical: widget.size.height * 0.008,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fiber_new,
                color: Colors.white,
                size: widget.size.width * 0.04,
              ),
              SizedBox(width: widget.size.width * 0.01),
              Text(
                'NEW RIDE',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.size.width * 0.032,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.size.width * 0.025,
            vertical: widget.size.height * 0.006,
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.green.shade800 : Colors.green.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.green,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: widget.size.width * 0.04,
              ),
              SizedBox(width: widget.size.width * 0.01),
              Text(
                '₹${widget.ride.fare}',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.size.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection(bool isDarkMode) {
    double progress = (30 - widget.ride.timeLeft) / 30; // Assuming 30 sec max

    return Container(
      padding: EdgeInsets.all(widget.size.width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: Colors.orange,
                    size: widget.size.width * 0.05,
                  ),
                  SizedBox(width: widget.size.width * 0.02),
                  Text(
                    'Time to Accept',
                    style: GoogleFonts.poppins(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                      fontSize: widget.size.width * 0.036,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.025,
                  vertical: widget.size.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.ride.timeLeft}s',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: widget.size.height * 0.015),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.ride.timeLeft > 10 ? Colors.green : Colors.red,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(widget.size.width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.blue.shade900.withOpacity(0.2) : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDarkMode ? Colors.blue.shade800 : Colors.blue.shade100,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLocationPoint(
              icon: Icons.my_location,
              label: 'PICKUP',
              location: widget.ride.pickupLocation,
              color: const Color(0xFF1F9686),
              isDarkMode: isDarkMode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: widget.size.width * 0.03),
            child: Column(
              children: [
                Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                  size: widget.size.width * 0.06,
                ),
                Container(
                  width: 2,
                  height: widget.size.height * 0.04,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primary,
                  size: widget.size.width * 0.05,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildLocationPoint(
              icon: Icons.location_on,
              label: 'DROP-OFF',
              location: widget.ride.dropOffLocation,
              color: const Color(0xFF211F96),
              isDarkMode: isDarkMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPoint({
    required IconData icon,
    required String label,
    required String location,
    required Color color,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(widget.size.width * 0.02),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: widget.size.width * 0.04,
              ),
            ),
            SizedBox(width: widget.size.width * 0.02),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: widget.size.width * 0.03,
              ),
            ),
          ],
        ),
        SizedBox(height: widget.size.height * 0.008),
        Text(
          location,
          style: GoogleFonts.poppins(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontSize: widget.size.width * 0.035,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildInfoSection(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Icons.info_outline,
            title: 'Pickup Info',
            value: widget.ride.pickupInfo,
            color: Colors.blue,
            isDarkMode: isDarkMode,
          ),
        ),
        SizedBox(width: widget.size.width * 0.03),
        Expanded(
          child: _buildInfoCard(
            icon: Icons.directions_car,
            title: 'Ride Info',
            value: widget.ride.rideInfo,
            color: Colors.purple,
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required bool isDarkMode,
  }) {
    return Container(
      padding: EdgeInsets.all(widget.size.width * 0.03),
      decoration: BoxDecoration(
        color: isDarkMode ? color.withOpacity(0.1) : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: widget.size.width * 0.04,
              ),
              SizedBox(width: widget.size.width * 0.01),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: widget.size.width * 0.03,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: widget.size.height * 0.005),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: isDarkMode ? Colors.white : Colors.black87,
              fontSize: widget.size.width * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareSection(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(widget.size.width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.green.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.green.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(widget.size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.currency_rupee,
                  color: Colors.white,
                  size: widget.size.width * 0.05,
                ),
              ),
              SizedBox(width: widget.size.width * 0.03),
              Text(
                'Total Fare',
                style: GoogleFonts.poppins(
                  color: Colors.green.shade800,
                  fontSize: widget.size.width * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            '₹${widget.ride.fare}',
            style: GoogleFonts.poppins(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: widget.size.width * 0.05,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Add haptic feedback
                // HapticFeedback.mediumImpact();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: widget.size.width * 0.05,
                  ),
                  SizedBox(width: widget.size.width * 0.02),
                  Text(
                    "Accept Ride",
                    style: GoogleFonts.poppins(
                      fontSize: widget.size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: widget.size.width * 0.03),
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.red.shade500,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              // Add haptic feedback
              // HapticFeedback.mediumImpact();
            },
            child: Icon(
              Icons.close,
              size: widget.size.width * 0.05,
            ),
          ),
        ),
      ],
    );
  }
}