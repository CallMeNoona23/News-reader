# News-reader

A Flutter News Reader application built with state management (`provider`) and REST API integration.

## Features
- Fetches articles from JSONPlaceholder REST API using `http`.
- Separates business logic from UI using `provider` package (`ChangeNotifier`).
- Displays Loading, Error (with retry button), and Success states.
- List view display using `ListView.builder`.
- Real-time search box to filter articles by title.
- Article Detail screen accessible by tapping any article.
- Favorites functionality with total favorite count displayed in the AppBar.

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/CallMeNoona23/News-reader.git
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```
