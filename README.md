# 💰 Expenzia — Expense Management App

**Expenzia** is a simple and user-friendly expense management application built with **Flutter**. It helps users record, manage, update, and delete their expenses through a clean interface designed to make everyday expense tracking easier.

The project focuses on clean code organization, reusable UI components, state management, input validation, and local database operations.

## ✨ Features

- **Dashboard** — View expense summaries and recent transactions.
- **Add Expenses** — Record an expense with its title, amount, category, date, and optional description.
- **Edit Transactions** — Update existing expense details.
- **Delete Transactions** — Remove expenses with a confirmation dialog.
- **Transaction History** — View saved expenses in an organized list.
- **Local Database** — Store expense records using SQLite.
- **State Management** — Manage transaction data and UI states using BLoC.
- **Form Validation** — Validate required fields and ensure expense amounts are greater than zero.
- **Reusable UI Components** — Maintain consistent styling through shared widgets, colors, spacing, and text styles.
- **Responsive Flutter UI** — Build interfaces with Flutter for supported mobile and web targets.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI development |
| Dart | Application programming language |
| BLoC (`flutter_bloc`) | State management |
| Equatable | Value equality for events and states |
| SQLite | Local expense data storage |
| `sqflite` | SQLite integration |
| `sqflite_common_ffi_web` | Experimental SQLite support for Flutter Web |
| `intl` | Date and number formatting |

## 📁 Project Structure

```text
expenzia/
├── assets/
│   └── splash/
│       └── image.png
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   └── app_spacing.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   └── app_text_styles.dart
│   │   ├── utils/
│   │   │   └── validators.dart
│   │   └── widgets/
│   │       ├── app_button.dart
│   │       ├── app_card.dart
│   │       ├── app_empty_state.dart
│   │       ├── app_snackbar.dart
│   │       └── app_text_field.dart
│   ├── data/
│   │   ├── database/
│   │   │   ├── app_database.dart
│   │   │   ├── database_factory.dart
│   │   │   ├── database_factory_native.dart
│   │   │   └── database_factory_web.dart
│   │   ├── models/
│   │   │   └── expense_model.dart
│   │   └── repositories/
│   │       └── expense_repository.dart
│   ├── features/
│   │   ├── splash/
│   │   ├── onboarding/
│   │   ├── home/
│   │   ├── transactions/
│   │   │   ├── bloc/
│   │   │   │   ├── transaction_bloc.dart
│   │   │   │   ├── transaction_event.dart
│   │   │   │   └── transaction_state.dart
│   │   │   └── view/
│   │   │       ├── transaction_form_screen.dart
│   │   │       └── transaction_history_screen.dart
│   │   ├── credits/
│   │   └── profile/
│   └── main.dart
├── web/
├── pubspec.yaml
└── README.md
```

*The structure above describes the intended organization. Adjust the tree to match the files currently present in your project.*

## 🏗️ Architecture

Expenzia separates UI, application state, and data operations to keep the code easier to understand and maintain.

```text
UI / Screens
     │
     ▼
Transaction BLoC
(Events and States)
     │
     ▼
Expense Repository
(CRUD and Validation)
     │
     ▼
SQLite Database
```

### Core layers

- **Presentation layer:** Flutter screens and reusable widgets render the interface and handle user interactions.
- **State management layer:** BLoC processes transaction events and emits loading, success, and error states.
- **Repository layer:** Handles expense operations, including creating, reading, updating, and deleting records.
- **Data layer:** The expense model represents transaction data, while the database layer manages SQLite storage.

## 🚀 Getting Started

### Prerequisites

Install the following before running the project:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Git](https://git-scm.com/)
- Chrome for running the web version, or an Android/iOS development environment for mobile.

Verify your Flutter installation:

```bash
flutter doctor
```

### 1. Clone the repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd expenzia
```

Replace the repository URL and directory name with your actual values.

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up SQLite for Flutter Web

If your project uses `sqflite_common_ffi_web`, run its setup command:

```bash
dart run sqflite_common_ffi_web:setup
```

This prepares the required web database assets. Run the setup after installing dependencies and ensure the generated files remain available when building the web app.

> **Note:** SQLite support on Flutter Web is experimental. Test database initialization and persistence in your target browser. Native mobile and web database implementations may differ.

### 4. Run the application

**Web — Chrome**

```bash
flutter run -d chrome
```

**Android — connected device or emulator**

```bash
flutter run
```

To see available devices:

```bash
flutter devices
```

### 5. Build the application

**Flutter Web**

```bash
flutter build web
```

**Android APK**

```bash
flutter build apk --release
```

**Android App Bundle**

```bash
flutter build appbundle --release
```

For iOS, build on macOS with Xcode configured:

```bash
flutter build ios --release
```

## 🗃️ Expense Data

Each expense record contains the following fields:

| Field | Description |
|---|---|
| `id` | Unique database identifier |
| `title` | Expense name |
| `amount` | Expense amount |
| `category` | Expense category |
| `date` | Date associated with the expense |
| `description` | Optional additional details |

The repository provides operations to:

- Retrieve expense records.
- Add new expenses.
- Update existing expenses.
- Delete expenses.
- Calculate the total of recorded expenses.

## 🎨 UI Design

Expenzia follows a clean, minimal interface with a teal and mint color palette, light surfaces, rounded cards, and consistent spacing.

The design aims to make expense tracking approachable, with clear navigation, readable transaction details, and straightforward forms.

## 🧪 Validation and Error Handling

The application validates expense data before saving it:

- Expense title cannot be empty.
- Amount must be a valid, finite number greater than zero.
- Category cannot be empty.
- An existing transaction must have an ID before it can be updated.
- Database and repository failures are surfaced through the transaction state and UI feedback.

## 🛣️ Future Improvements

Potential improvements for future versions include:

- Income tracking and balance calculations.
- Monthly and weekly expense reports.
- Category-based analytics and charts.
- Search, sorting, and filtering.
- Budget limits and spending alerts.
- Exporting transaction history.
- Automated unit, widget, and integration tests.
- Database migrations as the data model evolves.

## 🤝 Contributing

Contributions and suggestions are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Implement your changes.
4. Test your changes.
5. Submit a pull request with a clear description.

## 📄 License

No license has been specified yet. Add a `LICENSE` file before distributing the project for reuse by others.

---

**Built with Flutter and Dart.**

*Expenzia — Track your expenses. Understand your spending. Make smarter financial decisions.*