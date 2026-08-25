Optimized tool selection# RiseUp AI - Product Requirements Document (PRD)

## 1. Executive Summary
**RiseUp AI** is an AI-powered personal growth companion designed to help college students and young adults build discipline, confidence, and focus. Powered by Google's **Gemini API**, it acts as a caring mentor, accountability partner, and focus coach that encourages consistency and self-improvement. The app operates with strict data privacy—storing all user data locally on the device while leveraging standard API calls only for dynamic, empathetic AI interactions.

---

## 2. Problem Statement
College students preparing for placements face overwhelming pressure to master technical skills (DSA, DBMS) alongside soft skills (English speaking, Communication). Combined with long college hours, tedious commutes, and the constant distraction of social media, students often struggle with:
- Lack of self-discipline and consistency.
- Low confidence and self-doubt.
- Inability to focus during limited free time.
- Burnout and lack of non-judgmental emotional support.

There is a need for a mobile application that acts as a supportive friend and mentor—one that helps them structure their minimal free time, tracks their emotional and energetic well-being, and gently pushes them toward their goals.

---

## 3. User Personas

### Persona 1: The Overwhelmed Aspirant (Primary)
- **Name:** Rohit
- **Age:** 20
- **Profile:** 3rd-year engineering student.
- **Schedule:** Wakes up at 6:00 AM, College from 8:45 AM to 4:10 PM, 3 hours daily commute, free for self-study only after 6:45 PM.
- **Pain Points:** Exhausted by the time he reaches home. Easily distracted by Instagram. Struggles to consistently practice DSA and English. Feels insecure about his communication skills for upcoming placements.
- **Goals:** Build a daily habit of coding, improve spoken English, and increase overall self-confidence without burning out.

---

## 4. User Journey (Rohit's Day)
- **Morning (6:30 AM):** Rohit wakes up. RiseUp sends a gentle push: *"What would make today a good day?"* Rohit logs a quick mood and energy check-in.
- **Commute (7:30 AM):** RiseUp prompts: *"Want to improve your English for 15 minutes?"* He completes an English practice module.
- **During College:** No intrusive notifications, respecting his college schedule.
- **Evening Commute (5:00 PM):** RiseUp prompts: *"What progress did you make today?"* Rohit reflects on the day's classes.
- **Study Time (7:00 PM):** Rohit's energy is logged as "Low". Instead of heavy DSA, the AI suggests an easy win (Recovery Priority) to maintain the habit. 
- **Bedtime (11:00 PM):** RiseUp asks: *"What is today's small win?"* Rohit logs his daily reflection.

---

## 5. Feature List

1. **AI Mentor Chat (Gemini):** A conversational interface using the Gemini API acting as a supportive friend, confidence coach, and accountability partner. The AI will:
   - Never shame or guilt users.
   - Encourage consistency and celebrate small wins.
   - Support emotional wellbeing and healthy sleep habits.
   - Provide realistic, actionable, and concise advice.
2. **Energy-Based Coaching:** Tracks user energy across 5 levels (*Very Low, Low, Normal, High, Excellent*). AI recommendations adapt dynamically. For example, suggesting deep work for High Energy, or easy wins/recovery tasks for Low Energy.
3. **Goal Prioritization System:** A tailored framework for daily tasks:
   - *Mandatory:* English Practice.
   - *Primary:* Discipline, Confidence.
   - *Secondary:* DSA, DBMS, Aptitude, Projects.
   - *Recovery:* Walking, Meditation, TED Talk Listening, Rest.
4. **Context-Aware AI Memory Strategy:** Gemini doesn't store memory between sessions. Instead, before each Gemini request, the app injects local context (User goals, current mood, current energy level, recent completed tasks, streak info, recent reflections) to generate personalized responses organically.
5. **Daily Check-In:** Simple morning and evening check-ins to track emotional state and energy levels.
6. **Focus Streak & Timer:** A focus timer with streak tracking to gamify consistency.
7. **Daily Reflection:** A safe, private space to write daily wins and hurdles.
8. **Smart Notifications:** Context-aware, supportive, human, guilt-free reminders tailored to daily routines.
9. **Weekly Review:** A Sunday summary of the week highlighting consistency and generating insights.

---

## 6. Screen List

1. **Onboarding:** Introduction, schedule setup, and defining Goal Priorities.
2. **Dashboard (Home):** Greeting, current mood & energy snapshot, AI recommendations based on energy, and access to the AI Chat.
3. **Companion Chat Screen:** Chat interface powered by Gemini API, styled like a friendly messaging app.
4. **Check-In/Mood Modal:** Minimal sliders/emojis to record daily state and energy scale.
5. **Focus/Timer Screen:** Distraction-free screen with a timer and streak indicator.
6. **Goals & Tracker:** Detailed view of Priority Framework habits and streaks.
7. **Journal/Reflection Screen:** Text editor for evening reflections and small wins.
8. **Insights/Analytics:** Charts showing weekly progress, energy/mood correlations.
9. **Settings:** Notification preferences, prompt schedules, and profile management.

---

