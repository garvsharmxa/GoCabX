class RideModel {
  final String pickupLocation;
  final String dropOffLocation;
  final String pickupInfo;
  final String rideInfo;
  final double fare;
  final int timeLeft;

  RideModel({
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.pickupInfo,
    required this.rideInfo,
    required this.fare,
    required this.timeLeft,
  });
}

List<RideModel> rideData = [
  RideModel(
    pickupLocation: 'Baltana Main Market, 012345',
    dropOffLocation: 'Sector 17 Chandigarh',
    pickupInfo: '10 Mins | 1.5 Km',
    rideInfo: '25 Mins | 2.5 Km',
    fare: 150.0,
    timeLeft: 36,
  ),
  RideModel(
    pickupLocation: 'Baltana Main Market, 012345',
    dropOffLocation: 'Sector 17 Chandigarh',
    pickupInfo: '10 Mins | 1.5 Km',
    rideInfo: '25 Mins | 2.5 Km',
    fare: 150.0,
    timeLeft: 36,
  ),

  // Mumbai-specific rides
  RideModel(
    pickupLocation: 'Andheri East, Mumbai',
    dropOffLocation: 'Chhatrapati Shivaji Maharaj International Airport',
    pickupInfo: '5 Mins | 1.0 Km',
    rideInfo: '15 Mins | 4.5 Km',
    fare: 230.0,
    timeLeft: 12,
  ),
  RideModel(
    pickupLocation: 'Bandra West, Linking Road',
    dropOffLocation: 'Lower Parel, Mumbai',
    pickupInfo: '8 Mins | 2.2 Km',
    rideInfo: '20 Mins | 5.6 Km',
    fare: 280.0,
    timeLeft: 18,
  ),
  RideModel(
    pickupLocation: 'Malad West, Inorbit Mall',
    dropOffLocation: 'Goregaon East, Nesco IT Park',
    pickupInfo: '6 Mins | 1.8 Km',
    rideInfo: '18 Mins | 4.2 Km',
    fare: 220.0,
    timeLeft: 15,
  ),
  RideModel(
    pickupLocation: 'Colaba Causeway Market',
    dropOffLocation: 'CST Station, Mumbai',
    pickupInfo: '4 Mins | 0.9 Km',
    rideInfo: '12 Mins | 3.1 Km',
    fare: 160.0,
    timeLeft: 9,
  ),
  RideModel(
    pickupLocation: 'Dadar West, Shivaji Park',
    dropOffLocation: 'Worli Sea Face',
    pickupInfo: '7 Mins | 1.7 Km',
    rideInfo: '16 Mins | 4.7 Km',
    fare: 210.0,
    timeLeft: 11,
  ),
  RideModel(
    pickupLocation: 'Powai, Hiranandani Gardens',
    dropOffLocation: 'Vikhroli Station, East',
    pickupInfo: '9 Mins | 2.4 Km',
    rideInfo: '22 Mins | 6.0 Km',
    fare: 250.0,
    timeLeft: 20,
  ),
];
