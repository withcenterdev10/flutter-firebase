# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run on iOS simulator
flutter run

# Build
flutter build ios

# Analyze/lint
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Get dependencies
flutter pub get
```

## Architecture

This is a Flutter app using Firebase (Auth + Realtime Database) with `go_router` for navigation and `provider` for state management.

### Layer Structure

- **`lib/models/`** — Plain data classes (e.g., `UserModel`)
- **`lib/repositories/`** — Direct Firebase calls (Auth, Realtime Database). All Firebase interactions should live here.
- **`lib/services/`** — Business logic layer that wraps repositories. Both services and repositories use singleton pattern via `instance` static getter.
- **`lib/screens/`** — Full-page widgets. Each screen defines its own `routeName`, `push`, and `go` static members.
- **`lib/widgets/`** — Reusable widgets, including stream-based data widgets.
- **`lib/utils/database/database.util.dart`** — Defines the `Lists` enum (`members`, `posts`) used as Firebase Realtime Database path keys.

### Firebase Database Structure

```
/members/{uid}/
  name: string
  nickname: string
  posts/{postId}/
    title: string
```

### Key Widgets

- **`UserReady`** — Wraps `FirebaseAuth.authStateChanges()` stream; calls `yes()` when logged in, `no()` otherwise.
- **`UserData`** — StreamBuilder that reads the current user's `/members/{uid}` node and provides a `UserModel`.
- **`UserPosts`** — StreamBuilder that reads `/members/{uid}/posts` and provides `List<Map<String, String>>` with an injected `id` key.

### Routing

All routes are defined in `lib/router.dart` using `GoRouter`. The initial route is `/posts`.

### Known TODOs

Several Firebase write operations in `PostsScreen` are marked `// TO_DO: Move this to Repository` — post creation, editing, and deletion are currently inline in the screen rather than in a repository.
