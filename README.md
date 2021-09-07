# Themoviedb mobile app

[![Actions Status](https://github.com/excogitatr/rick-and-morty-info/workflows/deploy/badge.svg?branch=v1.1.0)](https://github.com/excogitatr/rick-and-morty-info/actions?query=workflow%3Adeploy)
[![Actions Status](https://github.com/excogitatr/rick-and-morty-info/workflows/build/badge.svg)](https://github.com/excogitatr/rick-and-morty-info/actions?query=workflow%3Abuild)
[![codecov](https://codecov.io/gh/excogitatr/rick-and-morty-info/branch/master/graph/badge.svg)](https://codecov.io/gh/excogitatr/rick-and-morty-info)
[![Flutter version](https://img.shields.io/badge/flutter-v2.12.0-blue?logo=flutter)](https://flutter.dev/docs/development/tools/sdk/releases)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

Learning Flutter from LazyLoadFlutter youtube chanel. Lessons are taught by Senior mobile developer from VK (Евгений).  
Creaiting from zero complicated project with all best practices.  

LazyLoadFlutter (Евгений): https://www.youtube.com/c/LearnDartFlutter/about  
API: https://www.themoviedb.org/documentation/api?language=ru    

## "Production level" implementations

- CI/CD with [GitHub Actions](https://github.com/features/actions)
- Githooks to ensure clean commit and push
  - Pre commit formats with `flutter format`
  - Pre push checks the code with `flutter analyze` and `flutter test`
- Linting style with [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Test coverage with [Codecov](https://codecov.io/)
- Dependency Injection with [injectable](https://pub.dev/packages/injectable) and [get_it](https://pub.dev/packages/get_it)
- Testing with [mockito](https://pub.dev/packages/mockito) and [bloc_test](https://pub.dev/packages/bloc_test)

## Screenshots

<p>
<img src="https://github.com/aiserrock/themoviedb_app/blob/master/img/themoviedb_app1.jpg" alt="Screen 1" width="250">
  <img src="https://github.com/aiserrock/themoviedb_app/blob/master/img/themoviedb_app2.jpg" alt="Screen 1" width="250">
</p>


## Installation

- Check flutter SDK and the version v2.12.0 or higher.
- Clone the repo
  ```sh
  git clone https://github.com/aiserrock/themoviedb_app.git
  ```
- And then we can use the normal build and run procedure
  ```sh
  flutter pub get
  flutter pub run build_runner build
  flutter run
  ```
  
## Getting Started

For help getting started with Flutter, view the
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
