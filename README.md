# Ecommerce App Using Bloc

We have implemented Ecommerce App using Bloc Architecture.

The tasks we have performed are 
1) Getting Products List From Rest Api
2) Showing List of Products in Home Screen
3) Searched Products using keywords

#### Note :  For Comparison Purpose, we have implemented this app in both Bloc and Provider architecture. 
You can see below the file structure of both the architecture. In case of Bloc, we have to create more files compare to Provider. So that makes the app heavier. While in case of provider, it makes it so much compact in size. for that just one change need to be done in lib/main.dart file in 15 and 16 line. by default it is working on Bloc pattern.

## 1) File Structure of Bloc Architecture

```
bloc_implementation
|   main_bloc.dart
|
└───blocs
│   └───products
│       │   products_bloc.dart
|
└───events
│   └───products
│       │   products_event.dart
|
└───repositories
│   └───products
│       │   products_repositories.dart
|
└───states
│   └───products
│       │   products_states.dart
|
└───ui
│   └───home_screen
│       │   bloc_home_screen.dart
|
```

## 2) File Structure of Provider Architecture

```
provider_implementation
|   main_provider.dart
|
└───controllers
│   │   products_controller.dart
|
└───providers
│   │   products_provider.dart
|
└───ui
│   └───home_screen
│       │   provider_home_screen.dart
|
```
