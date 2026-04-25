# GitHub Copilot Task List — Nabha Digital Education (MVP Baseline)

> **Scope**: Bug fixes + minimum features to bring this Flutter project from prototype to a working MVP (basic tier). NOT fully functional — just running, navigable, and demo-able.
>
> **How to use**: Open each task as a Copilot Chat prompt in VS Code. Tasks are ordered by priority. Complete them sequentially — earlier tasks unblock later ones.

---

## PHASE 1 — Critical Build Fixes (Do These First)

### TASK 1: Fix missing INTERNET permission in AndroidManifest

**File**: `android/app/src/main/AndroidManifest.xml`

**Problem**: The app has no `<uses-permission>` for INTERNET. Even though Firebase is initialized, any network call will crash on Android.

**Action**: Add `<uses-permission android:name="android.permission.INTERNET" />` as a direct child of `<manifest>`, BEFORE the `<application>` tag.

```xml
<!-- ADD THIS LINE right after the opening <manifest> tag -->
<uses-permission android:name="android.permission.INTERNET" />
```

The top of the file should look like:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application
        android:label="digital_learning_application"
        ...
```

---

### TASK 2: Delete the duplicate `SubjectsSection` class

**File**: `lib/data/models/subjects_section.dart`

**Problem**: `SubjectsSection` is defined BOTH here AND in `lib/widgets/subjects_section.dart`. The widget version (`lib/widgets/subjects_section.dart`) is the one actually used by the active dashboard. This file also has wrong import paths (`../../data/models/subject_model.dart` from inside `data/models/` — circular/incorrect).

**Action**: Delete the entire file `lib/data/models/subjects_section.dart`. The active `SubjectsSection` widget lives at `lib/widgets/subjects_section.dart` and is the one used by `student_dashboard_screen.dart`.

---

### TASK 3: Remove the import of the deleted duplicate file (if any)

**File**: Search the entire `lib/` directory for any import of `data/models/subjects_section.dart`.

**Action**: Remove any import line that references `data/models/subjects_section.dart` from all `.dart` files. No file should import this path after Task 2.

---

### TASK 4: Fix empty `quick_action_button.dart` (imported but empty)

**File**: `lib/widgets/quick_action_button.dart`

**Problem**: `student_dashboard_screen.dart` has `import 'package:digital_learning_application/widgets/quick_action_button.dart';` but this file is completely empty (1 blank line). This will cause a compile error since the import is unused (or worse, if something is expected from it).

**Action**: Since `QuickActionButton` is not actually used in `student_dashboard_screen.dart` (the quick actions use `QuickActionsSection` from a different file), just remove the unused import from `student_dashboard_screen.dart`:

In `lib/screens/student_dashboard_screen.dart`, **remove this line**:
```dart
import 'package:digital_learning_application/widgets/quick_action_button.dart';
```

---

### TASK 5: Fix empty `student_dashboard_page.dart`

**File**: `lib/presentation/pages/student_dashboard_page.dart`

**Problem**: This file is completely empty. It's not imported anywhere currently, but it's a dead file that will confuse developers.

**Action**: Delete the entire file `lib/presentation/pages/student_dashboard_page.dart`. If the `lib/presentation/pages/` directory becomes empty, delete that directory too.

---

### TASK 6: Fix empty `custom_avatar.dart`

**File**: `lib/widgets/ui/custom_avatar.dart`

**Problem**: This file is completely empty. Not imported anywhere currently.

**Action**: Delete the entire file `lib/widgets/ui/custom_avatar.dart`.

---

### TASK 7: Fix stale test — `widget_test.dart` tests wrong app

**File**: `test/widget_test.dart`

**Problem**: This is the default Flutter counter app test. It expects to find text `'0'` and `'1'` and tap `Icons.add`, which don't exist in this education app. Running `flutter test` will fail.

**Action**: Replace the entire file with a basic smoke test that just verifies the app boots:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_learning_application/main.dart';

void main() {
  testWidgets('App loads and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Verify the login screen renders
    expect(find.text('Nabha Digital Education'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
    expect(find.text('Teacher'), findsOneWidget);
  });
}
```

---

## PHASE 2 — Login & Navigation Fixes

### TASK 8: Pass student name from login to dashboard

**Files**:
- `lib/screens/auth/login_page2.dart`
- `lib/core/routes.dart`
- `lib/screens/student_dashboard_screen.dart`

**Problem**: After student login, the dashboard always shows "Student" as the name. The name entered in the login form is never passed to the dashboard screen.

**Action**:

**Step A** — In `lib/screens/auth/login_page2.dart`, change `_handleLogin` to pass the student name:

