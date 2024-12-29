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
];


