# Justfile for Gearforce (Heavy Gear Blitz roster builder)
# Run `just` or `just --list` to inspect available commands.

# Set the shell to PowerShell on Windows (so Git Bash / sh is not required)
set windows-shell := ["powershell.exe", "-NoProfile", "-Command"]

# Default recipe: show help listing
default:
    @just --list

# ------------------------------------------------------------------------------
# Setup & Code Generation
# ------------------------------------------------------------------------------

# Install pub dependencies
deps:
    flutter pub get

# Regenerate localization files from ARB source files
generate-localizations:
    flutter gen-l10n

alias gen-l10n := generate-localizations
alias l10n := generate-localizations

# Regenerate unit data JSON files from profiles Excel spreadsheet
# Usage: just generate-units "path/to/profiles.xlsx"
generate-units excel_path:
    dart run tool/generate_units.dart "{{excel_path}}"

alias gen-units := generate-units

# Clean Flutter build outputs
clean:
    flutter clean

# ------------------------------------------------------------------------------
# Code Quality & Testing
# ------------------------------------------------------------------------------

# Format all Dart code in place
fmt:
    dart format .

# Check code formatting and run static analysis
check:
    dart format --set-exit-if-changed .
    flutter analyze

# Run test suite
test:
    flutter test

# Run JSON parsing and unit loading performance benchmarks
benchmark:
    flutter test test/benchmarks/

# ------------------------------------------------------------------------------
# Local Development
# ------------------------------------------------------------------------------

# Run app on default attached device
run:
    flutter run

# Run desktop app on Windows
run-win:
    flutter run -d windows

# Run web app in Chrome
run-web:
    flutter run -d chrome

# ------------------------------------------------------------------------------
# Release Builds
# ------------------------------------------------------------------------------

# Build release Android APK
build-apk:
    flutter build apk --release

# Build release Android App Bundle (AAB for Google Play)
build-appbundle:
    flutter build appbundle --release

# Build release Windows desktop executable
build-windows:
    flutter build windows --release

alias build-win := build-windows

# Build release web app
build-web:
    flutter build web --release

# ------------------------------------------------------------------------------
# CI / Verification Pipeline
# ------------------------------------------------------------------------------

# Run complete CI verification (deps -> generate-localizations -> check -> test)
ci: deps generate-localizations check test
