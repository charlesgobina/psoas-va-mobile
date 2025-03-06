# Vapasun Mobile App

A Flutter mobile application for exploring apartment listings from PSOAS (Student Housing Foundation). 

## Overview

Vapasun is designed to help users browse, search, and apply for apartments. The app provides a convenient way to access apartment details, manage applications, and receive updates on available units. Students can set notification of what kind of apartments they are looking for and immediately get a push notification when it becomes available.

## Features

- **Authentication**: Easy and straighforward sign in with Google Auth System
- **Apartment Browsing**: View a list of available apartments with essential details
- **Detailed Information**: Access comprehensive information about each apartment including size, rent, amenities
- **Profile Management**: Manage your personal profile and housing preferences
- **Sublease Management**: View and manage sublease opportunities (Coming Soon)
- **Filters**: Filter apartments based on various criteria like size, rent, and location (WIP)
- **Setting**: Manage App Settings (WIP)
- **Notifications**: Get push notifications on your 'dream' apartment immediately it becomes available

## Technology Stack

- Flutter & Dart
- Provider for state management
- Hive for local data persistence
- GoRouter for navigation
- OneSignal for push notifications
- REST API integration for backend communication

## Screenshots

<details>
<summary>Click to expand screenshots</summary>

### Login
[Login Screen](./assets/screenshots/Screenshot%202025-03-06%20110526.png)

### Apartment Listings
[Apartment Listings Screenshot](./assets/screenshots/Screenshot%202025-03-06%20110210.png)

### Apartment Details
[Apartment Details Screenshot](./assets/screenshots/Screenshot%202025-03-06%20110311.png)

### User Profile
[User Account Screenshot](./assets/screenshots/Screenshot%202025-03-06%20110421.png)

### Dream Apartment Screen
[Dream Apartment](./assets/screenshots/Screenshot%202025-03-06%20110350.png)

</details>

## Installation & Setup

### Prerequisites
- Flutter SDK (3.27.3 or higher)
- Dart SDK (3.6.1 or higher)
- Android Studio / VS Code with Flutter extensions
- Android SDK or iOS development setup

### Getting Started
1. Clone the repository
2. Install dependencies
3. Run the app

## Project Structure
lib/
├── main.dart                    # Application entry point
├── src/
│   ├── common/                  # Common utilities and widgets
│   │   └── providers/           # Common providers like screen_switch_provider
│   ├── features/
│   │   ├── apartments/          # Apartment-related features
│   │   │   ├── data/            # Data models and repositories
│   │   │   └── ui/              # UI components for apartments
│   │   ├── authentication/      # Authentication-related features
│   │   ├── home/                # Home screen and related components
│   │   ├── profile/             # User profile management
│   │   ├── settings/            # App settings
│   │   └── sublease/            # Sublease management

## Contributing

We welcome contributions to improve Vapasun Mobile! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.