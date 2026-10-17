# Gearforce

Gearforce is an application to build unit rosters for the game Heavy Gear Blitz.

More info about Heavy gear can be found at [Dream Pod 9's](www.dp9.com) website.

---

# Project Structure

This section provides an overview of the Gearforce project structure and guidelines for where to place different types of files. The project follows a hybrid architecture, combining **Clean Architecture** principles (Domain, Data, and Features layers) with a **Feature-First** organization for the UI and business logic.

## High-Level Architecture

The project is divided into four main directories under `lib/`:

1.  **`core/`**: Shared utilities, themes, localization, and generic widgets used across the entire application.
2.  **`domain/`**: The core business logic and entities. This layer is independent of any external frameworks (like Flutter) and the data layer.
3.  **`data/`**: Implementations of repositories and data sources. This layer handles data fetching (e.g., from JSON assets or APIs).
4.  **`features/`**: UI-related code grouped by feature (e.g., `roster`, `settings`). Each feature typically contains its own Blocs, screens, and feature-specific widgets.

---

## Directory Details

### `lib/core/`
Contains code reused across multiple features.
-   **`generated/i18n/`**: Localization files generated from ARB files.
-   **`localization/`**: Source ARB files for internationalization.
-   **`theme/`**: Application-wide themes and text styles (e.g., `app_theme.dart`).
-   **`utils/`**: General-purpose utility functions and helpers.
-   **`widgets/`**: Truly generic, reusable widgets (e.g., a custom button, layout helper, or responsive size utility).

### `lib/domain/`
The "brain" of the application. Contains no UI code.
-   **`entities/`**: Plain Dart objects representing game concepts. Grouped into sub-directories:
    -   `unit/`: Core unit, model, and squad definitions.
    -   `attribute/`: Core attributes (Armor, Skill, etc.) shared by multiple entities.
    -   `equipment/`: Weapons and traits.
    -   `faction/`: Faction, subfaction, and rule set definitions.
-   **`repositories/`**: Abstract interfaces that define how data should be fetched. The domain layer doesn't care *where* the data comes from, only *what* it can get.

### `lib/data/`
Handles how data is retrieved and stored.
-   **`repositories/`**: Concrete implementations of the interfaces defined in `lib/domain/repositories/` (e.g., `JsonUnitRepository`).
-   **`static/`**: Static configuration, registries (like `RuleSet` factory), and complex logic that doesn't fit neatly into JSON assets (e.g., modifier functions).

### `lib/features/`
Organized by high-level user features. Each feature folder should follow this structure:
-   **`bloc/`**: State management (Blocs, Events, States).
-   **`screens/`**: Full-page widgets (Scaffold).
-   **`widgets/`**: Widgets specific to this feature.

---

## Data-Driven Content

Game data (Units, Weapons, etc.) is stored as **JSON assets** to allow for updates without changing code.
-   **`assets/data/units/`**: Faction-specific JSON files containing unit statistics and variants.
-   **`assets/data/weapons/`**: JSON files for weapon definitions.

New units should be added to the appropriate JSON file in `assets/data/units/` rather than being hardcoded in Dart.

---

## Testing Structure

The `test/` directory strictly mirrors the `lib/` directory's structure.
-   For every file `lib/path/to/file.dart`, there should be a corresponding test file `test/path/to/file_test.dart`.
-   Use `flutter test` to run the test suite.

---

## Development

### Code Generation

This project uses `json_serializable` to automate the mapping between JSON assets and Domain Entities. Whenever you modify a class annotated with `@JsonSerializable` (or its related parts), you must run the code generator to update the `.g.dart` files.

**To run a one-time build:**
```bash
dart run build_runner build
```

**To watch for changes and regenerate automatically:**
```bash
dart run build_runner watch
```

### CI/CD Verification

To ensure that the generated files are always up-to-date in your repository, you can add a check to your CI/CD pipeline. The recommended way to do this is to run the build runner and then check if there are any changes in the working directory:

```bash
# Run the build runner
dart run build_runner build

# Check if there are any changes to the generated files
git diff --exit-code
```

If the generated files are out-of-sync with the models, `git diff --exit-code` will return a non-zero exit code, causing the CI pipeline to fail. This ensures that every pull request includes the correct generated code.

### Localization

User-facing strings are managed via ARB (Application Resource Bundle) files and Flutter's built-in localization system. The source strings live in `lib/core/localization/app_en.arb`, and the generated Dart code is output to `lib/core/generated/i18n/`.

**To add or update a localized string:**

1. Edit `lib/core/localization/app_en.arb` and add your new key/value pair. For simple strings:
   ```json
   "myNewLabel": "Hello World",
   "@myNewLabel": {
     "description": "A greeting label"
   }
   ```
   For strings with placeholders:
   ```json
   "welcomeMessage": "Welcome, {userName}!",
   "@welcomeMessage": {
     "description": "Welcome message with the user's name",
     "placeholders": {
       "userName": {
         "type": "String",
         "example": "Alice"
       }
     }
   }
   ```

2. Regenerate the Dart localization files:
   ```bash
   flutter gen-l10n
   ```

3. Use the string in your widget via the `context.l10n` extension:
   ```dart
   import 'package:gearforce/core/utils/l10n_extension.dart';

   // Simple string
   Text(context.l10n.myNewLabel)

   // Parameterized string
   Text(context.l10n.welcomeMessage('Alice'))
   ```

The `context.l10n` extension (defined in `lib/core/utils/l10n_extension.dart`) is the preferred way to access localized strings. Avoid using `AppLocalizations.of(context)!` directly.

---

## Benchmarking

Gearforce includes comprehensive benchmark tests for measuring JSON parsing and unit loading performance. See [docs/benchmarks.md](docs/benchmarks.md) for details.

**Quick Start:**

```bash
# Run benchmarks
flutter test test/data/repositories/unit_loading_benchmark.dart
```

Run with verbose output to see detailed timing:

```bash
flutter test test/data/repositories/unit_loading_benchmark.dart --verbose
```

---

## Summary Table: What Goes Where?

| Component                        | Directory                          |
| :------------------------------- | :--------------------------------- |
| **Domain Entity** (Unit, Weapon) | `lib/domain/entities/`             |
| **Attribute Entity**             | `lib/domain/entities/attribute/`   |
| **Repository Interface**         | `lib/domain/repositories/`         |
| **Repository Implementation**    | `lib/data/repositories/`           |
| **State Management** (Bloc)      | `lib/features/[feature]/bloc/`     |
| **UI Screen**                    | `lib/features/[feature]/screens/`  |
| **Reusable UI Widget**           | `lib/core/widgets/`                |
| **Feature-Specific Widget**      | `lib/features/[feature]/widgets/`  |
| **Localization Keys**            | `lib/core/localization/app_en.arb` |
| **Game Data** (JSON)             | `assets/data/`                     |

