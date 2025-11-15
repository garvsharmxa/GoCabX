# 🚖 GoCabX (BuzzCab)

A modern, feature-rich ride-sharing mobile application built with Flutter. GoCabX provides seamless transportation solutions for both riders and drivers with real-time tracking, smart booking, and an intuitive user experience.

[![Flutter](https://img.shields.io/badge/Flutter-3.4.3+-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

### 🧑‍💼 For Riders
- **Easy Ride Booking**: Book rides with just a few taps
- **Real-time Tracking**: Track your driver's location in real-time on an interactive map
- **Multiple Payment Options**: Support for various payment methods including credit cards, digital wallets, and cash
- **Saved Locations**: Save frequently visited places (Home, Work, etc.) for quick booking
- **Ride History**: View complete history of past rides
- **Fare Estimation**: Get estimated fare before booking
- **Promotions & Vouchers**: Access special offers and discount vouchers
- **Profile Management**: Manage your profile and preferences
- **OTP-based Authentication**: Secure login with mobile number verification

### 🚗 For Drivers
- **Online/Offline Mode**: Toggle availability status easily
- **Ride Requests**: Receive and manage incoming ride requests
- **Navigation**: Integrated navigation to pickup and drop-off locations
- **Earnings Tracking**: Monitor your earnings and ride statistics
- **Driver Registration**: Complete registration with document verification
- **Profile Management**: Update driver profile and vehicle information
- **Ride History**: View completed rides and earnings history

### 🌟 Common Features
- **Dark Mode Support**: Seamless dark and light theme support
- **Google Maps Integration**: Powerful mapping and location services
- **Push Notifications**: Real-time updates on ride status
- **Multi-language Support**: Internationalization ready
- **Beautiful UI/UX**: Modern, animated, and responsive design
- **Help & Support**: In-app help center and FAQs

## 🛠️ Technology Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Maps**: Google Maps Flutter
- **Location Services**: Geolocator, Geocoding
- **UI Components**: 
  - Material Design 3
  - Custom Animations (Lottie)
  - Google Fonts
  - Shimmer Effects
  - Custom SVG Icons
- **Storage**: 
  - Shared Preferences
  - GetStorage
- **HTTP Client**: Dart HTTP Package
- **Image Handling**: Image Picker, Cached Network Image
- **Additional Packages**:
  - Polyline Points (Route visualization)
  - Flutter Google Places
  - Data Table 2
  - Pin Code Fields

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.4.3 or higher
  - [Installation Guide](https://docs.flutter.dev/get-started/install)
- **Dart SDK**: Version 3.0 or higher (comes with Flutter)
- **Android Studio** or **Xcode**: For running on Android/iOS
- **Git**: For version control
- **Google Maps API Key**: Required for map functionality

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/garvsharmxa/GoCabX.git
cd GoCabX
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Google Maps API

#### For Android:
1. Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
2. Add the API key to `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
```

#### For iOS:
1. Add the API key to `ios/Runner/AppDelegate.swift`:

```swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
```

### 4. Configure Permissions

The app requires location permissions. These are already configured in the manifest files, but you may need to adjust them based on your requirements:

- **Android**: Check `android/app/src/main/AndroidManifest.xml`
- **iOS**: Check `ios/Runner/Info.plist`

### 5. Run Build Runner (if needed)

If you make changes to JSON serializable models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🏃‍♂️ Running the App

### Run on Android

```bash
flutter run
```

### Run on iOS

```bash
flutter run
```

### Run on Web

```bash
flutter run -d chrome
```

### Build Release APK (Android)

```bash
flutter build apk --release
```

### Build Release iOS

```bash
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # Main app widget with routing
├── common/                   # Shared widgets and utilities
│   ├── widgets/             # Reusable widgets
│   └── styles/              # Common styles and themes
├── features/                 # Legacy features
│   ├── authentication/      # Auth screens and logic
│   ├── Drawer/             # Drawer navigation
│   └── Help_Support/       # Help and support screens
├── featuresDriver/          # Driver-specific features
│   ├── home/               # Driver home screen
│   ├── rideRequest/        # Ride request management
│   ├── history/            # Ride history
│   ├── profile/            # Driver profile
│   ├── registration/       # Driver registration flow
│   └── navigation_menu.dart # Driver navigation
├── featuresRider/           # Rider-specific features
│   ├── screen/
│   │   ├── homePage/       # Rider home screen
│   │   ├── bookRides/      # Ride booking screens
│   │   ├── mapScreen/      # Map and location screens
│   │   ├── CabBookingFlow/ # Complete booking flow
│   │   ├── profile/        # Rider profile
│   │   └── setting/        # Settings
│   └── bottomNavigation.dart
├── utils/                   # Utility classes
│   ├── constants/          # App constants
│   ├── theme/              # Theme configuration
│   ├── helpers/            # Helper functions
│   ├── validators/         # Input validators
│   └── http/               # HTTP client
├── Service/                 # Business logic services
│   └── Controllers/        # State management controllers
└── Constant/               # Additional constants

assets/
├── icons/                   # App icons and SVG files
├── images/                  # Images and animations
├── logos/                   # Brand logos
└── animations/             # Lottie animations
```

## ⚙️ Configuration

### API Configuration

Update the API endpoints in `lib/utils/constants/api_constants.dart`:

```dart
class ApiConstants {
  static const String baseUrl = "YOUR_API_BASE_URL";
  // Add other API endpoints
}
```

### App Configuration

- **App Name**: Edit in `pubspec.yaml` and `lib/utils/constants/text_strings.dart`
- **Theme Colors**: Configure in `lib/utils/theme/theme.dart`
- **App Icons**: Replace icons in respective platform folders

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code follows the existing style and includes appropriate tests.

## 📝 Code Style

This project follows the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide. Run the linter before committing:

```bash
flutter analyze
```

## 🐛 Known Issues

- Flutter version must be 3.4.3 or higher due to Material Design 3 requirements
- Some features may require backend API integration (not included in this repository)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Garv Sharma**
- GitHub: [@garvsharmxa](https://github.com/garvsharmxa)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX for powerful state management
- Google Maps Platform for location services
- All contributors and supporters of this project

## 📞 Support

For support, email [your-email@example.com] or create an issue in this repository.

## 🗺️ Roadmap

- [ ] Backend API integration
- [ ] Real-time chat between rider and driver
- [ ] Push notification implementation
- [ ] Payment gateway integration
- [ ] Rating and review system
- [ ] Advanced analytics dashboard
- [ ] Multi-language support expansion
- [ ] Accessibility improvements

---

**Note**: This app requires a backend server for full functionality. The frontend is complete and ready for integration with your preferred backend solution.

Made with ❤️ using Flutter
