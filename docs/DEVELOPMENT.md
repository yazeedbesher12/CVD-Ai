# Development Guide

## Setup

```bash
flutter pub get
```

## Run Locally

```bash
flutter run
```

For a web demo:

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 5000
```

## Checks Before Pushing

```bash
dart format lib test
flutter analyze
flutter test
```

## Notes

- The main app currently lives in `lib/main.dart`.
- The ECG reading is simulated; do not describe it as live medical sensor input.
- The PDF report is generated locally using the `pdf` and `printing` packages.
- If running on Windows and plugin builds fail because of symlinks, enable Windows Developer Mode.

