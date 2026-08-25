# RiseUp AI

RiseUp AI is a local-first Flutter mobile app for personal growth, discipline, confidence, focus, English speaking practice, and daily self-reflection.

It is not designed as a normal productivity or task app. RiseUp is built to feel like a caring companion, mentor, accountability partner, and confidence coach.

## Core Idea

RiseUp works around a simple companion system:

```text
Gemini = Brain
Isar = Memory
NotificationService = Voice
Quick Update = User response
Progress = Proof
```

The app checks in with the user throughout the day, listens through quick updates, saves local memory, and turns small actions into visible proof of progress.

## Target User

RiseUp is built for:

- College students
- Placement preparation students
- Users with low confidence
- Users distracted by social media
- Users struggling with discipline and consistency
- Users improving English speaking and communication skills

## Main Goals

- Discipline
- Confidence
- Focus
- English speaking
- Communication skills
- Motivation
- Consistency
- Personal growth

## Tech Stack

- Flutter
- Material 3
- Riverpod
- GoRouter
- Isar local database
- Gemini API
- flutter_local_notifications

No Firebase. No backend. The app stores user data locally on the device.

## Current Features

### Home

The Home page gives a calm overview of the user's day:

- Time-aware greeting
- Morning check-in prompt
- Energy-based recommendation
- Active goals
- Focus session entry
- Quick access to RiseUp AI chat

### AI Chat

The AI chat gives supportive coaching.

It is designed to:

- Encourage the user
- Avoid shame or guilt
- Celebrate small wins
- Suggest realistic next steps
- Help after distraction or low-energy moments

### Companion Notifications

Notifications are treated as the voice of RiseUp, not simple reminders.

The notification system can:

- Request notification permission
- Create notification channels
- Schedule companion check-ins
- Schedule daily reflection reminders
- Schedule weekly review reminders
- Trigger achievement notifications
- Open the correct app screen when tapped

Notification tap behavior:

```text
Companion check-in -> Quick Update
Reflection reminder -> Journal
Weekly review -> Progress
Mood reminder -> Check-in
Achievement -> Home
```

Default companion mode is balanced, which checks in roughly every 2 hours during active day windows.

### Quick Update

Quick Update lets the user respond fast when RiseUp checks in.

Examples:

- In Lecture
- Studying
- DSA
- DBMS
- English Practice
- Project Work
- Taking Break
- Instagram
- YouTube
- Feeling Tired
- Feeling Low

After a quick update, the app saves the activity and can generate an AI coaching response.

### Daily Check-In

The check-in screen records:

- Mood
- Energy
- Morning check-in completion

The app uses this to give gentler, more realistic suggestions.

### Goals And Focus

The goals feature supports:

- Creating goals
- Priority levels
- Focus sessions
- Focus duration tracking
- Goal-based focus timer navigation

### Journal

The Journal page is the user's self-awareness and confidence builder.

It supports:

- Daily reflection
- Small win tracking
- Recent reflection history
- English speaking practice logging
- Practice duration
- Practice type
- Fluency rating
- Confidence rating
- Understanding rating

The journal is not just a diary. It creates proof that the user is improving.

### Progress

The Progress page is the proof page of RiseUp.

It collects data from across the local database:

- Daily check-ins
- Mood logs
- Focus sessions
- Active goals
- Journal reflections
- Small wins
- English practice logs
- Companion quick updates
- AI companion responses
- Achievements
- Weekly reviews

It shows:

- Proof score
- Check-in days
- Active goals
- Average mood
- Average energy
- Focus hours
- Focus sessions
- Active focus days
- Longest session
- English practice minutes
- Quick update count
- AI response count
- Distraction updates
- Recovery/low-energy moments
- Small wins
- AI weekly insight
- Milestones

### Settings

The Settings page includes:

- Profile identity
- Editable name
- Wake-up time
- College start and end time
- Study window
- Sleep time
- Companion notification status
- Privacy and local-first data explanation
- Backup export placeholder

## Local Database

RiseUp uses Isar collections for local storage.

Main stored entities include:

- UserProfile
- Goal
- FocusSession
- MoodLog
- DailyCheckIn
- Reflection
- EnglishPracticeSpeakingLog
- AIConversation
- Message
- ActivityLog
- NotificationHistory
- Achievement
- WeeklyReview

## App Architecture

The project follows a feature-first Flutter architecture.

```text
lib/
  core/
    companion/
    database/
    network/
    notifications/
    router/
    theme/
  features/
    ai_chat/
    companion/
    dashboard/
    goals/
    journal/
    onboarding/
    progress/
    settings/
    wellness/
```

Each feature generally contains:

- models
- providers
- repositories
- ui/screens
- ui/widgets where needed

## Navigation

GoRouter is used for navigation.

Main routes:

- `/home`
- `/onboarding`
- `/check-in`
- `/quick-update`
- `/ai-chat`
- `/journal`
- `/progress`
- `/settings`
- `/focus-timer`
- `/goal-creation`

The Home screen uses bottom navigation for:

- Home
- Chat
- Journal
- Progress
- Settings

## AI Behavior

RiseUp AI should behave like:

- Caring friend
- Personal mentor
- Accountability partner
- Confidence coach

The AI should:

- Never shame the user
- Never guilt the user
- Encourage recovery
- Celebrate small wins
- Promote healthy sleep
- Promote realistic focus
- Suggest small next actions

Example:

```text
User: I spent 20 minutes scrolling Instagram.

RiseUp: Looks like you needed a break. No shame.
Would a quick 10-minute English practice feel manageable before returning?
```

## Running The App

Install dependencies:

```bash
flutter pub get
```

Run on a connected device:

```bash
flutter run
```

Run tests:

```bash
flutter test
```

Build debug APK:

```bash
flutter build apk --debug
```

## Android Notes

The app uses local notifications and scheduled alarms.

Android manifest includes permissions for:

- `POST_NOTIFICATIONS`
- `RECEIVE_BOOT_COMPLETED`
- `SCHEDULE_EXACT_ALARM`

Scheduled notifications use exact scheduling when available and fall back to inexact scheduling if needed.

## Environment

The project expects Gemini API configuration to be available locally. Do not commit real API keys.

The `.env` file is intentionally local and should remain private.

## Current Status

RiseUp is ready for personal daily use and testing.

It is not yet public-release ready. Before publishing, the app still needs:

- Stronger onboarding completion flow
- Proper production migration strategy for Isar schema changes
- More robust error handling
- Real backup/export implementation
- Notification fatigue tracking
- Companion mode UI
- More tests around repositories and providers
- Final app branding and app icon polish

## Product Philosophy

RiseUp is not about perfection.

It is about helping the user recover, continue, and see proof that small efforts are becoming real growth.

The app should always feel like:

```text
You are not behind.
You are building.
One small step still counts.
```
