# SIH Project — MVP Bug Fixes & Feature Roadmap

> **Repository:** [pilot32/sih_project](https://github.com/pilot32/sih_project)
> **App Name:** Nabha Digital Education
> **Framework:** Flutter (Dart SDK ^3.8.1) | **Backend:** Firebase (project: `edutivflutter`)
> **Goal:** Get the app to a **basic-tier working condition** — not production-ready, but functional enough to demonstrate login, dashboard, subject browsing, and lesson viewing.

---

## Table of Contents

1. [Current State Summary](#1-current-state-summary)
2. [Bug Fixes](#2-bug-fixes)
   - [CRITICAL — App Won't Build / Run](#21-critical--app-wont-build--run)
   - [HIGH — Logic Errors & Broken Features](#22-high--logic-errors--broken-features)
   - [MEDIUM — Code Quality & Clean-up](#23-medium--code-quality--clean-up)
   - [LOW — Nice-to-Have Clean-up](#24-low--nice-to-have-clean-up)
3. [Feature Implementation (Basic MVP)](#3-feature-implementation-basic-mvp)
   - [P0 — Must-Have for Demo](#31-p0--must-have-for-demo)
   - [P1 — Should-Have for Basic Use](#32-p1--should-have-for-basic-use)
4. [Suggested Dependency Additions](#4-suggested-dependency-additions)
5. [Implementation Order (Step-by-Step)](#5-implementation-order-step-by-step)

---

## 1. Current State Summary

### What Works
- Login screen UI renders (Student + Teacher tabs, form validation, branding)
- Student dashboard UI renders (stats card, subject grid, quick actions)
- Firebase Core initializes
- Responsive grid layouts for subjects
- Custom widget library (buttons, cards, progress bars, badges)

### What Doesn't Work
- Login does **not authenticate** — any input bypasses login
- Teacher login navigates to **student dashboard** (same screen)
- All dashboard data is **hardcoded** — no persistence
- Tapping "Continue" on subject cards **does nothing**
- Quick action buttons (Today's Lesson, Practice, Rewards) **do nothing**
- Settings screen is a **placeholder** (just text)
- `flutter_riverpod` is declared but **never used**
- 3 files are **completely empty** (1 of which is imported)
- The **stale test file** will fail `flutter test`

### File Inventory (28 Dart files)

| File | Lines | Status |
|---|---|---|
| `lib/main.dart` | 33 | OK |
| `lib/firebase_options.dart` | ~200 | OK (API keys exposed in public repo) |
| `lib/core/routes.dart` | 21 | OK (missing teacher route) |
| `lib/core/theme/app_theme.dart` | 207 | OK (darkTheme unused) |
| `lib/core/constants/app_colors.dart` | 61 | OK |
| `lib/core/constants/app_strings.dart` | 48 | OK |
| `lib/core/constants/app_dimensions.dart` | 45 | OK |
| `lib/data/models/subject_model.dart` | 49 | OK |
| `lib/data/models/subjects_section.dart` | 102 | **DUPLICATE** of `lib/widgets/subjects_section.dart` |
| `lib/screens/auth/login_page2.dart` | 453 | Has bugs (see below) |
| `lib/screens/student_dashboard_screen.dart` | 256 | Has bugs (see below) |
| `lib/screens/homescreen/student_dashboard.dart` | 815 | **OLD PROTOTYPE** — not in routes, uses NetworkImage |
| `lib/screens/settings_screen.dart` | 23 | **PLACEHOLDER** |
| `lib/presentation/pages/student_dashboard_page.dart` | 1 | **EMPTY FILE** |
| `lib/widgets/dashboard_header.dart` | 109 | OK |
| `lib/widgets/hero_stats_card.dart` | 128 | OK |
| `lib/widgets/subjects_section.dart` | 100 | OK (primary version) |
| `lib/widgets/quick_actions_section.dart` | 148 | OK |
| `lib/widgets/quick_action_button.dart` | 1 | **EMPTY FILE** (imported by dashboard!) |
| `lib/widgets/learning_card.dart` | 179 | OK |
| `lib/widgets/progress_indicator.dart` | 23 | OK (uses `percent_indicator`) |
| `lib/widgets/ui/custom_button.dart` | 252 | OK |
| `lib/widgets/ui/custom_badge.dart` | 134 | OK |
| `lib/widgets/ui/custom_card.dart` | 126 | OK |
| `lib/widgets/ui/custom_progress.dart` | 142 | OK |
| `lib/widgets/ui/custom_avatar.dart` | 1 | **EMPTY FILE** |
| `lib/cardsView/courseCard.dart` | 102 | **UNUSED** |
| `lib/cardsView/subjectCard.dart` | 105 | **UNUSED** |
| `lib/cardsView/categoryCard.dart` | 65 | **UNUSED** |

---

## 2. Bug Fixes

### 2.1 CRITICAL — App Won't Build / Run

#### BUG-01: Empty `quick_action_button.dart` is imported by the active dashboard
- **File:** `lib/widgets/quick_action_button.dart`
- **Problem:** File is **completely empty** (1 blank line) but is imported at line 2 of `lib/screens/student_dashboard_screen.dart`:
  ```dart
  import 'package:digital_learning_application/widgets/quick_action_button.dart';
  ```
  The import itself won't crash (unused import is a warning, not an error), but the file was clearly intended to hold a widget. The actual quick action buttons are built inline inside `quick_actions_section.dart`, so this import is dead.
- **Fix:** Either populate the file with the `_QuickActionButton` widget extracted from `quick_actions_section.dart`, or **remove the import** from `student_dashboard_screen.dart` line 2.

#### BUG-02: Duplicate `SubjectsSection` class in two files with different constructors
- **File 1:** `lib/widgets/subjects_section.dart` — parameter named `badgeText`
- **File 2:** `lib/data/models/subjects_section.dart` — parameter named `badge`
- **Problem:** Both define `class SubjectsSection` with **different constructor signatures**. If both are ever imported in the same file, Dart will throw a **duplicate class name error**. The version in `data/models/` is also architecturally wrong — a widget has no business in the data layer.
- **Fix:** **Delete** `lib/data/models/subjects_section.dart` entirely. Only the `lib/widgets/` version is used by the active dashboard.

#### BUG-03: Missing `INTERNET` permission in AndroidManifest.xml
- **File:** `android/app/src/main/AndroidManifest.xml`
- **Problem:** No `<uses-permission android:name="android.permission.INTERNET"/>` declaration. The old prototype dashboard (`homescreen/student_dashboard.dart`) uses `NetworkImage` to load images from Unsplash URLs. Even though this old file isn't in active routes, any Firebase call will also need internet.
- **Fix:** Add before `<application>` tag:
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```

#### BUG-04: `AnimatedBuilder` widget does not exist in Flutter
- **File:** `lib/widgets/ui/custom_progress.dart` line 74
- **Problem:** Uses `AnimatedBuilder` which is **not a valid Flutter class**. The correct widget is `AnimatedBuilder`. Wait — actually `AnimatedBuilder` is valid in Flutter. Let me re-verify: the correct class name is `AnimatedBuilder`. **After careful verification: `AnimatedBuilder` IS a valid Flutter widget** that takes `animation` and `builder` parameters. This is NOT a bug.
- **Status:** NOT A BUG (verified `AnimatedBuilder` is correct Flutter API).

---

### 2.2 HIGH — Logic Errors & Broken Features

#### BUG-05: Login does not authenticate — zero security
- **File:** `lib/screens/auth/login_page2.dart` lines 40-51
- **Problem:** The `_handleLogin()` method only shows a SnackBar and navigates to dashboard. No credential check, no Firebase Auth call, no API call. Anyone can enter anything and get in.
  ```dart
  void _handleLogin(String userType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$userType Login successful!'), backgroundColor: Colors.green),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
  }
  ```
- **Fix for MVP:** At minimum, store the entered name and pass it to the dashboard so the greeting shows the actual user name. For a real basic tier, implement Firebase Phone Auth OTP verification.
  ```dart
  // MVP quick-fix: pass name to dashboard
  Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: {
    'name': _studentNameController.text,
    'role': userType,
  });
  ```

#### BUG-06: Student name is hardcoded to "Student" — login input is ignored
- **File:** `lib/core/routes.dart` line 14
- **Problem:** The dashboard is created with no arguments, so it always defaults to `studentName = 'Student'`:
  ```dart
  dashboard: (context) => StudentDashboardScreen(
    onLogout: () => Navigator.pushReplacementNamed(context, login),
    onSettings: () => Navigator.pushNamed(context, settings),
  ),
  ```
  The login form collects the user's name but **never passes it forward**.
- **Fix:** Pass the name from login:
  ```dart
  // In routes.dart
  dashboard: (context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return StudentDashboardScreen(
      studentName: args?['name'] ?? 'Student',
      role: args?['role'] ?? 'student',
      onLogout: () => Navigator.pushReplacementNamed(context, login),
      onSettings: () => Navigator.pushNamed(context, settings),
    );
  },
  ```

#### BUG-07: Teacher login navigates to the same Student Dashboard
- **File:** `lib/screens/auth/login_page2.dart` line 60
- **Problem:** Both student and teacher `_handleLogin` call the same navigation. The teacher sees the student dashboard with hardcoded "Student" greeting.
- **Fix for MVP:** Either create a simple `TeacherDashboardScreen` (even a placeholder with teacher-specific text), or at minimum show a SnackBar saying "Teacher dashboard coming soon" and stay on login.

#### BUG-08: Deprecated Material 2 ColorScheme properties used in login
- **File:** `lib/screens/auth/login_page2.dart` lines 166, 178, 242, 280, 349, 385
- **Problem:** Uses `colorScheme.surfaceVariant` and `colorScheme.onSurfaceVariant` which are deprecated in Material 3 (the project uses `useMaterial3: true`). On Flutter 3.22+, these may cause deprecation warnings or be removed.
- **Fix:** Replace with Material 3 equivalents:
  | Old (M2) | New (M3) |
  |---|---|
  | `colorScheme.surfaceVariant` | `colorScheme.surfaceContainerHighest` |
  | `colorScheme.onSurfaceVariant` | `colorScheme.onSurfaceVariant` (still exists in M3 but renamed internally) |

  Simplest fix — use `colorScheme.surfaceContainerHighest.withOpacity(0.5)` instead of `surfaceVariant`.

#### BUG-09: Wrong error message on Teacher ID validation
- **File:** `lib/screens/auth/login_page2.dart` line 355
- **Problem:** The Teacher ID field validator says "Please enter your **phone number**" instead of "Please enter your Teacher ID":
  ```dart
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number'; // <-- WRONG! Should be Teacher ID
    }
    return null;
  },
  ```
- **Fix:** Change to `'Please enter your Teacher ID'`.

#### BUG-10: "Continue" tap on subject cards does nothing
- **File:** `lib/widgets/learning_card.dart` line 165 and `lib/screens/student_dashboard_screen.dart`
- **Problem:** The `LearningCard` has an `onTap` callback, but `StudentDashboardScreen` never passes an `onSubjectTap` to `SubjectsSection`. So tapping Continue does nothing.
  ```dart
  // In student_dashboard_screen.dart — no onSubjectTap passed:
  SubjectsSection(
    title: AppStrings.coreSubjects,
    badgeText: AppStrings.basicCurriculum,
    badgeVariant: BadgeVariant.secondary,
    subjects: coreSubjects,
    // onSubjectTap is NOT passed — so tapping cards does nothing
  ),
  ```
- **Fix for MVP:** Add a basic `onSubjectTap` handler that navigates to a placeholder subject detail screen.

#### BUG-11: All quick action buttons only show SnackBars
- **File:** `lib/screens/student_dashboard_screen.dart` lines 227-255
- **Problem:** All four handlers (`_handleTodayLesson`, `_handlePracticeQuestions`, `_handleViewRewards`) only display a SnackBar. They don't navigate anywhere.
- **Fix for MVP:** At minimum, "Today's Lesson" should navigate to a lesson list page. Others can show a "Coming Soon" dialog.

#### BUG-12: Stale test file will fail
- **File:** `test/widget_test.dart`
- **Problem:** Tests for a default counter app (`MyApp` with `+` icon and counter text) that doesn't exist. Running `flutter test` will fail.
- **Fix:** Replace with basic widget tests:
  ```dart
  testWidgets('Login screen renders', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Nabha Digital Education'), findsOneWidget);
  });
  ```

---

### 2.3 MEDIUM — Code Quality & Clean-up

#### BUG-13: `flutter_riverpod` declared but never used
- **File:** `pubspec.yaml` line 39
- **Problem:** `flutter_riverpod: ^3.1.0` is a dependency but is **not imported or used** anywhere in any file. This adds unnecessary package size.
- **Fix:** Either implement Riverpod state management, or **remove it from pubspec.yaml** and run `flutter pub get`.

#### BUG-14: Old prototype dashboard still in the codebase
- **File:** `lib/screens/homescreen/student_dashboard.dart` (815 lines)
- **Problem:** This is an older version of the dashboard that is NOT registered in any route. It uses `NetworkImage` (Unsplash URLs), has `print()` statements, and duplicates all the functionality of `student_dashboard_screen.dart`. It's dead code.
- **Fix:** **Delete** the entire `lib/screens/homescreen/` directory.

#### BUG-15: `print()` statements in production code
- **File:** `lib/screens/homescreen/student_dashboard.dart` lines 104, 337, 561
- **Problem:** `print()` statements for debugging. These would get removed with BUG-14 fix, but if any other file has them, they should use `debugPrint()` instead.
- **Fix:** Remove with BUG-14. For any remaining, replace `print()` with `debugPrint()`.

#### BUG-16: Three unused card widgets in `cardsView/`
- **Files:** `lib/cardsView/courseCard.dart`, `lib/cardsView/subjectCard.dart`, `lib/cardsView/categoryCard.dart`
- **Problem:** None of these are imported or used anywhere in the app. They were early prototypes that were replaced by `learning_card.dart` and `custom_card.dart`.
- **Fix:** **Delete** the entire `lib/cardsView/` directory.

#### BUG-17: `percent_indicator` package used only once — redundant
- **File:** `lib/widgets/progress_indicator.dart` uses `package:percent_indicator`
- **Problem:** The app has a custom `CustomProgress` widget in `custom_progress.dart`, yet also keeps `progress_indicator.dart` which uses the third-party `percent_indicator` package. The custom widget is used everywhere; `progress_indicator.dart` is used nowhere.
- **Fix:** **Delete** `lib/widgets/progress_indicator.dart` and remove `percent_indicator` from `pubspec.yaml`.

#### BUG-18: Theme system defined but not used in `main.dart`
- **File:** `lib/main.dart` vs `lib/core/theme/app_theme.dart`
- **Problem:** A complete theme system with `AppTheme.lightTheme` and `AppTheme.darkTheme` exists, but `main.dart` uses an inline `ThemeData()` instead:
  ```dart
  // main.dart uses this:
  theme: ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF0F4C75),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F4C75)),
    useMaterial3: true,
  ),
  ```
- **Fix:** Replace with `theme: AppTheme.lightTheme` and add `darkTheme: AppTheme.darkTheme`.

#### BUG-19: `AppTheme.lightTheme` uses wrong primary color vs `main.dart`
- **File:** `lib/core/theme/app_theme.dart` uses `AppColors.primary = Color(0xFF2563EB)` (blue), but `main.dart` uses `Color(0xFF0F4C75)` (dark blue).
- **Problem:** Two different primary colors — theme system doesn't match what's live.
- **Fix:** Use `AppTheme.lightTheme` in `main.dart` (fixes BUG-18, which resolves this too).

#### BUG-20: Empty files create confusion
- **Files:**
  - `lib/presentation/pages/student_dashboard_page.dart` (empty)
  - `lib/widgets/ui/custom_avatar.dart` (empty)
- **Problem:** These are 1-line files with no content. `presentation/pages/` was meant for an architectural migration that never happened.
- **Fix:** **Delete** `lib/presentation/pages/student_dashboard_page.dart`. Keep `custom_avatar.dart` only if you plan to implement it soon; otherwise delete it.

#### BUG-21: 4 asset images are unused
- **Files in `assets/images/`:**
  - `hindi_bg.jpg` — NOT referenced in active code
  - `english_bg.jpg` — NOT referenced in active code
  - `math_bg.jpg` — NOT referenced in active code
  - `stats_banner_bg.jpg` — NOT referenced anywhere
- **Problem:** These add to the app binary size but serve no purpose. The `SubjectModel` has a `backgroundImage` property but it's never set for any subject.
- **Fix:** Either use them by populating the `backgroundImage` field in subject data, or **remove** the unused files.

#### BUG-22: Firebase API keys exposed in public repository
- **File:** `lib/firebase_options.dart`
- **Problem:** Contains hardcoded API keys for Web, Android, iOS, macOS, and Windows. While Firebase API keys are semi-public (they identify the project), exposing them in a public repo allows quota abuse.
- **Fix:** Set API key restrictions in Google Cloud Console to your app's package name. Add `.gitignore` entry for `firebase_options.dart` if desired (requires `flutterfire configure` per developer).

---

### 2.4 LOW — Nice-to-Have Clean-up

#### BUG-23: Inconsistent `Key? key` vs `super.key` across files
- **Files:** `lib/screens/homescreen/student_dashboard.dart` uses `Key? key` (old style), while all newer files use `super.key`.
- **Fix:** Delete the old file (BUG-14) and this is resolved.

#### BUG-24: Hardcoded strings throughout instead of using `AppStrings`
- **File:** `lib/screens/student_dashboard_screen.dart` — uses inline strings like `'Opening Today\'s Lesson...'`
- **File:** `lib/screens/auth/login_page2.dart` — uses inline strings like `'Name'`, `'Phone Number'`
- **Fix:** Move all user-facing strings to `app_strings.dart`.

#### BUG-25: `colorScheme.background` deprecated in newer Flutter
- **File:** `lib/screens/student_dashboard_screen.dart` line 151
- **Problem:** `Theme.of(context).colorScheme.background` is deprecated in Flutter 3.10+. Use `Theme.of(context).colorScheme.surface` instead.
- **Fix:** Replace `.background` with `.surface`.

---

## 3. Feature Implementation (Basic MVP)

These are the features needed to make the app **functional for a basic demo** — not production-grade, but enough that a user can log in, see their dashboard, browse subjects, and view a lesson.

### 3.1 P0 — Must-Have for Demo

#### FEAT-01: Pass user name from login to dashboard
- **Effort:** 15 min
- **What:** When a user logs in, their name should appear in the dashboard greeting ("Welcome, [Name]!").
- **How:**
  1. In `login_page2.dart`, pass name via route arguments
  2. In `routes.dart`, extract arguments and pass to `StudentDashboardScreen`
  3. The `StudentDashboardScreen` already accepts `studentName` — it just needs to receive it

#### FEAT-02: Create Subject Detail screen (basic lesson list)
- **Effort:** 2-3 hours
- **What:** Tapping a subject card should open a screen showing lesson titles and completion status.
- **How:**
  1. Create `lib/screens/subject_detail_screen.dart`
  2. Accept `SubjectModel` as parameter
  3. Show a list of lessons (mock data for MVP) with checkboxes for completed ones
  4. Add route in `routes.dart`
  5. Pass `onSubjectTap` to `SubjectsSection` in the dashboard

#### FEAT-03: Create Lesson View screen (basic content display)
- **Effort:** 2-3 hours
- **What:** Tapping a lesson should open a simple content viewer (text + an image placeholder).
- **How:**
  1. Create `lib/screens/lesson_view_screen.dart`
  2. Show lesson title, content text (mock), and a "Mark Complete" button
  3. Add route and wire up from the subject detail screen

#### FEAT-04: Implement basic Settings screen
- **Effort:** 1-2 hours
- **What:** Replace the placeholder with actual settings options.
- **How:**
  1. Dark mode toggle (using the existing `AppTheme.darkTheme`)
  2. Notification preferences (checkboxes, stored locally)
  3. About section with app version
  4. Logout button

#### FEAT-05: Make Quick Actions functional (at least "Today's Lesson")
- **Effort:** 1 hour
- **What:** "Today's Lesson" button should navigate to the lesson view for the first incomplete lesson.
- **How:**
  1. Find first subject where `progress < 100`
  2. Navigate to subject detail, then auto-open the next uncompleted lesson
  3. Other buttons ("Practice Questions", "View Rewards") can show a "Coming Soon" dialog

### 3.2 P1 — Should-Have for Basic Use

#### FEAT-06: Add `shared_preferences` for local data persistence
- **Effort:** 2-3 hours
- **What:** Store basic user data and progress locally so it survives app restarts.
- **How:**
  1. Add `shared_preferences` to `pubspec.yaml`
  2. Save: user name, role, subject progress, completed lessons
  3. Load saved data on app start and populate dashboard
  4. Update progress when lessons are marked complete

#### FEAT-07: Simple splash/loading screen
- **Effort:** 30 min
- **What:** Show the owl logo and app name while Firebase initializes.
- **How:**
  1. Create a simple `SplashScreen` widget
  2. Show for 2 seconds or until Firebase init completes
  3. Then navigate to login

#### FEAT-08: Proper error handling for Firebase init failure
- **Effort:** 30 min
- **What:** If Firebase fails to initialize (no internet, wrong config), show an error screen instead of a crash.
- **How:**
  1. Wrap `Firebase.initializeApp()` in try-catch in `main.dart`
  2. Show a user-friendly error screen with a "Retry" button

#### FEAT-09: Basic Teacher Dashboard (placeholder)
- **Effort:** 2 hours
- **What:** A simple screen for teachers with class overview and student list.
- **How:**
  1. Create `lib/screens/teacher_dashboard_screen.dart`
  2. Show: class name, student count, average progress (mock data)
  3. Add route in `routes.dart`
  4. Wire up teacher login to navigate here

#### FEAT-10: Back navigation on all screens
- **Effort:** 30 min
- **What:** Ensure all screens (except login) have a back button or proper navigation flow.
- **How:**
  1. Subject Detail → back to Dashboard
  2. Lesson View → back to Subject Detail
  3. Settings → back to Dashboard
  4. Login → should not have a back button

---

## 4. Suggested Dependency Additions

| Package | Why | Priority |
|---|---|---|
| `shared_preferences` | Local storage for user data, progress, settings | P1 |
| `go_router` or `auto_route` | Better navigation with arguments passing | P1 |
| `firebase_auth` | Phone OTP authentication | P1 (for real auth) |
| `cloud_firestore` | Remote database for users, subjects, progress | P1 (for real backend) |
| `cached_network_image` | Efficient image loading with caching | P2 |
| `google_sign_in` | Google OAuth login option | P2 |
| `hive` or `isar` | Local database for offline lesson caching | P2 |

**Packages to REMOVE:**
- `flutter_riverpod` (if not implementing state management soon)
- `percent_indicator` (custom progress widget exists, and the file using it is unused)

---

## 5. Implementation Order (Step-by-Step)

### Phase 1: Get It Clean & Building (Day 1)

```
[ ] BUG-02: Delete lib/data/models/subjects_section.dart
[ ] BUG-01: Remove unused import in student_dashboard_screen.dart (line 2)
[ ] BUG-03: Add INTERNET permission to AndroidManifest.xml
[ ] BUG-12: Replace test/widget_test.dart with basic passing test
[ ] BUG-14: Delete lib/screens/homescreen/ directory
[ ] BUG-16: Delete lib/cardsView/ directory
[ ] BUG-17: Delete progress_indicator.dart, remove percent_indicator from pubspec
[ ] BUG-20: Delete empty presentation/pages/student_dashboard_page.dart
[ ] BUG-20: Delete empty widgets/ui/custom_avatar.dart
[ ] BUG-13: Remove flutter_riverpod from pubspec.yaml (or commit to using it)
[ ] BUG-18: Use AppTheme.lightTheme in main.dart
[ ] BUG-09: Fix Teacher ID validation error message
[ ] BUG-08: Replace deprecated colorScheme properties
[ ] BUG-25: Replace colorScheme.background with .surface
[ ] Run flutter pub get && flutter analyze → zero errors
```

### Phase 2: Make It Functional (Days 2-3)

```
[ ] FEAT-01: Pass user name from login to dashboard
[ ] BUG-06: Wire up route arguments for student name
[ ] BUG-07: Teacher login → show "coming soon" or basic teacher screen
[ ] FEAT-02: Create Subject Detail screen with lesson list
[ ] FEAT-03: Create Lesson View screen with content display
[ ] BUG-10: Wire up onSubjectTap to navigate to Subject Detail
[ ] FEAT-05: Wire up "Today's Lesson" quick action
[ ] FEAT-04: Implement basic Settings screen
[ ] FEAT-10: Ensure proper back navigation everywhere
```

### Phase 3: Add Persistence & Polish (Days 4-5)

```
[ ] FEAT-06: Add shared_preferences for local data persistence
[ ] FEAT-07: Add splash screen
[ ] FEAT-08: Add Firebase init error handling
[ ] FEAT-09: Create basic Teacher Dashboard
[ ] BUG-21: Clean up unused asset images
[ ] BUG-24: Move hardcoded strings to AppStrings
[ ] BUG-22: Restrict Firebase API keys in Google Cloud Console
[ ] Run flutter test → all passing
[ ] Run flutter build apk → successful build
```

---

## Summary

| Category | Count |
|---|---|
| Critical bugs (won't build/run) | 3 |
| High bugs (broken features) | 8 |
| Medium bugs (code quality) | 10 |
| Low bugs (nice-to-have) | 3 |
| **Total bugs** | **24** |
| P0 features (must-have) | 5 |
| P1 features (should-have) | 5 |
| **Total features** | **10** |
| **Estimated MVP effort** | **5-7 days** |
