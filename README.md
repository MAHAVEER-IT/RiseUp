<div align="center">
  <img src="images/spark.png" alt="RiseUp icon" width="112" />

  <h1>RiseUp</h1>

  <a href="https://github.com/MAHAVEER-IT/RiseUp"><img src="https://readme-typing-svg.demolab.com?font=Nunito&weight=700&size=22&pause=1200&color=4D8C76&center=true&vCenter=true&width=560&lines=Small+steps.+Real+growth.;A+calmer+way+to+keep+moving." alt="Animated RiseUp message" /></a>

  **A local-first Flutter companion for focused to-dos, habits, reflection, and gentle momentum.**

  [![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-4D8C76?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.0%2B-25463C?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![Local first](https://img.shields.io/badge/Data-Local--first-F0B08D?style=for-the-badge&logo=shield&logoColor=white)](#privacy-by-design)
</div>

<br />

## ✦ What is RiseUp?

RiseUp is not a pressure-filled productivity app. It is a quiet space for building consistency—one clear task, one small habit, one honest reflection at a time.

It keeps the important things close: your data lives on your device, your reminders are scheduled locally, and the experience is designed to encourage progress without guilt.

## ✨ Built for everyday momentum

| Feature | What it does |
| --- | --- |
| **Focused To-Dos** | Create clear tasks, break them into sub-tasks, and set a reminder time. Each reminder includes the task title. |
| **Reliable reminders** | Android local notifications continue to work while the app is closed, with exact-alarm support where available. |
| **Habit tracker** | Create a time-bound habit journey; reminders run only while the tracker is active and stop when it ends. |
| **Progress as proof** | See completed work, active days, milestones, and AI-powered weekly insights. |
| **Gentle AI support** | Use chat and reflections to turn a stuck moment into one manageable next step. |
| **Personal rhythm** | Set routine times and receive a calmer experience around your day. |

## 🔔 Reminder behavior

```text
To-do created ──► task-specific local reminder
Habit created ──► 9:30 PM reminders during its active date range
Habit completed / ended / deleted ──► habit reminders stop
To-do completed / deleted ──► its reminder is cancelled
```

> Android note: allow notifications and **Exact alarms** when prompted. If an app is force-stopped from Android Settings, Android prevents scheduled alarms until the app is opened again.

## 🔒 Privacy by design

RiseUp is **local-first**.

- Your profile, to-dos, progress, and reflections are stored on your device.
- There is no Firebase backend and no required cloud account.
- Optional Gemini AI features require the user's own Gemini API key, stored securely on-device, and send only the context needed to generate chat replies or weekly insights. Read the full [Privacy Policy](docs/privacy-policy.html).
- Clearing the app's data or uninstalling the app permanently removes its locally stored data.
- Keep API keys out of source control; the local `.env` file is intentionally private.

## 🧩 Stack

```text
Flutter + Material 3        Interface
Riverpod + GoRouter         State and navigation
Isar                        On-device app memory
flutter_local_notifications Scheduled local reminders
Gemini                      Optional supportive AI coaching
```

## 🗂️ Architecture

```text
lib/
├── core/          # database, notifications, routing, theme, networking
└── features/      # dashboard, goals, habits, progress, settings, chat, journal
```

The codebase follows a feature-first structure. Features keep their own models, repositories, state providers, and UI screens together.

## 🚀 Run locally

```bash
git clone https://github.com/MAHAVEER-IT/RiseUp.git
cd RiseUp
flutter pub get
flutter run
```

### Useful commands

```bash
# Validate the project
flutter analyze
flutter test

# Build a debug Android APK
flutter build apk --debug
```

## ✅ Quality checks

The test suite includes persistence coverage for the To-Do database lifecycle: save, reopen, update, and delete without affecting unrelated records.

## 🌱 Product philosophy

> You are not behind.<br />
> You are building.<br />
> One small step still counts.

<div align="center">
  <sub>Crafted with care by Mahaveer 💚</sub>
</div>
