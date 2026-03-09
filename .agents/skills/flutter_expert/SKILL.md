---
name: flutter_expert
description: Guidelines for writing high-quality, modular Flutter code for the gym_app project.
---

# Flutter Expert Skill

This skill ensures that all Flutter code adheres to the `gym_app` architectural standards and best practices.

## 🏗 Architecture Principles
- **Feature-Based Structure:** Always place new features in `lib/features/<feature_name>`.
- **Core Separation:** Shared logic and UI components must reside in `lib/core`.
- **Clean Code:** Use descriptive naming, small functions, and follow the SOLID principles.

## 🛠 Coding Standards
- **Naming:** 
    - Classes: `PascalCase`
    - Variables/Functions: `camelCase`
    - Files: `snake_case.dart`
- **Widgets:** Prefer `StatelessWidget` unless state is absolutely necessary. Use `ConsumerWidget` if using Riverpod (verify in PROJECT_MEMORY).
- **Hardcoded Strings:** Avoid hardcoded strings in UI; use a localization system if available.

## 🧪 Verification
- Always run `flutter analyze` after significant changes.
- Ensure no Turkish character corruption in strings.