```dart
void _handleLogin(String userType, [String? userName]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$userType Login successful!'),
      backgroundColor: Colors.green,
    ),
  );
  Navigator.pushReplacementNamed(
    context,
    AppRoutes.dashboard,
    arguments: userName ?? 'Student',
  );
}
```

Update `_handleStudentLogin`:
```dart
void _handleStudentLogin() {
  if (_studentFormKey.currentState!.validate()) {
    _handleLogin('Student', _studentNameController.text.trim());
  }
}
```

`_handleTeacherLogin` stays the same (no name, just teacher ID).

**Step B** — In `lib/screens/student_dashboard_screen.dart`, update the constructor to accept name from route arguments:

```dart
class StudentDashboardScreen extends StatefulWidget {
  final String studentName;
  final VoidCallback? onLogout;
  final VoidCallback? onSettings;

  const StudentDashboardScreen({
    super.key,
    this.studentName = 'Student',
    this.onLogout,
    this.onSettings,
  });

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}
```

Then in `lib/core/routes.dart`, update the dashboard route to extract arguments:

```dart
dashboard: (context) {
  final args = ModalRoute.of(context)?.settings.arguments as String?;
  return StudentDashboardScreen(
    studentName: args ?? 'Student',
    onLogout: () => Navigator.pushReplacementNamed(context, login),
    onSettings: () => Navigator.pushNamed(context, settings),
  );
},
```

---

### TASK 9: Fix teacher login navigating to student dashboard

**Files**:
- `lib/screens/auth/login_page2.dart`
- `lib/core/routes.dart`

**Problem**: Both student and teacher login go to the same student dashboard route (`/dashboard`). There is no teacher dashboard.

**Action**: For MVP, create a basic placeholder teacher dashboard screen so navigation at least doesn't break.

**Step A** — Create `lib/screens/teacher_dashboard_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:digital_learning_application/core/constants/app_colors.dart';

class TeacherDashboardScreen extends StatelessWidget {
  final String teacherId;
  final VoidCallback? onLogout;

  const TeacherDashboardScreen({
    super.key,
    this.teacherId = 'Teacher',
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Teacher Dashboard — $teacherId'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people, size: 80, color: AppColors.primary),
              SizedBox(height: 24),
              Text(
                'Teacher Dashboard',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.foreground),
              ),
              SizedBox(height: 12),
              Text(
                'This section is under development.\nStudent management and content upload features coming soon.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.mutedForeground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Step B** — Add route in `lib/core/routes.dart`:

```dart
import '../screens/teacher_dashboard_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String teacherDashboard = '/teacher-dashboard';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      dashboard: (context) {
        final args = ModalRoute.of(context)?.settings.arguments as String?;
        return StudentDashboardScreen(
          studentName: args ?? 'Student',
          onLogout: () => Navigator.pushReplacementNamed(context, login),
          onSettings: () => Navigator.pushNamed(context, settings),
        );
      },
      teacherDashboard: (context) {
        final args = ModalRoute.of(context)?.settings.arguments as String?;
        return TeacherDashboardScreen(
          teacherId: args ?? 'Teacher',
          onLogout: () => Navigator.pushReplacementNamed(context, login),
        );
      },
      settings: (context) => const SettingsScreen(),
    };
  }
}
```

**Step C** — In `lib/screens/auth/login_page2.dart`, update `_handleTeacherLogin` to navigate to teacher dashboard:

```dart
void _handleTeacherLogin() {
  if (_teacherFormKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Teacher Login successful!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.teacherDashboard,
      arguments: _teacherIdController.text.trim(),
    );
  }
}
```

---

### TASK 10: Fix wrong validator message on Teacher ID field

**File**: `lib/screens/auth/login_page2.dart`

**Problem**: The Teacher ID field validator says "Please enter your phone number" instead of "Please enter your Teacher ID".

**Action**: Find this line in the teacher form's `TextFormField` for Teacher ID:
```dart
validator: (value) {
  if (value == null || value.isEmpty)
    return 'Please enter your phone number'; // BUG: wrong message
  return null;
},
```

Change it to:
```dart
validator: (value) {
  if (value == null || value.isEmpty)
    return 'Please enter your Teacher ID';
  return null;
},
```

---

## PHASE 3 — Dead Code Cleanup

### TASK 11: Delete old prototype dashboard

**File**: `lib/screens/homescreen/student_dashboard.dart`

**Problem**: This is an 815-line old prototype dashboard. It is NOT imported by any route or any other file. It contains hardcoded data, `NetworkImage` calls to Unsplash URLs, `print()` statements, and uses the old `Key? key` pattern. It's pure dead code.

**Action**: Delete the entire file `lib/screens/homescreen/student_dashboard.dart`. If the `lib/screens/homescreen/` directory becomes empty, delete that directory too.

---

### TASK 12: Delete unused cardsView widgets

**Files**:
- `lib/cardsView/categoryCard.dart`
- `lib/cardsView/courseCard.dart`
- `lib/cardsView/subjectCard.dart`

**Problem**: None of these three files are imported or used anywhere in the active codebase. They were early prototype card widgets replaced by the widget system (`lib/widgets/`).

**Action**: Delete all three files. If the `lib/cardsView/` directory becomes empty, delete that directory too.

---

### TASK 13: Remove unused `percent_indicator` dependency

**Files**:
- `pubspec.yaml`
- `lib/widgets/progress_indicator.dart`

**Problem**: `percent_indicator` package is declared as a dependency, but the only file using it (`progress_indicator.dart`) is not imported by any active screen. The active dashboard uses `CustomProgress` from `lib/widgets/ui/custom_progress.dart` instead.

**Action**:
1. Delete `lib/widgets/progress_indicator.dart` (unused widget).
2. Remove `percent_indicator: ^4.2.3` from `pubspec.yaml` under `dependencies`.

---

## PHASE 4 — Theme & UI Consistency

### TASK 14: Apply the defined `AppTheme` in `main.dart`

**File**: `lib/main.dart`

**Problem**: `lib/core/theme/app_theme.dart` defines beautiful `lightTheme` and `darkTheme` with a full design system, but `main.dart` ignores them completely and uses an inline `ThemeData` with a different primary color (`0xFF0F4C75` vs the theme system's `0xFF2563EB`).

**Action**: Replace the `theme` property in `MaterialApp` to use the defined theme:

```dart
import 'package:digital_learning_application/core/theme/app_theme.dart';

