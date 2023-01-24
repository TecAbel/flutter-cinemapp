# cinemapp

A new Flutter project.

# Json Annotation (for model build)
Run this command
    flutter pub run build_runner build
And add on file top
    import 'package:json_annotation/json_annotation.dart';
    part 'filename.g.dart'
And right before class model add
    @JsonSerializable()

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