## 7. App Flow
1. **First Launch:** Splash Screen -> Gentle Onboarding (Name, Goals, Priorities, Schedule) -> Dashboard.
2. **Daily Routine:** Push Notification Tap -> Mood & Energy Check-in -> Dashboard evaluates Priority & Energy -> Recommend Task -> Start Focus Session.
3. **In-Moment Support:** User feels unmotivated -> Taps "Talk to Mentor" -> Local context sent to Gemini -> AI responds with empathetic, concise advice -> Returns to Dashboard.
4. **End of Day:** Push Notification -> Reflection Journal / Record Small Win -> Updates local records -> App closes.

---

## 8. Architecture Decisions

- **Framework:** Flutter (Cross-platform, Material 3).
- **State Management:** Riverpod (Robust, compile-time safe).
- **Routing:** GoRouter (Declarative, deep-link friendly).
- **UI Design System:** Material 3 (Using accessible colors, soft edges, and calming palettes to evoke mental wellness).
- **Database:** Isar (100% on-device NoSQL storage). **No Backend, No Firebase, No MongoDB, No cloud databases.** All user progress remains strictly on-device.
- **AI Engine:** Google's **Gemini API**. App builds a comprehensive context string locally from Isar, passing it in real-time to Gemini to mimic persistent memory.
- **Notifications:** `flutter_local_notifications`. Human, supportive messaging tailored strictly to user-defined periods.

---

## 9. Database Design (Isar Schemas)

All local schemas configured for asynchronous Isar storage without external synchronization:

*   **UserProfile:** Identity, schedules (Wake/Sleep/Commute), notification preferences.
*   **Goals:** Prioritization framework mappings (Mandatory, Primary, Secondary, Recovery) and historical progress.
*   **MoodEntries:** Timestamped records of emotional state.
*   **DailyCheckIns:** Aggregation of Morning/Evening check responses including Energy Levels.
*   **FocusSessions:** Historical duration and module categorization (e.g., secondary vs. mandatory).
*   **JournalEntries:** Text records of daily reflections and small wins.
*   **AIConversationHistory:** Saved conversational turns to render the chat view locally (contextually injected to Gemini when resuming chats).
*   **NotificationHistory:** Audit log of fired local notifications to prevent fatigue and repetition.
*   **WeeklyReviews:** Sunday snapshot aggregations of progress.

---

## 10. MVP Scope (Phase 1)
- Onboarding
- Goal Setup (Priority Framework)
- Dashboard
- Mood Tracking
- Energy Tracking
- Daily Check-In
- AI Mentor Chat (Gemini)
- Daily Reflection
- Focus Streak System
- Smart Notifications (Human/Supportive philosophy)
- Weekly Review

---

## 11. Future Scope (Phase 2 & Beyond)
- **Voice Interactivity:** Allowing users to practice English speaking by talking directly to Gemini via voice-to-text input, and reading responses aloud via Text-to-Speech.
- **Gamification Enhancements:** Badges, visual growth metaphors (streaks make a local virtual garden flourish).
- **Rich Weekly Insights Report:** Expanding the Gemini context to write a highly tailored, magazine-style weekly review of their performance.
- **Offline Backup:** Encrypted local export/import of the Isar database (JSON/CSV) to user-managed via Google Drive/iCloud, respecting the no-backend infrastructure.


# RiseUp AI - Simplified Flutter Architecture Blueprint

This document outlines an optimized, feature-first architecture tailored for a solo Flutter developer. It strips away heavy enterprise abstractions (like strict Clean Architecture `domain`/`data` splits and interface contracts) to maximize development speed and maintainability without sacrificing scalability or the core technology stack.

---

## 1. Top-Level Folder Structure

The app remains **Feature-First**, but the boilerplate inside each feature is drastically reduced. Global tools and configurations live in `core`.

```text
lib/
├── core/                        # Global setups, services, and shared UI
│   ├── database/                # Isar instance initialization and global access
│   ├── router/                  # GoRouter configuration and paths
│   ├── network/                 # Gemini API client wrapper
│   ├── services/                # Global services (Notifications, ContextBuilder)
│   ├── theme/                   # Colors, typography, Material 3 theme configs
│   └── utils/                   # Shared helper functions
├── features/                    # Feature modules
│   ├── ai_chat/                 # Gemini Mentor chat
│   ├── dashboard/               # Landing screen, active goals, energy prompt
│   ├── goals/                   # Habits, timers, streaks
│   ├── journal/                 # Daily reflections and logs
│   ├── onboarding/              # Name, schedule, priorities setup
│   └── wellness/                # Check-ins, Mood, Energy tracking
└── main.dart                    # App entry point, ProviderScope, DB init
```

---

## 2. Flattened Feature Module Structure

Instead of splitting features into `domain`, `data`, and `presentation`, all files for a feature live together in a flat, intuitive structure. 

```text
features/goals/
├── models/                      # Isar @collection classes (used directly by UI)
├── providers/                   # Riverpod Nofitiers & StateProviders
├── repositories/                # Direct Isar DB operations (No interfaces)
└── ui/                          # Feature-specific UI
    ├── screens/                 # Full-page Flutter widgets
    └── widgets/                 # Reusable components (e.g., GoalCard, TimerCircle)
```