// In MyApp.build():
return MaterialApp(
  title: 'Nabha Digital Education',
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  initialRoute: AppRoutes.login,
  routes: AppRoutes.getRoutes(),
);
```

Remove the inline `ThemeData(...)` block entirely.

---

### TASK 15: Fix deprecated Material 2 color properties

**File**: `lib/screens/auth/login_page2.dart`

**Problem**: The login screen uses `colorScheme.surfaceVariant` and `colorScheme.onSurfaceVariant` which are Material 2 properties deprecated in Flutter 3.x with `useMaterial3: true`.

**Action**: Replace all occurrences:
- `colorScheme.surfaceVariant` → `colorScheme.surfaceContainerHighest`
- `colorScheme.onSurfaceVariant` → `colorScheme.onSurface`

Search for these in the file and replace them. There are approximately 4 occurrences.

---

### TASK 16: Fix deprecated `colorScheme.background` in dashboard

**File**: `lib/screens/student_dashboard_screen.dart`

**Problem**: `colorScheme.background` is deprecated in Material 3. The `AppTheme` already defines `scaffoldBackgroundColor`, so the dashboard's explicit reference is redundant and will produce deprecation warnings.

**Action**: Replace:
```dart
backgroundColor: Theme.of(context).colorScheme.background,
```
with:
```dart
backgroundColor: Theme.of(context).scaffoldBackgroundColor,
```

---

## PHASE 5 — Quick Actions MVP (No Backend Needed)

### TASK 17: Make quick action buttons show placeholder screens instead of SnackBars

**Files**:
- `lib/screens/student_dashboard_screen.dart`
- New files for placeholder screens (or use a generic placeholder approach)

**Problem**: All four quick action buttons ("Today's Lesson", "Practice Questions", "View Rewards", "Settings") just show `SnackBar` messages. For MVP demo purposes, they should at least navigate to a screen.

**Action**: Create a generic placeholder screen at `lib/screens/placeholder_screen.dart`:

```dart
import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const PlaceholderScreen({
    super.key,
    required this.title,
    this.message = 'This feature is under development and will be available in a future update.',
    this.icon = Icons.construction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

Then in `lib/screens/student_dashboard_screen.dart`, update the handler methods:

```dart
void _handleTodayLesson() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PlaceholderScreen(
        title: "Today's Lesson",
        message: "Your personalized daily lesson will appear here. Feature coming soon!",
        icon: Icons.menu_book,
      ),
    ),
  );
}

void _handlePracticeQuestions() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PlaceholderScreen(
        title: 'Practice Questions',
        message: 'Practice questions and quizzes will be available here soon.',
        icon: Icons.quiz,
      ),
    ),
  );
}

void _handleViewRewards() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PlaceholderScreen(
        title: 'Rewards',
        message: 'Your earned badges, stars, and achievements will be displayed here.',
        icon: Icons.emoji_events,
      ),
    ),
  );
}
```

Settings already has a route, so that one is fine.

---

### TASK 18: Make subject cards tappable (navigate to placeholder)

**File**: `lib/screens/student_dashboard_screen.dart`

**Problem**: The `SubjectsSection` widget accepts `onSubjectTap` callback, but it's never passed from the dashboard. Tapping a subject card does nothing.

**Action**: Add `onSubjectTap` to both `SubjectsSection` widgets in the build method:

```dart
SubjectsSection(
  title: AppStrings.coreSubjects,
  badgeText: AppStrings.basicCurriculum,
  badgeVariant: BadgeVariant.secondary,
  subjects: coreSubjects,
  onSubjectTap: (subject) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaceholderScreen(
        title: subject.subject,
        message: '${subject.subject} lessons and content will be available here.\n\n'
            'Progress: ${subject.progress}%\n'
            'Lessons: ${subject.completedLessons}/${subject.totalLessons}\n'
            'Streak: ${subject.streak} days',
        icon: subject.icon,
      ),
    ),
  ),
),
```

Do the same for the `higherSubjects` `SubjectsSection`. For locked subjects, show a lock icon instead:

```dart
onSubjectTap: (subject) {
  if (subject.isLocked) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This subject is locked. Complete core subjects first!')),
    );
    return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaceholderScreen(
        title: subject.subject,
        message: '${subject.subject} lessons and content will be available here.\n\n'
            'Progress: ${subject.progress}%\n'
            'Lessons: ${subject.completedLessons}/${subject.totalLessons}\n'
            'Streak: ${subject.streak} days',
        icon: subject.icon,
      ),
    ),
  );
},
```

Don't forget to add the import at the top:
```dart
import '../screens/placeholder_screen.dart';
```

---

## PHASE 6 — Polish & Cleanup

### TASK 19: Remove unused `flutter_riverpod` dependency

**File**: `pubspec.yaml`

**Problem**: `flutter_riverpod: ^3.1.0` is declared but never imported or used anywhere in the codebase. Adding unused dependencies bloats the app size.

**Action**: Remove `flutter_riverpod: ^3.1.0` from `pubspec.yaml` under `dependencies`.

---

### TASK 20: Run `flutter pub get` and verify clean build

**Action**: After all the above changes:

1. Run `flutter pub get` to update dependencies
2. Run `flutter analyze` to check for warnings/errors
3. Run `flutter test` to verify the smoke test passes
4. Run `flutter build apk --debug` to verify a successful build

Fix any remaining compilation errors. Common ones to watch for:
- Unused imports (remove them)
- Missing imports (add them)
- Deprecated API warnings

---

## Summary Checklist

| # | Task | Phase | Status |
|---|------|-------|--------|
| 1 | Add INTERNET permission | 1 - Critical | ☐ |
| 2 | Delete duplicate `SubjectsSection` | 1 - Critical | ☐ |
| 3 | Remove stale imports of deleted file | 1 - Critical | ☐ |
| 4 | Remove unused `quick_action_button` import | 1 - Critical | ☐ |
| 5 | Delete empty `student_dashboard_page.dart` | 1 - Critical | ☐ |
| 6 | Delete empty `custom_avatar.dart` | 1 - Critical | ☐ |
| 7 | Fix stale widget test | 1 - Critical | ☐ |
| 8 | Pass student name login → dashboard | 2 - Navigation | ☐ |
| 9 | Create teacher dashboard + route | 2 - Navigation | ☐ |
| 10 | Fix teacher ID validator message | 2 - Navigation | ☐ |
| 11 | Delete old prototype dashboard | 3 - Cleanup | ☐ |
| 12 | Delete unused cardsView widgets | 3 - Cleanup | ☐ |
| 13 | Remove unused `percent_indicator` | 3 - Cleanup | ☐ |
| 14 | Apply `AppTheme` in main.dart | 4 - Theme | ☐ |
| 15 | Fix deprecated M2 color properties | 4 - Theme | ☐ |
| 16 | Fix deprecated `colorScheme.background` | 4 - Theme | ☐ |
| 17 | Quick actions → placeholder screens | 5 - Features | ☐ |
| 18 | Subject cards → tappable navigation | 5 - Features | ☐ |
| 19 | Remove unused `flutter_riverpod` | 6 - Polish | ☐ |
| 20 | Verify clean build | 6 - Polish | ☐ |

**Total: 20 tasks across 6 phases**

---

## Notes for Copilot

- All file paths are relative to the project root.
- Tasks within the same phase can be done in any order EXCEPT Phase 1 (must be sequential — Task 2 before Task 3, etc.).
- Do NOT modify `firebase_options.dart` — that's project-specific config.
- Do NOT add new packages unless explicitly stated.
- The `assets/images/` directory should contain `owl_logo.png`, `hero_learning.jpg`, and `student_dash_BG.png`. If any are missing, the app will show error icons (already handled by `errorBuilder` in the login screen).
