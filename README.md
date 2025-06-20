# StarTrail 

[![pub package](https://img.shields.io/pub/v/star_trail.svg)](https://pub.dev/packages/star_trail)
[![pub points](https://img.shields.io/pub/points/star_trail)](https://pub.dev/packages/star_trail/score)
[![likes](https://img.shields.io/pub/likes/star_trail)](https://pub.dev/packages/star_trail/score)
[![license](https://img.shields.io/github/license/LakshmanTurlapati/Star-Trail-Flutter)](https://github.com/LakshmanTurlapati/Star-Trail-Flutter/blob/main/LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)

A Flutter widget that creates a star trails animation effect with circular motion, fading inner radii, and shorter trails near the center.

## Installation

### Use this package as a library

**Depend on it**

Run this command:

With Flutter:

```shell
$ flutter pub add star_trail
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```yaml
dependencies:
  star_trail: ^1.0.0
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

**Import it**

Now in your Dart code, you can use:

```dart
import 'package:star_trail/star_trail.dart';
```

## Usage

Add the `star_trail.dart` file to your project and use it as follows:

```dart
import 'package:flutter/material.dart';
import 'package:star_trail/star_trail.dart'; // Import the package

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: StarTrail(),
    ),
  ));
}
```

## Features

- **Number of Stars**: 250 (customizable via numberOfStars)
- **Duration**: 180 seconds for one full rotation  
- **Fading Effect**: Inner 10% of stars fade in opacity and have shorter trails

## Package Information

- **Package**: [star_trail ^1.0.0](https://pub.dev/packages/star_trail)
- **Pub.dev**: https://pub.dev/packages/star_trail

---

By Lakshman Turlapati
