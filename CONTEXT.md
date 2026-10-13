# UNICOM — Complete Project Context
> **Last Updated:** April 24, 2026  
> **Purpose:** Ultra-detailed handoff document so any AI assistant (Copilot, Cursor, etc.) can pick up exactly where we left off with zero context loss.

---

## 1. PROJECT OVERVIEW

**UNICOM** is a **campus social networking mobile app** (think Reddit + LinkedIn + Instagram, but exclusively for Indian college students). It connects students across different colleges to share posts, discover events, find teammates for hackathons, explore opportunities, and message each other.

- **Platform:** Flutter (iOS + Android, currently tested on iOS Simulator — iPhone 16e)
- **Target Users:** Indian college students (IIT, NIT, BITS, etc.)
- **Current State:** Frontend-only with `MockData`. Supabase backend is configured but NOT yet connected. All screens use static mock data.
- **Build Status:** ✅ Compiles and runs with ZERO errors. Only `info`-level `withOpacity` deprecation warnings remain (280 total — harmless, not blocking).

---

## 2. ORIGINAL REFERENCE (React Frontend)

The Flutter app is a **1:1 replica** of a React/TypeScript frontend located at:
```
/Users/paarth/Downloads/FRONTEND/
```
This is the design source of truth. When implementing any new screen or component, check the corresponding `.tsx` file in this directory. Key reference files:
- `src/pages/Home.tsx` → HomeScreen
- `src/pages/Explore.tsx` → ExploreScreen
- `src/pages/Events.tsx` → EventsScreen
- `src/pages/Communities.tsx` → CommunitiesScreen
- `src/pages/Opportunities.tsx` → OpportunitiesScreen
- `src/pages/Messages.tsx` → MessagesScreen
- `src/pages/Profile.tsx` → ProfileScreen
- `src/pages/Notifications.tsx` → NotificationsScreen
- `src/components/` → core reusable components

**Design Language:** Glassmorphism — dark backgrounds (`Colors.black`), semi-transparent containers with `BackdropFilter + ImageFilter.blur`, white borders at low opacity, gradient overlays on images.

---

## 3. TECH STACK

| Layer | Technology | Version |
|-------|-----------|---------|
| Framework | Flutter | SDK ^3.11.5 |
| Language | Dart | Latest |
| State Management | flutter_riverpod | ^3.3.1 |
| Navigation | go_router | ^17.2.2 |
| Backend (future) | supabase_flutter | ^2.12.4 |
| Typography | google_fonts (Inter) | ^8.0.2 |
| Animations | flutter_animate | ^4.5.2 |
| Icons | lucide_icons | ^0.257.0 |
| Image Loading | cached_network_image | ^3.4.1 |
| UI Framework | Material 3 | built-in |

**NOT used:** No Bloc, no Provider, no GetX. **Riverpod only** for future state. Currently everything is stateful widgets or local state.

---

## 4. COMPLETE DIRECTORY STRUCTURE

```
/Users/paarth/Desktop/UNICOM/
├── lib/
│   ├── main.dart                          # App entry point, UnicomApp, theme, ProviderScope
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart               # AppColors class (design tokens)
│   │   │   └── mock_data.dart            # ALL mock data models + static data lists
│   │   ├── router/
│   │   │   └── app_router.dart           # GoRouter config, all routes defined here
│   │   └── widgets/
│   │       ├── custom_button.dart        # Reusable gradient button
│   │       └── custom_input.dart         # Reusable text input field
│   └── features/
│       ├── splash/
│       │   └── presentation/screens/
│       │       └── splash_screen.dart    # Animated logo splash → /onboarding
│       ├── onboarding/
│       │   └── presentation/screens/
│       │       └── onboarding_screen.dart # 3-slide onboarding carousel → /signin
│       ├── auth/
│       │   └── presentation/screens/
│       │       ├── sign_in_screen.dart   # Email/password login UI
│       │       ├── sign_up_screen.dart   # Registration UI
│       │       └── setup_profile_screen.dart # Multi-step profile setup (name, college, interests, skills)
│       ├── main/
│       │   └── presentation/screens/
│       │       └── main_layout.dart      # ShellRoute wrapper — bottom nav bar (Home/Explore/Notifs/Profile)
│       ├── home/
│       │   └── presentation/
│       │       ├── screens/
│       │       │   ├── home_screen.dart      # Feed with stories row + PostCard list
│       │       │   └── story_view_screen.dart # Full-screen story viewer with timer progress bars
│       │       └── widgets/
│       │           └── post_card.dart        # Core feed card — full-bleed image, glassmorphic overlays, voting
│       ├── explore/
│       │   └── presentation/screens/
│       │       ├── explore_screen.dart       # Search/discover people, trending tags, connect button
│       │       ├── communities_screen.dart   # Hub discovery — joined hubs grid + public communities list
│       │       └── events_screen.dart        # Events dashboard — upcoming/registered/calendar tabs
│       ├── create/
│       │   └── presentation/screens/
│       │       └── create_screen.dart        # Post creation (slides up from bottom)
│       ├── messages/
│       │   └── presentation/screens/
│       │       ├── messages_screen.dart      # Conversations list
│       │       └── chat_screen.dart          # Individual chat room (receives id via route param)
│       ├── notifications/
│       │   └── presentation/screens/
│       │       └── notifications_screen.dart # Notifications feed
│       ├── profile/
│       │   └── presentation/screens/
│       │       └── profile_screen.dart       # User profile with stats, posts grid
│       └── settings/
│           └── presentation/screens/
│               └── settings_screen.dart      # App settings
├── test/
│   └── widget_test.dart                  # Placeholder test (no real tests yet)
├── ios/                                   # iOS native project (pod-managed)
├── android/                               # Android native project
└── pubspec.yaml                           # Dependencies
```

