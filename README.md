# Moatamed Wageh — Portfolio

A one-page portfolio built with Flutter Web. Dark mode is the default, with a light mode too. Headings use Montserrat. Body text uses Poppins.

## About

Moatamed Wageh is a Senior Flutter Developer from Egypt. He studied Computer Science and Information Technology at Zagazig University and builds production mobile apps with Flutter.

The site shows 6+ years of experience, 30+ projects, and 20+ apps in stores.

## Work

Bokidz, Luxury Health, Trade Off, Qlines, Essaly, 2rbly, 2rbly - Delivery, and 2rbly Partner.

A project can have one image or several. Several images become a carousel. Store buttons show only when a link exists.

## Services

Flutter Development, Android Development, and AI Development.

## Features

- HTML splash while Flutter starts
- Phone, tablet, and desktop layouts
- Dark and light theme
- Project hover on desktop, and a details dialog on phone
- Local WebP images
- One Telegram visit message per browser tab

## Project structure

```
lib/
├── main.dart
├── core/                     # Theme, colors, splash, visit alert
├── domain/entities/
├── data/portfolio_data.dart  # All personal content
├── widgets/                  # Shared UI
├── sections/                 # One folder per section
└── screens/home_screen.dart
```

Each section folder holds the section file and a `widgets/` folder for its smaller pieces.

## Edit content

Change the name, bio, skills, services, projects, and links in `lib/data/portfolio_data.dart`.

- Screenshots: `assets/projects/<name>/`
- Icons: `assets/icons/`
- Profile photo: `assets/images/profile.jpeg`

## Run

```bash
flutter pub get
flutter run -d chrome
```

Needs Flutter SDK `^3.12.1`.

Visit alerts use `lib/core/visit/telegram_secrets.dart`. That file is gitignored. Copy `telegram_secrets.example.dart` if you need to recreate it. The same browser tab does not send a second message.

A normal web build still contains the token, because the page sends the message. The WebAssembly build does not send alerts.

## Build

```bash
flutter build web --release
```

Output is in `build/web/`.

```bash
firebase deploy
```

## Links

- GitHub: https://github.com/Moatamed8
- LinkedIn: https://www.linkedin.com/in/moatamed-wageh/
- WhatsApp: https://api.whatsapp.com/send?phone=201288584664
- CV: https://drive.google.com/drive/folders/11W6E9Ng2HkRONMFeNT1UN46BmUJEmrgm?usp=sharing
