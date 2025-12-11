# RentWheels

Mobile app for renting cars with a smooth user experience, user/admin flows, and integrated online payments.

## Features

- Browse and filter available vehicles, view details, and place bookings.
- Firebase-backed email/password authentication and user data storage.
- Online payments via PhonePe (demo/sandbox account).
- Admin panel to add/update vehicles, approve bookings, and view users.
- Cross-platform UI built with Flutter.

## Tech Stack

- Flutter (Dart)
- Firebase Auth + Firestore/Realtime DB (app data)
- PhonePe demo gateway (payments)

## Getting Started

1) Prerequisites
   - Flutter SDK installed and on PATH.
   - Dart SDK (bundled with Flutter).
   - Firebase project configured; download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS/macOS).
2) Install deps
   - `flutter pub get`
3) Configure services
   - Place `android/app/google-services.json`.
   - Place `ios/Runner/GoogleService-Info.plist` (and macOS equivalent if used).
   - Add your PhonePe demo credentials/keys to the designated config (env/secret store used in your setup).
4) Run
   - `flutter run` for a connected device or emulator.

## Project Structure (high level)

- `lib/main.dart` — app entrypoint and root widget setup.
- `lib/` — screens, widgets, and domain logic (e.g., vehicle management).
- `android/`, `ios/`, `macos/` — platform-specific configs (Firebase, build settings).

## Demo Videos

- User Side: <https://youtu.be/-tD_kSBihIM?si=ol-zQvNsQWm60Ob1>
- Admin Side: <https://youtu.be/tYeuk3_esao?si=NvKZ2MW-HCvVsCeF>

## Contributing

Pull requests and issue reports are welcome. Please include a brief description, screenshots (if UI), and steps to reproduce bugs.