---

## 5. NAVIGATION / ROUTING

File: `lib/core/router/app_router.dart`

**Router:** GoRouter v17 with a ShellRoute for the main tab layout.

**Route Map:**
```
/splash           → SplashScreen         (entry point)
/onboarding       → OnboardingScreen     (FadeTransition)
/signin           → SignInScreen         (FadeTransition)
/signup           → SignUpScreen         (FadeTransition)
/setup            → SetupProfileScreen   (FadeTransition)
/settings         → SettingsScreen       (SlideTransition ←)
/story/:id        → StoryViewScreen      (FadeTransition)
/messages         → MessagesScreen       (SlideTransition ←)
/chat/:id         → ChatScreen           (SlideTransition ←)
/create           → CreateScreen         (SlideTransition ↑)

ShellRoute (MainLayout — bottom nav):
  /home           → HomeScreen           (NoTransition)
  /explore        → ExploreScreen        (NoTransition)
  /notifications  → NotificationsScreen  (NoTransition)
  /profile        → ProfileScreen        (NoTransition)
```

**Navigation conventions:**
- `context.go('/route')` — replace stack
- `context.push('/route')` — push on stack
- `context.pop()` — go back
- Shell routes share the `MainLayout` (bottom nav bar)

---

## 6. DESIGN SYSTEM

### Color Tokens (`lib/core/constants/colors.dart`)
```dart
AppColors.bgPrimary       = 0xFFFFFFFF  (white - rarely used, bg is mostly black in dark screens)
AppColors.bgSecondary     = 0xFFF0F2F5
AppColors.bgTertiary      = 0xFFE4E6EB
AppColors.borderSubtle    = 0xFFE4E6EB
AppColors.accentPrimary   = 0xFF0064E0  (Facebook-blue — primary CTA)
AppColors.accentSecondary = 0xFFFFB800  (Gold/amber — highlights)
AppColors.accentTertiary  = 0xFFE41E3F  (Red — alerts, live badges)
AppColors.textPrimary     = 0xFF050505
AppColors.textSecondary   = 0xFF65676B
AppColors.textTertiary    = 0xFF8C939D
AppColors.glassWhite      = 0x0DFFFFFF  (5% white for glass containers)
```

### Typography
- **Font:** Inter via `GoogleFonts.interTextTheme()` applied globally in `main.dart`
- **Usage:** All `Text` widgets inherit from the theme; override locally with `style:` as needed