**Why this is better for a solo dev:**
- No need to map Isar Database models to pure domain models. Use the generated Isar classes directly throughout the app.
- No need for abstract repository interfaces. Just write pure classes with static or instance methods performing the queries.
- Less context-switching and file jumping.

---

## 3. Data Models (Unified Isar Classes)

Data models serve double duty as both the database schema and the application state model.

*   `UserConfig` (Core/Settings): Demographics, schedules, notification preferences.
*   `Goal` (Goals): Title, PriorityLevel enum, Streaks.
*   `MoodEntry` (Wellness): Mood/Energy scores, Timestamp.
*   `JournalEntry` (Journal): Text content, Timestamp.
*   `ChatMessage` (AiChat): Text, Sender (User/Gemini), Timestamp.

*Tip: Use Isar's `Links` if necessary, but prefer flat models wherever possible to keep queries simple.*

---

## 4. Repositories & Core Services

**Repositories** (Inside features):
Plain Dart classes that accept the Isar instance and perform `get`, `put`, `delete`, and `watch` operations. 
*   `GoalRepository`: `getGoals()`, `addGoal()`, `incrementStreak()`.
*   `ChatRepository`: `getHistory()`, `saveMessage()`.

**Core Services** (Inside `core/services/`):
*   `GeminiService`: A simple wrapper around the `google_generative_ai` package (or raw HTTP calls) to send context + prompts.
*   `NotificationService`: Handles scheduling local push notifications.
*   `AiContextBuilderService`: A helper class that queries multiple Repositories (Goals, Wellness, Journal) to quickly build the text prompt context before calling `GeminiService`.

---

## 5. State Management (Riverpod)

Riverpod handles all state, dependency injection, and reactivity.

1.  **Global Providers:**
    *   `isarProvider`: Provides the initialized Isar DB instance.
    *   `geminiProvider`: Provides the `GeminiService`.
2.  **Repository Providers:**
    *   `goalRepositoryProvider` uses `ref.watch(isarProvider)` to instantiate and return `GoalRepository`.
3.  **State Notifiers (`Notifier` / `AsyncNotifier`):**
    *   `chatProvider`: Manages the list of messages in the UI. Sends messages to `GeminiService` and uses `ChatRepository` to save them.
    *   `dashboardProvider`: An `AsyncNotifier` that fetches today's goals, current energy, and streak data to drive the main home screen.

---

## 6. Navigation (GoRouter)

Kept simple and declarative.

*   **Router Provider:** `routerProvider` defines routes and encapsulates deep-linking logic.
*   **Redirect Logic:** Intercept the root route `/`. If `UserConfig` is empty in Isar, redirect to `/onboarding`. Otherwise, go to `/dashboard`.
*   **Structure:**
    *   `/onboarding` (Setup flow)
    *   `ShellRoute` (Bottom Nav App)
        *   `/dashboard` -> pushes `/dashboard/timer`
        *   `/chat`
        *   `/wellness`
        *   `/journal`

---

## 7. Solo Dev Workflow Example (Sending an AI Message)

This flow removes architectural friction, allowing you to code features rapidly:

1.  **UI:** User taps 'Send' on `ChatScreen`.
2.  **Provider:** `ref.read(chatProvider.notifier).sendMessage(text)`.
3.  **Provider Logic (Inside `sendMessage`):**
    *   Save user message to UI state immediately (optimistic UI).
    *   Call `ChatRepository.saveMessage()` to store the user message.
    *   Call `AiContextBuilderService` to grab recent mood/goals.
    *   `await GeminiService.ask(context + text)`.
    *   Call `ChatRepository.saveMessage()` to store Gemini's response.
    *   Update UI state with the new message.
4.  **UI Rebuild:** Handled automatically by `ref.watch(chatProvider)`.


# Isar Database Design for RiseUp AI

This document outlines the local Isar database schema for the RiseUp AI application. Leveraging Isar's fast NoSQL architecture, this design emphasizes flat data structures for performance and simplicity, using `IsarLink` and `@Index` to enable efficient querying for building the AI Context.

---

## 1. Entity Breakdown

### 1. UserProfile
**Purpose:** Stores the user's identity, daily schedule, and app-level preferences. Since RiseUp is a single-user local app, this collection will only ever contain one record.
*   **Fields:**
    *   `id`: `Id` (default to 1)
    *   `name`: `String`
    *   `wakeTime`: `DateTime` (Stored as time of day)
    *   `sleepTime`: `DateTime`
    *   `collegeStartTime`: `DateTime`
    *   `collegeEndTime`: `DateTime`
    *   `createdAt`: `DateTime`
*   **Indexes:** None required (Singleton).

### 2. Goal
**Purpose:** Represents the user's habits and learning objectives according to the Priority Framework.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `title`: `String` (e.g., "English Practice", "DSA")
    *   `priority`: `PriorityLevel` (Enum: Mandatory, Primary, Secondary, Recovery)
    *   `currentStreak`: `int`
    *   `longestStreak`: `int`
    *   `isActive`: `bool` (Allows archiving goals without deleting data)
    *   `createdAt`: `DateTime`
