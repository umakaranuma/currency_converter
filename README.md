# currency_converter_mobil_app

A new Flutter project.

## Getting Started

Follow the steps below to clone the repository, install dependencies, and run the app.

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/)
- An IDE such as [VSCode](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Clone the Repository

To clone this repository, run the following command:

```bash
git clone https://github.com/umakaranuma/currency_converter.git

cd currency_converter

flutter pub get

flutter run


UI Overview
After successfully running the app, you will first see the splash screen. The app’s user interface adapts based on your system's color theme (Dark Mode or Light Mode).

Light Mode:

Dark Mode:


...Folder Structure 


lib/
├── core/              # Contains base configurations like themes and API-related files
│   ├── api_config/    # API configurations (base URLs, client setup, etc.)
│   ├── theme_data/    # Theme-related files (color and text theme)
├── modules/           # Contains the app's main features, organized by screens
│   ├── home_screen/   # Home screen feature module
│   │   ├── infra/     # Infrastructure layer (API integration, models, bloc)
│   │   │   ├── bloc/  # Bloc pattern (Cubit and State management)
│   │   │   │   ├── cubit/   # Cubit for defining the functions
│   │   │   │   ├── state/   # State files for managing states
│   │   │   ├── datasource/  # API calls and data retrieval logic
│   │   │   ├── models/      # Models for data representation
│   │   ├── presenters/      # UI Layer (Widgets and Screens)
│   │   │   ├── widgets/     # Reusable widgets for the home screen
│   │   │   └── home_screen.dart # The main screen file for the home feature
│   ├── splash_screen/       # Splash screen feature module with a similar structure
│   │   ├── infra/           # Contains datasource, bloc, models for splash functionality
│   │   ├── presenters/      # Contains the splash screen and widgets
├── main.dart                # The entry point of the application


Architecture

This project follows a Bloc architecture pattern and modularizes the code into clear layers:

Main File: The main.dart file is the entry point of the application. It sets up the app by initializing the required dependencies and running the app's core widget.

Core: Contains the base configurations for the project, including API configurations and theme files. All reusable configuration settings are stored here to keep the project maintainable and scalable.

Modules: Each screen in the app (like the home screen and splash screen) is treated as a separate module. Within each module:

Infra: Handles data operations such as API calls, model definitions, and business logic management with Bloc (Cubit and State).

Bloc: In this folder, state management logic is divided into Cubit (which contains the functions) and State (which manages different states of the app).

Datasource: Contains API integration logic for fetching data.

Models: Contains the models that represent the data.

Presenters: This is where the UI is handled. It includes:

Widgets: Reusable widgets for the screen.

The main screen files that compose the UI using widgets and data from the Bloc.

This approach ensures that the app remains modular, scalable, and easy to maintain. Separating the logic, data, and UI helps in keeping the code organized and testable.