### Glassmorphism Pattern (used throughout)
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),  // or Colors.black.withOpacity(0.3)
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ...,
    ),
  ),
)
```

### Key Deprecation Note
`withOpacity()` is deprecated in newer Flutter. Use `.withValues(alpha: value)` instead. 280 info warnings exist — **do not panic, the app builds fine.** Migrate incrementally when touching a file.

---

## 7. MOCK DATA (`lib/core/constants/mock_data.dart`)

All data classes and static lists live here. **No Supabase calls yet.**

### Data Models
```dart
MockUser      { id, name, handle, avatar, college, role, verified }
MockStory     { id, image, user: MockUser }
MockComment   { id, author: MockUser, content, time, likes }
MockPost      { id, author, type, title?, content, images, date?, time, likes, comments, isLiked, isSaved, skills? }
MockCommunity { id, name, type, image, members, isJoined }
MockEventOrganizer { name, verified }
MockEvent     { id, title, image, date, time, attendees, organizer, tags, isRsvpd }
MockOpportunity { id, title, type, deadline, skills, author: MockUser }
```

### Static Lists Available
```dart
MockData.currentUser     → MockUser (the logged-in user)
MockData.stories         → List<MockStory>  (5 stories for home screen)
MockData.posts           → List<MockPost>   (3 posts for home feed)
MockData.communities     → List<MockCommunity> (7 communities)
MockData.events          → List<MockEvent>  (3 events)
MockData.opportunities   → List<MockOpportunity> (3 opportunities)
```

---

## 8. CORE REUSABLE WIDGETS

### `CustomInput` (`lib/core/widgets/custom_input.dart`)
```dart
CustomInput({
  dynamic icon,          // Accepts IconData OR Widget — auto-wraps IconData into Icon()
  Widget? rightIcon,     // Right-side icon widget
  String? placeholder,   // Hint text (original param name)
  String? hintText,      // Alias for placeholder (same effect)
  bool obscureText,      // For password fields, default false
  TextEditingController? controller,
  TextInputType? keyboardType,
  bool required,         // Visual only, default false
  ValueChanged<String>? onChanged,  // Callback on text change
})
```

### `CustomButton` (`lib/core/widgets/custom_button.dart`)
- Gradient primary button (blue → purple), full-width, 56px height, rounded 16px
- Parameters: `label`, `onPressed`, `isLoading`

---

## 9. SCREEN-BY-SCREEN BREAKDOWN

### 9.1 SplashScreen (`/splash`)
- Black background, animated UNICOM logo with pulse + fade
- Uses `flutter_animate` for entrance animations
- After 2s delay → navigates to `/onboarding`

### 9.2 OnboardingScreen (`/onboarding`)
- 3-slide PageView carousel (full-screen)
- Slides: "Your Campus, Connected" / "Discover Opportunities" / "Build Your Network"
- Each has gradient illustration area, title, subtitle
- Bottom: dot indicators + CTA button
- Last slide CTA → `/signin`

### 9.3 SignInScreen (`/signin`)
- Dark glassmorphic card over blurred background
- Email + Password fields using `CustomInput`
- "Sign In" button using `CustomButton`
- "Don't have account?" → `/signup`
- (Supabase auth not wired — navigation is manual)

### 9.4 SignUpScreen (`/signup`)
- Same dark aesthetic as SignIn
- Name, Email, Password fields
- "Already have account?" → `/signin`
- On submit → `/setup`

### 9.5 SetupProfileScreen (`/setup`)
- **Multi-step form with 3 steps:**
  1. Step 1 — Basic Info: Full Name, Username, College, Course/Year (4 `CustomInput` fields, icon via `IconData`)
  2. Step 2 — Interests: Grid of interest chips (Web3, Design, ML, Gaming, etc.) — tap to toggle
  3. Step 3 — Skills: Similar chip grid (Python, Figma, React, etc.)
- Progress indicator at top (step 1/2/3 of 3)
- "Next" / "Finish Setup" buttons
- Uses `TextEditingController` per field, `onChanged` callbacks
- On finish → `/home` (or will trigger Supabase upsert in future)

### 9.6 MainLayout (`ShellRoute` shell)
- Glassmorphic bottom navigation bar
- 4 tabs: Home (house icon), Explore (compass), Notifications (bell), Profile (user)
- Center: floating "+" create button → pushes `/create`
- Active tab indicator is white dot below icon
- Uses `go_router`'s `ShellRoute` — child screen renders above the nav bar

### 9.7 HomeScreen (`/home`)
- **Stories Row:** Horizontal scroll of `MockData.stories` (circular avatars with gradient ring)
  - Tap story → pushes `/story/:id`
  - "Add Story" first item
- **Feed:** Vertical scroll of `PostCard` widgets from `MockData.posts`

### 9.8 PostCard (`lib/features/home/presentation/widgets/post_card.dart`)
- Full-bleed image (4:5 aspect ratio)
- **Glassmorphic top overlay:** Author info pill (avatar + name + role badge + verified check)
  - Tap → `context.push('/profile')`
- **Glassmorphic bottom overlay:**
  - Voting (up/down arrows with count, orange for upvote, indigo for downvote)
  - Comment + Share glass icon buttons
  - Tags/skill chips (wrapped)
  - Post title + content (2-line truncated)
- Save + More (⋯) top-right glass icon buttons
- State: `voteStatus` (-1/0/1), `voteCount`, `isSaved` — local StatefulWidget state

### 9.9 StoryViewScreen (`/story/:id`)
- Full-screen story viewer
- Timer-driven progress bars at top (5s per story, uses `Timer.periodic`)
- Tap left 30% → previous story; tap right 70% → next story
- Auto-advances; last story → `context.pop()`
- Author header (avatar, name, timestamp)
- Reply text field + heart emoji button at bottom

### 9.10 ExploreScreen (`/explore`)
- Tab bar: All / People / Posts / Events / Groups
- **Trending hashtags** horizontal scroll with view counts
- **Suggested People** list with avatar, name, college, role, Connect button
  - Connect → pending state (2s) → connected state (visual feedback)
- **Explore Sections** cards with background images

### 9.11 CommunitiesScreen (`/explore` sub-screen — accessible via ExploreScreen nav)
- **Your Hubs:** Grid of joined communities (from `MockData.communities` where `isJoined: true`)
- **Discover Communities:** Categorized (Official/Interests/Events) list of public communities
- Glassmorphic header with member counts
- Join button on each unjoin community card

### 9.12 EventsScreen (`/explore` sub-screen)
- **Tab navigation:** Upcoming / Registered / Calendar
- Event cards with gradient overlay image, date badge, attendee count
- RSVP button (toggle state per event)
- Organizer with verified badge support

### 9.13 CreateScreen (`/create` — slides up from bottom)
- Full-screen post creation flow
- Media picker area, caption input, tag selection

### 9.14 MessagesScreen (`/messages`)
- Conversations list with avatar, last message preview, timestamp, unread badge

### 9.15 ChatScreen (`/chat/:id`)
- Individual chat room, receives conversation `id` via route param

### 9.16 NotificationsScreen (`/notifications`)
- Notifications feed (likes, comments, follows, etc.)

### 9.17 ProfileScreen (`/profile`)
- Current user profile (uses `MockData.currentUser`)
- Stats row (Posts/Followers/Following)
- Posts grid

### 9.18 SettingsScreen (`/settings`)
- App settings, account info, logout

---

## 10. WHAT WAS BUILT IN THIS SESSION

### Problems Fixed & New Features (this session)
1. ✅ **CustomInput:** Added `hintText` alias, `onChanged` callback, `dynamic icon` (auto-converts `IconData` → `Icon` widget).
2. ✅ **All Remaining Screens Implemented:** 
   - `CommunitiesScreen` (Grid of joined hubs + discover list).
   - `EventsScreen` (Tabs for upcoming/registered/calendar).
   - `OpportunitiesScreen` (List of jobs/hackathons with filters).
   - `OpportunityDetailsScreen` (Detailed page for an opportunity with roles and "Express Interest").
   - `PostDetailsScreen` (Full-page view of a post with comments section).
3. ✅ **CreateScreen Polished:** Added right toolbar for Story tab (Type, Sparkles, Pen, Link) and Bottom "Publish Opportunity" button for Opportunity tab.
4. ✅ **Navigation & Routing:** 
   - Wired `CommunitiesScreen`, `EventsScreen`, and `OpportunitiesScreen` into the `ExploreScreen` navigation.
   - Connected `PostCard` to `/post/:id` route.
   - Upgraded all `ShellRoute` transitions to use premium, smooth animations (combined `FadeTransition` with `SlideTransition` + `Curves.easeOutCubic`) similar to Apple Music.
5. ✅ **Home Screen Scrolling Issue:** Ensured the Top App Bar and Stories row scroll out of view when scrolling the feed (built inside `CustomScrollView`). Added skeleton loading for smoother UX.
6. ✅ **Data Models:** Added `MockOpportunity`, `MockCommunity`, `MockEvent`, `MockEventOrganizer`, and updated `MockPost` with comprehensive static data in `mock_data.dart`.

### Sessions Before This
- **Session 1:** Created Flutter project from scratch, installed all dependencies.
- **Session 2:** Built SplashScreen (animated), OnboardingScreen (3-slide carousel).
- **Session 3:** Built SignIn, SignUp, SetupProfile screens; created `CustomInput`, `CustomButton`; defined `AppColors`.
- **Session 4:** Built MainLayout (ShellRoute + bottom nav), HomeScreen (stories + feed), PostCard widget.
- **Session 5:** Built StoryViewScreen, ExploreScreen, MessagesScreen, ChatScreen, NotificationsScreen, ProfileScreen, SettingsScreen, CreateScreen.

---

## 11. WHAT TO BUILD NEXT

### Immediate Priority
1. **Supabase Integration** — Replace all `MockData` references with real Supabase queries:
   - Auth: `supabase.auth.signIn()`, `supabase.auth.signUp()`
   - Profile: `supabase.from('profiles').upsert()`
   - Posts: `supabase.from('posts').select()`
   - Real-time feed with `supabase.channel()`
2. **State Management Upgrade** — Move from StatefulWidget local state to Riverpod providers for feed, auth state, and notifications.

### Medium Priority
3. **Notifications System** — Real push notifications via Supabase Realtime.
4. **Search Functionality** — Implement actual filtering logic in ExploreScreen and OpportunitiesScreen.
5. **Image Uploads** — Implement device camera/gallery selection in `CreateScreen`.

### Future
6. **Replace `withOpacity()`** with `.withValues(alpha:)` throughout (280 info warnings).
7. **End-to-End Testing** — Add widget and integration tests for critical user journeys.

---

## 12. SUPABASE SETUP (Not Yet Connected)

Supabase is imported but no auth or DB calls are made yet.

**Future tables planned:**
```sql
profiles      (id, name, handle, avatar_url, college, course, year, bio, verified)
posts         (id, author_id, type, title, content, images[], date, likes, created_at)
communities   (id, name, type, image_url, member_count)
events        (id, title, image_url, date, time, attendees, organizer_id, tags[])
opportunities (id, title, type, deadline, skills[], author_id)
messages      (id, sender_id, receiver_id, content, created_at)
```

**Supabase project:** NOT yet connected (no URL/key in the codebase yet). Will need to:
1. Create project at supabase.com
2. Add URL + anon key to Flutter via `.env` or `flutter_dotenv`
3. Initialize in `main.dart` with `await Supabase.initialize(url:..., anonKey:...)`

---

## 13. HOW TO RUN

```bash
# Navigate to project
cd /Users/paarth/Desktop/UNICOM