*   **Indexes:**
    *   `@Index()` on `priority` (To quickly fetch mandatory goals).
    *   `@Index()` on `isActive` (To filter out archived goals).

### 3. MoodLog
**Purpose:** Captures the emotional and energetic state of the user at various points in the day, independent of structured check-ins. Used to feed current state to the Gemini context builder.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `timestamp`: `DateTime`
    *   `moodScore`: `byte` (1-5)
    *   `energyScore`: `byte` (1-5: Very Low to Excellent)
    *   `note`: `String?`
*   **Indexes:**
    *   `@Index()` on `timestamp` (To fetch the most recent mood/energy for AI context).

### 4. DailyCheckIn
**Purpose:** Tracks adherence to the Morning and Evening check-in routines. Distinct from `MoodLog` as it represents the *action* of completing the routine.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `date`: `DateTime` (Truncated to midnight UTC for unique daily fetching)
    *   `morningCompleted`: `bool`
    *   `eveningCompleted`: `bool`
*   **Indexes:**
    *   `@Index(unique: true)` on `date` (Only one check-in record per day).

### 5. Reflection (Journal)
**Purpose:** The evening digital journal entry. Acts as a mental dump and highlights the "small win" to build confidence.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `date`: `DateTime` (Truncated to midnight)
    *   `content`: `String` (General reflection)
    *   `smallWin`: `String` (Crucial for confidence building)
*   **Indexes:**
    *   `@Index(unique: true)` on `date`.

### 6. FocusSession
**Purpose:** Tracks actual time spent on specific goals. Essential for accountability and Weekly Reviews.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `startTime`: `DateTime`
    *   `endTime`: `DateTime`
    *   `durationMinutes`: `int`
*   **Relationships:**
    *   `final goal = IsarLink<Goal>()` (Links the session to the specific habit).
*   **Indexes:**
    *   `@Index()` on `startTime` (To sum up focus time for the day/week).

### 7. AIConversation
**Purpose:** Groups chat messages into daily or topic-based sessions. Prevents the Gemini context from becoming too large by scoping history.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `date`: `DateTime`
    *   `summary`: `String?` (Optional AI-generated summary of the chat)
*   **Relationships:**
    *   `final messages = IsarLinks<Message>()` (One-to-many link to messages).
