# Scholar Chat App 💬

A real-time chat application built with Flutter and Firebase, featuring authentication and instant messaging capabilities.

## ✨ Features

- **User Authentication**: Secure login and registration using Firebase Authentication
- **Real-time Messaging**: Instant message delivery powered by Cloud Firestore
- **Message Bubbles**: Distinct chat bubbles for sent and received messages
- **State Management**: Efficient state management using BLoC pattern
- **Responsive UI**: Clean and intuitive user interface
- **Auto-scroll**: Automatic scrolling to latest messages

## 📱 Screenshots

*Add your app screenshots here*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.7.2)
- Dart SDK
- Firebase account
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohamed-oraby10/chat_app.git
   cd chat_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password)
   - Enable Cloud Firestore
   - Download and replace the `firebase_options.dart` file with your own configuration
   - Or run FlutterFire CLI:
     ```bash
     flutterfire configure
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── constants.dart                 # App-wide constants
├── firebase_options.dart          # Firebase configuration
├── main.dart                      # App entry point
├── simple_bloc_observer.dart      # BLoC observer for debugging
├── helper/
│   └── show_snack_bar.dart       # Snackbar helper
├── models/
│   └── message.dart              # Message model
└── screens/
    ├── blocs/
    │   └── auth_cubit/           # Authentication BLoC
    │       ├── auth_bloc.dart
    │       ├── auth_event.dart
    │       └── auth_state.dart
    ├── cubits/
    │   └── chat_cubit/           # Chat Cubit
    │       ├── chat_cubit.dart
    │       └── chat_state.dart
    ├── widgets/
    │   ├── chat_bubble.dart      # Message bubble widgets
    │   ├── field.dart            # Custom text field
    │   └── main_button.dart      # Custom button
    ├── chat_screen.dart          # Main chat interface
    ├── login_screen.dart         # Login page
    └── register_screen.dart      # Registration page
```

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Firebase Authentication**: User authentication service
- **Cloud Firestore**: Real-time NoSQL database
- **flutter_bloc**: State management solution
- **modal_progress_hud_nsn**: Loading indicator

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.13.0
  firebase_auth: ^5.6.0
  cloud_firestore: ^5.6.9
  flutter_bloc: ^9.1.1
  modal_progress_hud_nsn: ^0.5.1
  cupertino_icons: ^1.0.8
```

## 🎯 Key Features Implementation

### Authentication Flow
- User registration with email/password validation
- Secure login with error handling
- BLoC pattern for authentication state management

### Real-time Chat
- Messages stored in Firestore with timestamps
- Automatic message ordering
- Distinct UI for sender and receiver messages
- Real-time message synchronization

## 🔐 Security

- Firebase Authentication for secure user management
- Firestore security rules should be configured in Firebase Console
- Never commit sensitive Firebase configuration to public repositories

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👤 Author

**Mohamed Oraby**

- GitHub: [@mohamed-oraby10](https://github.com/mohamed-oraby10)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- BLoC library contributors

## 📞 Support

For support, email [mohamedoraby0500@gmail.com] or open an issue in the repository.

---

⭐️ If you found this project helpful, please give it a star!