# Install dependencies (if needed)
flutter pub get

# Run on iOS simulator (iPhone 16e)
flutter run

# Analyze for errors
flutter analyze --no-fatal-infos

# Hot reload: press 'r' in terminal
# Hot restart: press 'R' in terminal
# Quit: press 'q'
```

**Environment:** macOS, Flutter SDK with iOS targeting iPhone 16e simulator.

---

## 14. KEY CONVENTIONS TO FOLLOW

1. **Feature-first structure:** New screens go in `lib/features/<feature_name>/presentation/screens/`
2. **Reusable widgets:** Go in `lib/core/widgets/` if shared across features, OR in `lib/features/<feature>/presentation/widgets/` if feature-specific
3. **Imports:** Always use package imports `package:unicom/...`, never relative imports `../...`
4. **Mock data:** Add any new models AND their static lists to `lib/core/constants/mock_data.dart`
5. **Navigation:** New routes MUST be registered in `lib/core/router/app_router.dart`
6. **No business logic in widgets:** Keep screens as UI-only; state goes in `StatefulWidget` or Riverpod providers
7. **Aesthetic:** Every screen must follow the glassmorphism dark UI — reference the React frontend in `/Users/paarth/Downloads/FRONTEND/src/pages/`
8. **Icons:** Use `lucide_icons` package (e.g., `LucideIcons.home`, `LucideIcons.search`), NOT Material Icons where possible
9. **Images:** Use `CachedNetworkImage` for all network images. Use `picsum.photos` or `unsplash.com` for mock image URLs

---

## 15. IMPORTANT FILE CONTENTS SUMMARY

### `main.dart`
```dart
// Entry: ProviderScope → UnicomApp → MaterialApp.router
// Theme: Material3, Inter font, bgPrimary scaffold, accentPrimary colorScheme
// Router: goRouter from app_router.dart
```

### `custom_input.dart` (UPDATED — use this API)
```dart
CustomInput(
  hintText: 'Enter email',           // works (alias for placeholder)
  icon: Icons.email,                 // works — accepts IconData directly!
  controller: _emailController,
  onChanged: (val) => print(val),    // works
  keyboardType: TextInputType.emailAddress,
  obscureText: false,
)
```

### Route for new screen
```dart
// In app_router.dart, inside goRouter routes:
GoRoute(
  path: '/new-screen',
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: const NewScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
),
```

---

*This document reflects the exact state of the UNICOM Flutter project as of April 24, 2026. The app builds and runs successfully on iOS simulator. All listed files exist and compile without errors.*