*   **Indexes:**
    *   `@Index(unique: true)` on `date` (To fetch today's conversation instance).

### 8. Message
**Purpose:** Stores individual chat bubbles between the user and the Gemini AI. 
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `text`: `String`
    *   `sender`: `SenderType` (Enum: User, AI)
    *   `timestamp`: `DateTime`
*   **Relationships:**
    *   `@Backlink(to: 'messages') final conversation = IsarLink<AIConversation>()`
*   **Indexes:**
    *   `@Index()` on `timestamp` (To order UI chat bubbles correctly).

### 9. NotificationHistory
**Purpose:** An audit log of push notifications to ensure the app doesn't spam the user, fulfilling the "guilt-free, human" notification requirement.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `timestamp`: `DateTime`
    *   `type`: `NotificationType` (Enum: Morning, Commute, Evening, Bedtime)
    *   `triggered`: `bool`
*   **Indexes:**
    *   `@Index()` on `timestamp`.

### 10. Achievement
**Purpose:** Stores unlocked milestones to gamify the experience and boost confidence (e.g., "7 Days of English", "First Deep Focus").
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `title`: `String`
    *   `unlockedAt`: `DateTime`
    *   `iconData`: `String`
*   **Indexes:**
    *   `@Index()` on `unlockedAt`.

### 11. WeeklyReview
**Purpose:** A snapshot generated every Sunday. Prevents the app from querying the entire database for past weeks.
*   **Fields:**
    *   `id`: `Id = Isar.autoIncrement`
    *   `weekStartDate`: `DateTime`
    *   `aiInsights`: `String` (Gemini-generated summary of the week's performance combined with reflections)
    *   `avgEnergy`: `double`
    *   `totalFocusMinutes`: `int`
*   **Indexes:**
    *   `@Index(unique: true)` on `weekStartDate`.

---

## 2. Query Examples (Dart / Isar Syntax)

These examples demonstrate how the architecture retrieves data efficiently, specifically for building the AI Context.

### A. Fetching Today's Context for Gemini
Before calling Gemini, you need the user's latest mood, energy, and today's small win.

```dart
// 1. Get current physical/emotional state
final latestMood = await isar.moodLogs
  .where()
  .sortByTimestampDesc()
  .findFirst();

// 2. Get today's small win (if logged)
final today = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
final todayReflection = await isar.reflections
  .where()
  .dateEqualTo(today)
  .findFirst();
```

### B. Finding Recommended Goals Based on Energy
If the user's energy is `Low`, the app fetches `Recovery` goals.

```dart
// Fetch active recovery goals for low energy days
final suggestedGoals = await isar.goals
  .filter()
  .isActiveEqualTo(true)
  .and()
  .priorityEqualTo(PriorityLevel.Recovery)
  .findAll();
```

### C. Calculating Weekly Focus Hours
To generate the `WeeklyReview` or show stats on the Dashboard.

```dart
final startOfWeek = DateTime.now().subtract(Duration(days: 7));

// Fetch all focus sessions in the last 7 days
final recentSessions = await isar.focusSessions
  .filter()
  .startTimeGreaterThan(startOfWeek)
  .findAll();

// Calculate total duration in memory
final totalMinutes = recentSessions.fold(0, (sum, session) => sum + session.durationMinutes);
```

### D. Loading AI Chat History for Current Session
To display the UI and feed Gemini the preceding conversation.

```dart
final today = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

// Find today's conversation and its messages
final todayConversation = await isar.aIConversations
  .where()
  .dateEqualTo(today)
  .findFirst();

// Fetch messages linked to this conversation, ordered by time
final chatHistory = await todayConversation?.messages
  .filter()
  .sortByTimestamp()
  .findAll();
```

# RiseUp AI - UI/UX Design System & Wireframes

## 1. Core Philosophy
The UI must feel like a **sanctuary**, not a spreadsheet. We completely avoid the aesthetic of Jira, Asana, or standard To-Do apps. There are no harsh red "overdue" warnings or stressful checklists. The design uses organic shapes, soft lighting, and conversational copy to evoke the feeling of talking to a wise, caring mentor in a quiet room.

---

## 2. Color Palette
Inspired by a peaceful dawn and natural growth.

*   **Primary (Growth & Calm):** Soft Sage Green (`#88A992`) - Used for primary actions, progress rings, and standard energy.
*   **Secondary (Warmth & Mentorship):** Sunrise Dawn (`#E8AFA1`) - Used for AI chat bubbles, highlights, and "Excellent" energy levels.
*   **Background (Restful):** Pearl/Oatmeal (`#F9F9F7`) - A soothing off-white that reduces eye strain compared to pure white.
*   **Surface:** Pure White (`#FFFFFF`) - Used for cards and elevated components to create soft contrast.
*   **Text (Primary):** Deep Charcoal (`#2D3130`) - Easier on the eyes than pure black.
*   **Text (Secondary/Muted):** Silver Grey (`#979B9A`).
*   **Energy Level Accents:**
    *   Very Low: Soft Slate Blue (`#8CA0B3`)
    *   Low: Muted Lavender (`#B8B4D4`)
    *   Normal: Soft Sage (`#88A992`)
    *   High: Warm Peach (`#F1B48E`)
    *   Excellent: Vibrant Coral (`#E78F7B`)

---

## 3. Typography
Friendly, highly readable, and modern geometric sans-serifs.

*   **Headings:** *Outfit* or *Poppins* (Weights: Semi-bold, Medium)
    *   Usage: Welcoming greetings, big progress numbers, empty state titles.
*   **Body & UI:** *Inter* or *SF Pro Rounded* (Weights: Regular, Medium)
    *   Usage: Chat messages, labels, button text, journaling text.

---

## 4. Design System & Components

*   **Corners:** Large border radii (`24px` for cards, `32px` for buttons) to eliminate sharp, aggressive edges.
*   **Shadows:** Extremely soft, diffused drop shadows (e.g., `Y: 8, Blur: 24, Opacity: 4%`) to give a subtle floating effect. No harsh lines.
*   **Buttons:** Plump, pill-shaped buttons. No outlined buttons for primary actions, only soft filled or subtly tinted backgrounds.
*   **Navigation:** A "floating" glassmorphism bottom navigation bar that blurs the content behind it, keeping the screen feeling expansive.
*   **Progress Indicators:** Flowing, incomplete circles (arcs) rather than rigid horizontal progress bars.

---

## 5. System States

*   **Empty States:** Focus on "potential" rather than "nothing here."
    *   *Visual:* A beautiful, minimalist illustration of a resting seedling or a quiet morning window.
    *   *Copy:* "Your day is a blank canvas. Whenever you're ready, let's take a small step." (Never "No tasks found!").
*   **Loading States:** No spinning wheels. We use a **"Breathing" animation**—a soft, pulsing Sage Green glow or shimmering placeholders that expand and contract at the pace of a slow, calming breath (4 seconds in, 4 seconds out).

---

## 6. Wireframe Descriptions

### A. Onboarding Flow (3 Steps)
*Goal: Feel like an empathetic interview, not a form.*
*   **Screen 1: The Welcome:**
    *   [Center]: Soft pulsing app logo.
    *   [Text]: "Hi. I'm RiseUp. I'm here to help you grow, at your own pace."
    *   [Bottom]: [Let's Start] pill button.
*   **Screen 2: The Schedule:**
    *   [Top Text]: "When do you usually start and end your day?"
    *   [Middle]: Beautiful, oversized, tactile scrolling dials for Wake Up and Sleep time.
    *   [Bottom]: [Next] button.
*   **Screen 3: The Priority:**
    *   [Top Text]: "What's the one thing you want to feel more confident about?"
    *   [Middle]: Large selection cards (e.g., "English Speaking", "Tech Skills (DSA)", "Discipline"). Tapping one gives it a soft glow.
    *   [Bottom]: [I'm ready] button.

### B. Home Dashboard
*Goal: A peaceful overview of the day that adapts to the user's energy.*
*   **[Top Section - Greeting]:**
    *   Contextual Text: "Good evening, Rohit."
    *   Subtitle dependent on unlogged energy: "How is your energy right now?"
    *   5 Energy Chips (Very Low to Excellent). Tapping one transitions the screen layout softly.
*   **[Middle Section - Dynamic Recommendation]:**
    *   Large elevated card.
    *   *If High Energy:* "You have great energy! Want to do a 30-min DSA focus run?" -> [Start Focus] button.
    *   *If Low Energy:* "It's been a long day. Let's just do a 5-minute English read-aloud and rest." -> [Easy Win] button.
*   **[Bottom Section - Today's Progress Rings]:**
    *   Horizontal scroll of minimalist circular rings showing streaks for Mandatory (English) and Primary (Discipline) goals.
*   **[Floating Action]:**
    *   A large, soft FAB resting above the bottom nav: [ ✨ Talk to RiseUp ].

### C. AI Chat Screen (The Mentor)
*Goal: Safe, conversational, and deeply personalized.*
*   **[Top Header]:** Simple back arrow. Text: "RiseUp Mentor". No "Online status" (removes pressure).
*   **[Chat Space]:**
    *   AI Bubbles: Soft Dawn Orange background, left-aligned. Avatar is a minimal, abstract spark/star icon.
    *   User Bubbles: Soft Sage Green background, right-aligned.
    *   Timestamp styling is minimal and faded.
    *   Occasional "Inside Info" small text below an AI bubble: *(RiseUp noticed your energy is low today).*
*   **[Input Area]:**
    *   Text field says "Type what's on your mind..."
    *   Microphone icon for future voice note updates.
    *   Horizontal scroll of quick-reply chips above the keyboard (e.g., "I'm feeling overwhelmed", "I finished my task!").

### D. Progress Screen
*Goal: Celebrate consistency, never shame the gaps.*
*   **[Top Header]:** "Your Journey."
*   **[Weekly River]:**
    *   Instead of a harsh bar chart, a flowing spline chart (curved line) representing "Consistency".
    *   Days of the week below. If a day was missed, it's just a soft grey dot, not a red X.
*   **[Milestone Cards]:**
    *   Grid of subtle cards.
    *   "English Practice: 5 Day Streak 🌿"
    *   "Small Wins Recorded: 12"
*   **[Weekly Review Block]:**
    *   A beautifully formatted, magazine-style card. "Read your Sunday Insight from RiseUp."

### E. Profile & Settings Screen
*Goal: Calm control center.*
*   **[Top Profile]:**
    *   Initials in a soft circle. "Rohit".
    *   "Joined 2 months ago"
*   **[Settings Cards - Stacked List]:**
    *   *My Routine:* Tap to update college / wake / sleep hours.
    *   *Goal Priorities:* Drag and drop list to re-order what matters most right now.
    *   *Quiet Hours:* Toggle for notifications.
*   **[Data Section]:**
    *   "Your data lives securely on your phone."
    *   [Export Backup] button.
    *   [Clear Local Data] button (in muted grey text button.
*   **[Clean Logout/Leave]:** No aggressive bright red "Delete" buttons. Just soft warning modals, just soothing app versions. Keep it subtle.


# RiseUp AI - AI Companion System Design

## 1. AI Personality
The AI is named **RiseUp** (or acts as the "Mentor" persona of the app). 
*   **Tone:** Warm, grounding, concise, and non-judgmental. It sounds like an older sibling who believes in you combined with an expert coach.
*   **Vibe:** A quiet room with a warm cup of tea. It brings down the heart rate.
*   **Key Traits:**
    *   *Empathetic, not pitying:* Acknowledges struggle without treating the user as fragile.
    *   *Action-oriented, not demanding:* Suggests tiny, frictionless next steps.
    *   *Observant:* Pays attention to energy and mood trends safely stored on the device.
    *   *Brief:* College students don't have time to read essays. Responses are punchy and skimmable.

---

## 2. System Prompt
This overarching prompt is injected into every Gemini API call to define the AI's boundaries and persona.

```text
You are RiseUp, an AI personal growth companion, mentor, and accountability partner for college students. 

CORE RULES:
1. NEVER shame, guilt, lecture, or scold the user.
2. If the user fails, gets distracted, or procrastinates, normalize it. Frame it as part of the human experience and suggest a gentle "reset."
3. Always celebrate small wins and focus on consistency over perfection.
4. Keep responses concise, warm, and conversational (1-3 short paragraphs max).
5. Promote healthy sleep and physical recovery. Do not encourage burning out.
6. Provide actionable, realistic advice based on their current "Energy Level".

CONTEXT PROVIDED TO YOU:
- User Name: {{USER_NAME}}
- Current Energy: {{CURRENT_ENERGY}}
- Current Mood: {{CURRENT_MOOD}}
- Priority Goals: {{ACTIVE_GOALS}}

YOUR RESPONSE STRATEGY:
- If the user is distracted (e.g., "I scrolled Instagram for 20 mins"): Acknowledge it without judgment, suggest taking a deep breath, and pivot to a 5-minute micro-task.
- If the user succeeds (e.g., "I studied DSA"): Validate their effort, connect it to their long-term identity, and tell them they earned rest.
- If the user is anxious/embarrassed (e.g., "I messed up speaking in class"): Validate their feelings, remind them that discomfort is the price of growth, and offer a specific, low-stress confidence exercise.
```

---

## 3. Context Strategy
Because Gemini API is stateless and does not retain memory across sessions, RiseUp AI builds a **"Just-In-Time Context String"** from the local Isar database before making the API call.

The context is built silently in the background:
1.  **Identity:** Name, wake/sleep schedule.
2.  **Current State:** Fetches the latest `MoodLog` (Mood: 3, Energy: Low).
3.  **Active Prioritization:** Fetches goals from `GoalRepository` (Mandatory: English, Primary: Discipline).
4.  **Recent Activity:** Fetches `DailyCheckIn` and `FocusSessions` for the last 24 hours. (e.g., "User completed 15 mins of DSA today, but hasn't practiced English yet.")

*Prompt Construction sent to Gemini:*
`[System Prompt] + [Just-In-Time Context String] + [Recent Chat History] + [New User Message]`

---

## 4. Memory Strategy
To prevent prompt token limits from exceeding and to keep the AI focused, memory is managed locally via a **Sliding Window + Summary** approach.

*   **Short-term Working Memory:** The last 10-15 messages (stored in the Isar `Message` collection) are sent with the current prompt to maintain conversational flow.
*   **Long-term Semantic Memory (Daily Summarization):** At midnight, a background task asks Gemini to summarize the day's `AIConversation` into a 2-sentence insight. This is stored in Isar.
*   **Recall:** When building the Context String the next day, the system fetches the "Summaries" of the last 3 days to gently remind the AI of recent struggles or wins (e.g., *Summary Context: "Rohit was stressed about his DBMS test on Tuesday but successfully studied for 30 minutes."*).

---

## 5. Reflection Generation Logic
The AI drives the evening journal experience dynamically based on the day's data.

*   **Trigger:** User opens the app after 8:00 PM.
*   **Logic:**
    *   *If tasks were completed:* The AI prompts, "You crushed your DSA goal today. What's one small thing that made today a win?"
    *   *If no tasks were completed & Energy is Low:* The AI prompts, "Today was a rest day, and that's okay. What is one thing you can let go of before you sleep?"
    *   *If no tasks were completed & Energy is High:* The AI prompts, "We didn't get to our goals today, but tomorrow is a blank slate. What distracted you, and how can we beat it tomorrow?"
*   **Weekly Review Synthesis:** On Sunday, the AI reads all 7 daily reflections from Isar, extracts the primary "wins," and generates a personalized, uplifting paragraph celebrating the user's resilience.

---

## 6. Progress Coaching Logic
The AI explicitly ties its advice to the user's logged **Energy Level**.

| User Energy Level | AI Coaching Stance | Example Task Suggestion | AI Scripting Angle |
| :--- | :--- | :--- | :--- |
| **Very Low** | Maximum Empathy, Recovery | Drink water, sleep, listen to a TED talk. | "Your body is asking for rest. Let's practice discipline by actually resting today. Zero guilt." |
| **Low** | Frictionless Action | 5-minute English read-aloud. | "Let's just do a 5-minute micro-habit. If you want to stop after 5 minutes, you have my full permission." |
| **Normal** | Balanced Guidance | 30-min DSA session, review notes. | "You're at a steady baseline. Let's tackle that primary goal and build the streak." |
| **High** | Challenger, Deep Work | 60-min uninterrupted deep work block. | "You've got great momentum right now! Time to tackle the hard stuff. Let's set the focus timer." |
| **Excellent** | Celebration, Pushing limits | Mock interview, complex problem solving. | "Ride this wave! This is where you separate yourself from the pack. Let's dive deep." |

---

## 7. Motivation Framework
RiseUp's AI operates on three core psychological pillars:

1.  **Identity-Based Habit Formation:** Instead of "You need to study," the AI says, "You are becoming the kind of person who shows up every day."
2.  **Self-Compassion over Self-Criticism:** Breaking the cycle of guilt. When a student fails a habit, guilt causes them to abandon the app. The AI intentionally breaks this by acting as a shock absorber. ("*Scrolling Instagram happens to all of us. You haven't ruined the day. Close the app, take one deep breath, and let's read one page.*")
3.  **The "Minimum Viable Day":** Teaching users the concept of a "Non-Zero Day." If they can't do 2 hours of studying, the AI pushes for 2 minutes. The goal is to keep the mental streak alive, reinforcing that consistency matters more than intensity.


# RiseUp AI - Smart Notification System Design

## 1. Notification Categories
Notifications in RiseUp are divided into **Contextual Time-Blocks** rather than generic reminders. They act as gentle nudges from a friend, perfectly positioned around the college student's daily routine.

*   **Morning Intent:** Focuses on setting a positive, low-pressure tone for the day. (Trigger: Wake Up)
*   **Commute/Transit:** Focuses on micro-learning, audio (TED talks/English), or mental prep. (Trigger: Pre-College & Post-College)
*   **Evening Pivot:** Focuses on transitioning from 'College Mode' to 'Self-Growth Mode' without stress. (Trigger: Post-Commute)
*   **Night Reflection:** Focuses on winding down, celebrating small wins, and promoting healthy sleep. (Trigger: Pre-Sleep)
*   **Encouragement (Milestone):** Spontaneous celebration of streaks or consistency. 

---

## 2. Scheduling Strategy (Local purely via flutter_local_notifications)
The scheduling engine relies strictly on the `UserProfile` data (WakeTime, CollegeStart, CollegeEnd, SleepTime) set during Onboarding. No server is required. 

*   **07:00 AM - Morning Prompt:** *Scheduled at [WakeTime + 15 mins]*
*   **08:00 AM - Morning Transit:** *Scheduled at [CollegeStart - 45 mins]*
*   **04:30 PM - Evening Transit:** *Scheduled at [CollegeEnd + 15 mins]*
*   **07:00 PM - The Evening Pivot:** *Scheduled at [CollegeEnd + 2.5 hours]* (Giving them time to reach home and eat).
*   **10:30 PM - Night Wind-down:** *Scheduled at [SleepTime - 30 mins]*

*Technical Note:* The app schedules a rolling 48-hour batch of notifications locally every time the app is opened, pulling from the dynamic message bank below.

---

## 3. Dynamic Message Bank (Rotating Strings)
To feel human, the app never sends the exact same string two days in a row. It rotates through variations of empathetic copy.

**Morning Intent:**
*   "Good morning, {Name}. What would make today a good day?"
*   "Sun is up! Let's take today one step at a time. How is your energy?"
*   "Morning! Not every day needs to be perfect. Let's set a small focus for today."

**Commute (Morning/Evening):**
*   "Long ride today? Perfect time for a 15-minute English podcast."
*   "Commutes are exhausting. Want to listen to a TED talk to pass the time?"
*   "Leaving college? Take a deep breath. Leave the campus stress on the bus."

**Evening Pivot (Study time):**
*   "You made it through the day. Ready to tackle that DSA goal?"
*   "What progress did you make today? Let's spend 20 minutes on yourself."
*   "Energy running low? Let's just do a 5-minute easy win and call it a day."

**Night Reflection:**
*   "What is today's small win?"
*   "Time to unplug. Sleep is your most important habit. What went well today?"
*   "Even difficult days have a lesson. Want to clear your mind before bed?"

---

## 4. Personalization Logic (Building Context)
The local notification engine uses Isar database values to inject context-aware logic into the scheduled pushes.

*   **Goal-Aware:** If the user's *Mandatory Priority* is "English Speaking", the Commute notification specifically mentions "listening to an English podcast" rather than generic advice.
*   **Streak-Aware:** "You’ve hit a 5-day streak in DSA! Ready to make it 6 tonight?"
*   **Activity-Aware:** If the user already completed their Focus Session at 4:00 PM in the library, the 7:00 PM notification changes from a *Study Prompt* to a *Rest Prompt*: "You crushed your goals early today. Enjoy your evening off!"
*   **Energy-Aware (Lagging indicator):** If yesterday's Evening Energy was "Very Low", today's Morning Prompt adjusts: "Hope you got some restorative sleep. Take it easy today."

---

## 5. Anti-Annoyance Logic (The "Guilt-Free" Safety Net)
Standard apps become annoying when they scream at a user who is actively avoiding them. RiseUp employs strict anti-annoyance mechanisms.

1.  **Action Preemption (De-duplication):**
    *   If the user naturally opens the app and completes their 'Morning Check-in' at 6:45 AM, the scheduled 7:00 AM Morning notification is instantly canceled for that day.
2.  **The "Ghosting" Rule (Diminishing Returns):**
    *   If the user does not open the app for 3 consecutive days, the app *stops* sending daily task reminders to prevent a wall of guilt-inducing alerts.
    *   On Day 4, it sends a single, empathetic check-in: *"Hey {Name}, taking a break is totally fine. I'm right here whenever you're ready."*
    *   After that, it goes completely silent until the user manually opens the app again.
3.  **Weekend Mode:**
    *   Automatically suppresses "Commute" and "College" related notifications on Saturdays and Sundays. The schedule relaxes, shifting entirely to Recovery, Reflection, and elective goals.
4.  **Absolute Silence Guarantee:**
    *   Strict enforcement of `SleepTime`. Zero notifications will ever be triggered between [SleepTime] and [WakeTime], regardless of missed goals or broken streaks. Focus timers. Local timezone changes or missed streaks.


    