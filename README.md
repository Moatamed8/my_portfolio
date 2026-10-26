# Moatamed Wageh — Portfolio

A fast, modern, responsive personal portfolio built with **Flutter Web**.
Designed for performance: an instant HTML/CSS loading screen shows immediately
while the Flutter engine boots, bundled fonts (no runtime font downloads),
optimized images, and a clean single-page layout.

## Features

- ⚡ **Instant loading screen** — animated splash rendered before Flutter starts
  (see `web/index.html`), faded out automatically on first frame.
- 🌗 **Dark / light theme toggle** — defaults to dark, remembers nothing yet
  (stateless toggle), adapts the browser theme-color too.
- 📱 **Fully responsive** — mobile, tablet and desktop layouts.
- 🎯 **Sections** — Hero, About, Services, Work (projects), Contact, Footer.
- ✨ Smooth scroll-triggered reveal animations and hover effects.
- 🔎 **SEO + social meta** tags and PWA manifest.

## Project structure

```
lib/
├── main.dart                 # App entry, theme state, splash removal
├── core/                     # Theme, breakpoints, links, splash
├── domain/entities/          # Project and other content models
├── data/
│   └── portfolio_data.dart   # ALL content lives here — edit this file
├── widgets/                  # Shared UI used by more than one section
├── sections/                 # One folder per section, with its own widgets
└── screens/
    └── home_screen.dart      # Layout + scroll navigation
```

## Editing your content

Everything personal (name, bio, projects, services, social links, CV link)
is in **`lib/data/portfolio_data.dart`**. Update values there.

Project screenshots are optimized WebP files under `assets/projects/<name>/`.
A project can list one image or several; several become a carousel. Icons
live in `assets/icons/`, and the profile photo is `assets/images/profile.jpeg`.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

Opening the site sends one Telegram message per browser tab: country, city,
time in Egypt, and device. The bot token and chat id live in
`lib/core/visit/telegram_secrets.dart`, which is gitignored.
`telegram_secrets.example.dart` is the empty template. Refreshing the same
tab does not send another message.

The token stays out of git. A web build still contains it, because the page
itself sends the message. Use the regular web build for these alerts. The
WebAssembly build does not send them.

## Build for production

```bash
flutter build web --release
```

For even better runtime performance you can try the WebAssembly renderer:

```bash
flutter build web --release --wasm
```

Output is generated in `build/web/`, ready to deploy to Firebase Hosting,
GitHub Pages, Netlify, Vercel, etc.

## Deploy to Firebase (same as the old site)

```bash
firebase deploy
```
