# Product Management App (Singer Flutter)
This Flutter application serves as the mobile front end for the Singer Sri Lanka Product Code Management System. It provides staff with a real-time, mobile-first solution to securely manage product information by connecting to a dedicated backend API.

# Features
* 🔐 Secure Authentication: Login screen to authenticate users against the backend and securely store the JWT token on the device.
* 🔄 Full CRUD Functionality: Intuitive interfaces to insert, update, and search for product details.
* 📱 Mobile-First Responsive UI: Clean and responsive layout designed for an excellent user experience on mobile devices.
* ✔️ Form Validation: Clear input labels and error messages on all forms to ensure data integrity (e.g., required fields, numeric prices).
* ⚡ Real-time Search: Quickly search for products by either product code or name and view results in a clear list view.

# Technology Stack
* Flutter: For building the cross-platform mobile application.
* Dart: The programming language for Flutter.
* Provider: For simple and effective state management.
* http: For making API calls to the backend.
* flutter_secure_storage: For securely persisting the JWT authentication token.

# Getting Started
* Follow these instructions to get the project set up and running on your local machine for development and testing.

* Prerequisites
* You must have the following software installed on your machine:
* Flutter SDK (version 3.0 or later).
* A code editor like VS Code with the Flutter extension or Android Studio.
* A running instance of the ProductManagementBackend. The API must be accessible from your mobile device/emulator.

#  Setup Instruction
Clone the Repository



# Install Dependencies
Run the following command from the project root to fetch all the required packages:

flutter pub get

#  Environment Configuration
* The application's connection to the backend API is configured in the lib/services/api_service.dart file.
* Open lib/services/api_service.dart.
* Find the _baseUrl constant and update its value to point to your running backend API.

// lib/services/api_service.dart

```class ApiService {
  // IMPORTANT: Change this URL to match your backend's address.

  // For Android Emulator connecting to a local PC backend:
  static const String _baseUrl = "https://10.0.2.2:7126/api";
  
  // For iOS Simulator connecting to a local PC backend:
  // static const String _baseUrl = "https://localhost:7126/api";

  // For a deployed backend:
  // static const String _baseUrl = "https://your-production-api.com/api";
  
  // ... rest of the code
}```


#  Application Flow
* Login: The app starts with a login screen. Use the credentials configured in the backend (username: admin, password: admin123).
* Product List: Upon successful login, you are taken to the main product list screen where you can search for products.
* Add a Product: Use the floating + button to navigate to the form for adding a new product.
* Edit a Product: Tap on any product in the list to open the same form, pre-filled with its data, allowing you to edit and save changes.
* Logout: Use the logout icon in the app bar to clear your session and return to the login screen.
