---
name: ui_designer
description: Directions for creating premium, high-fidelity UI components with Glassmorphism and modern aesthetics.
---

# UI Designer Skill

This skill focuses on maintaining the "Premium & Modern" look of the `gym_app`.

## 🎨 Aesthetic Guidelines
- **Glassmorphism:** Use `BackdropFilter` with `ImageFilter.blur` for cards and overlays.
- **Colors:** Use deep gradients, subtle shadows, and a harmonious palette. Avoid flat, generic colors.
- **Typography:** Use modern fonts (e.g., Montserrat, Poppins) with clear hierarchy and weight variations.
- **Animations:** Implement micro-interactions using `AnimatedContainer`, `Hero` transitions, or `Lottie` for a "living" UI.

## 🧱 Component Rules
- **Cards:** Always use `PremiumGlassCard` or equivalent from `lib/core/widgets`.
- **Spacing:** Follow a strict 8dp/16dp grid system.
- **Icons:** Use `CupertinoIcons` or high-quality custom SVG assets.

## 📱 Responsiveness
- Ensure layouts work on various screen sizes using `LayoutBuilder` or `MediaQuery`.
- Prioritize "Mobile First" design.
