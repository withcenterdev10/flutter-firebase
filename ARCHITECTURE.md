# Architecture

## Folder Structure

```
lib/
├── main.dart
├── router.dart
├── firebase_options.dart
├── models/
│   └── user/
│       └── user.model.dart
├── repositories/
│   └── user/
│       └── user.repository.dart
├── services/
│   └── user/
│       └── user.service.dart
├── screens/
│   ├── home/
│   │   └── home.screen.dart
│   ├── sign_in/
│   │   └── sign_in.screen.dart
│   ├── sign_up/
│   │   └── sign_up.screen.dart
│   ├── profile/
│   │   └── profile.screen.dart
│   └── posts/
│       └── posts.screen.dart
├── widgets/
│   └── user/
│       ├── user.ready.dart
│       ├── user.data.dart
│       └── posts/
│           └── user_posts.dart
└── utils/
    ├── database/
    │   └── database.util.dart
    └── api/
        └── api.util.dart
```

## Naming Convention

- Files use dot-separated descriptive names: `<name>.<type>.dart`
  - Examples: `user.model.dart`, `user.service.dart`, `home.screen.dart`
- Folders match the feature/entity name in lowercase (e.g., `user/`, `posts/`)
- Class names use PascalCase with the type as suffix: `UserModel`, `UserService`, `HomeScreen`
- Private constructors and singletons use `._()` pattern with a static `instance` getter

## Layers

### Models (`lib/models/`)

Plain data classes with no dependencies on Flutter or Firebase. Each model has:
- Named constructor with optional fields
- `copyWith` method
- `fromJson` factory constructor

**Example:** `UserModel` holds `email`, `password`, `name`, and `nickname`.

### Repositories (`lib/repositories/`)

Handle all direct Firebase calls (Auth, Realtime Database). Each repository:
- Is a singleton via `ClassName._()` private constructor and `static instance` getter
- Accepts model objects as parameters
- Contains only data access logic

**Example:** `UserRepository` exposes `signUp`, `signIn`, `updateUser`, and `signOut`.

### Services (`lib/services/`)

Business logic layer that wraps repositories. Each service:
- Is a singleton with the same pattern as repositories
- Holds a reference to the corresponding repository via `RepositoryName.instance`
- Translates raw parameters (e.g., `String email, String password`) into model objects before calling the repository

**Example:** `UserService` creates a `UserModel` and delegates to `UserRepository`.

### Screens (`lib/screens/`)

Full-page widgets. Each screen defines three static members:
- `routeName` — a `const String` path (e.g., `'/sign_in'`)
- `push` — navigates using `context.push(routeName)`
- `go` — navigates using `context.go(routeName)`

Screens call `UserService.instance` directly for actions and use widgets (`UserReady`, `UserData`, `UserPosts`) to conditionally render UI based on auth/data state.

### Widgets (`lib/widgets/`)

Reusable stream-based data widgets that abstract Firebase stream subscriptions:

- **`UserReady`** — accepts `yes()` and optional `no()` callbacks; renders `yes()` when the user is authenticated, `no()` otherwise.
- **`UserData`** — accepts a `builder(context, UserModel?)` callback; provides the current user's data from `/members/{uid}`.
- **`UserPosts`** — accepts a `builder(context, List<Map<String, String>>)` callback; provides the current user's posts from `/members/{uid}/posts` with an injected `id` key.

### Utils (`lib/utils/`)

- **`database.util.dart`** — Defines the `Lists` enum with values `members` and `posts`, used as Firebase Realtime Database path keys.
- **`api.util.dart`** — Singleton `ApiUtil` wrapping `Dio` for HTTP requests (`get`, `post`, `put`, `delete`).

## Routing

Defined in `lib/router.dart` using `GoRouter`. The initial route is `/` (`HomeScreen`). All routes are flat (no nesting):

| Route | Screen |
|---|---|
| `/` | `HomeScreen` |
| `/sign_in` | `SignInScreen` |
| `/sign_up` | `SignUpScreen` |
| `/profile` | `ProfileScreen` |
| `/posts` | `PostsScreen` |

Navigation is triggered via the static `push` and `go` helpers on each screen class (e.g., `SignInScreen.push(context)`).

## Communication Flow

```
Screen
  └── calls UserService.instance.<method>(params)
        └── creates UserModel
              └── calls UserRepository.instance.<method>(model)
                    └── performs Firebase operation

Screen
  └── uses UserReady / UserData / UserPosts widgets
        └── widgets subscribe to Firebase streams
              └── provide data via builder callbacks back to Screen
```
