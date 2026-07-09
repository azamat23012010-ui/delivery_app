# Home Feature - Clean Architecture Structure

## Overview
This project follows Clean Architecture (TDD principles) with a clear separation of concerns across three layers:

## Folder Structure

```
home/
├── data/
│   ├── models/
│   │   └── delivery_model.dart           # Data models with serialization
│   └── repositories/
│       └── delivery_repository_impl.dart # Repository implementation
├── domain/
│   ├── entities/
│   │   └── delivery_entity.dart         # Business entity (pure Dart)
│   ├── repositories/
│   │   └── delivery_repository.dart     # Abstract repository interface
│   └── usecases/
│       └── get_current_delivery_usecase.dart  # Business logic
└── presentation/
    ├── screens/
    │   └── home_screen.dart             # Main screen widget
    └── widgets/
        ├── home_header.dart             # Header widget
        ├── search_bar_widget.dart       # Search bar widget
        └── current_delivery_card.dart   # Delivery card widget
```

## Layer Descriptions

### 1. **Domain Layer** (Business Logic)
- **Entities**: Pure Dart classes representing core business objects
  - `DeliveryEntity`: Contains core delivery information (immutable)
- **Repositories**: Abstract interfaces defining data access contracts
  - `DeliveryRepository`: Interface for delivery data operations
- **Use Cases**: Business logic implementation
  - `GetCurrentDeliveryUseCase`: Fetches current delivery information

**Advantage**: Domain layer is independent of frameworks and external libraries

### 2. **Data Layer** (Data Access)
- **Models**: Data Transfer Objects extending entities with serialization
  - `DeliveryModel`: Extends `DeliveryEntity`, adds JSON serialization
  - `fromJson()`: Deserializes from API/Database
  - `toJson()`: Serializes to API/Database
- **Repositories**: Concrete implementation of abstract repositories
  - `DeliveryRepositoryImpl`: Implements `DeliveryRepository`
  - Currently uses mock data; can be replaced with API calls or local database

**Advantage**: Centralized data access, easy to switch between API/local storage

### 3. **Presentation Layer** (UI)
- **Screens**: Main page containers
  - `HomeScreen`: Orchestrates the UI and handles state
- **Widgets**: Reusable UI components
  - `HomeHeader`: App title and profile button
  - `SearchBarWidget`: Search functionality
  - `CurrentDeliveryCard`: Displays active delivery status

**Advantage**: UI is decoupled from business logic, easy to test and maintain

## Data Flow

```
UI Event (User interaction)
    ↓
HomeScreen (orchestrates)
    ↓
GetCurrentDeliveryUseCase (business logic)
    ↓
DeliveryRepository (data access interface)
    ↓
DeliveryRepositoryImpl (concrete implementation)
    ↓
DeliveryModel (serialization)
    ↓
Data Source (API/Database/Mock)
    ↓
DeliveryEntity (business object returned)
    ↓
Widgets (display)
```

## Key Features

- ✅ **Separation of Concerns**: Each layer has specific responsibilities
- ✅ **Testability**: Business logic is independent and easily testable
- ✅ **Maintainability**: Changes in one layer don't affect others
- ✅ **Scalability**: Easy to add new features and repositories
- ✅ **Flexibility**: Data sources can be swapped without changing business logic

## How to Extend

### Adding a New Feature:
1. Create entity in `domain/entities/`
2. Create repository interface in `domain/repositories/`
3. Create use case in `domain/usecases/`
4. Create model in `data/models/`
5. Implement repository in `data/repositories/`
6. Create UI widgets in `presentation/widgets/`
7. Use in screen/widget

### Adding Tests:
```dart
// test/features/home/domain/usecases/get_current_delivery_usecase_test.dart
void main() {
  group('GetCurrentDeliveryUseCase', () {
    test('should return delivery entity', () async {
      // Test implementation
    });
  });
}
```

## Dependencies
- `flutter`: Core framework
- `yandex_mapkit`: Map integration
- `google_fonts`: Typography

## Current State
- ✅ Clean Architecture setup
- ✅ Domain layer (entities, repositories, use cases)
- ✅ Data layer (models, repository implementation)
- ✅ Presentation layer (screens and widgets)
- ✅ Mock data for demonstration
- ⏳ Ready for API integration
- ⏳ Ready for unit/widget tests
