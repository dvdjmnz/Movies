<div align="center">
<img src="https://github.com/user-attachments/assets/2ab46ab0-4508-4be2-baf6-9769b4a77cb3" alt="image (10)" width="400">
</div>

# Movies App

A Swift application that displays movies and TV shows filtered by genre using The Movie Database (TMDB) API.

<div align="center">
<img src="https://github.com/user-attachments/assets/58e8edf6-9a7d-4a92-85dd-17791e9a9603" alt="IMG_CF0F943E7553-1" width="400">
</div>

## How to Build the App

### Prerequisites
- Xcode 14.2 or later
- iOS 14.0+ deployment target
- CocoaPods installed

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/dvdjmnz/Movies.git
   cd Movies
   ```

2. **Install Dependencies**
   ```bash
   pod install
   ```

3. **Configure TMDB API Key** 🔑
   - Get your API key from [TMDB](https://www.themoviedb.org/settings/api)
   - Open `Movies/Common/Constants/NetworkConstants.swift`
   - Replace `"TMDB_API_KEY_HERE"` with your actual API key:
   ```swift
   static let tmdbApiKey = "your_actual_api_key_here"
   ```
   - **Important**: Never commit your actual API key to a public repository!

4. **Build and Run**
   - Open `Movies.xcworkspace` (not .xcodeproj)
   - Select your target device/simulator
   - Press Cmd+R to build and run
   - **Note**: Ensure you've replaced the API key placeholder in step 3, or the app won't be able to fetch data

## General Architecture

This project follows **Clean Architecture** principles with three main layers:

### Domain Layer
- **Entities**: Core business models (Movie, TvShow, Genre, etc.)
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic operations (GetMovies, GetGenres, etc.)

### Data Layer
- **DTOs**: Data Transfer Objects for API responses
- **DataSources**: Remote data access (TMDB API)
- **Repositories**: Concrete implementations of domain repositories
- **Network**: HTTP client and request handling

### Presentation Layer
- **ViewModels**: Reactive view models using RxSwift
- **ViewControllers**: UI controllers with binding logic
- **Views**: Custom UI components and cells

### Key Design Patterns
- **MVVM**: Model-View-ViewModel architecture
- **Dependency Injection**: Using Swinject container
- **Repository Pattern**: Data access abstraction
- **Generic Programming**: Reusable components for Movies/TV Shows
- **Reactive Programming**: RxSwift for data binding and async operations

## Breakdown of Libraries Used

### Core Dependencies
- **RxSwift (6.9.0)**: Reactive programming framework for handling asynchronous operations, data binding, and event streams
- **RxCocoa (6.9.0)**: UIKit extensions for RxSwift, enabling reactive bindings with UI components
- **Swinject (2.9.1)**: Dependency injection container for managing object dependencies and promoting testable code
- **SnapKit (5.7.1)**: Auto Layout DSL for programmatic constraint creation with cleaner syntax
- **Kingfisher (8.3.1)**: Powerful image downloading and caching library for efficient poster image loading

### Testing Dependencies

- **RxTest (6.9.0)**: Testing utilities for RxSwift observables and schedulers
- **RxBlocking (6.9.0)**: Blocking operations for RxSwift testing scenarios

### Architecture Benefits
- **Separation of Concerns**: Each layer has distinct responsibilities
- **Testability**: Dependency injection enables easy unit testing
- **Reusability**: Generic components work for both Movies and TV Shows
- **Maintainability**: Clean code structure with proper abstractions
- **Scalability**: Easy to add new features or modify existing ones

## Security

⚠️ **API Key Security**: This project uses a placeholder for the TMDB API key in `NetworkConstants.swift`. Users must replace the placeholder `"TMDB_API_KEY_HERE"` with their actual API key. **Never commit your actual API key to version control** - always use placeholders in public repositories.
