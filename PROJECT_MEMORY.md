# PROJECT_MEMORY.md
> **Project Name:** gym_app
> **Last Updated:** 2026-03-10
> **Current Phase:** Development
> **Active Context:** Member Management, Diet & Program Assignment, Attendance Tracking

---

## [1. PROJECT VISION & GOALS]
* **Core Concept:** Modern ve premium bir spor salonu yönetim ve üye takip uygulaması.
* **Target Audience:** Spor salonu sahipleri ve üyeleri.
* **Success Criteria:** Üyelerin program ve diyetlerini kolayca yönetebilmesi, QR kod ile devamsızlık takibi ve şık bir kullanıcı deneyimi sunulması.

## [2. TECH STACK & CONSTRAINTS]
* **Language/Framework:** Flutter (Dart)
* **Backend/DB:** Local / To be confirmed (Supabase/Firebase potential)
* **State Management:** To be confirmed
* **Key Packages:** `qr_flutter`, `mobile_scanner`, `fl_chart`, `cupertino_icons`
* **Active Skills:** `flutter_expert`, `ui_designer` (located in `.agents/skills`)
* **Constraints:** Premium Design, Glassmorphism UI, Mobile First.

## [3. ARCHITECTURE & PATTERNS]
* **Design Pattern:** Feature-based Architecture
* **Folder Structure:**
    * `/lib/core`: Paylaşılan bileşenler, widget'lar ve temel yardımcılar.
    * `/lib/features`: Uygulamanın farklı işlevsel modülleri (Diyet, Program, Üyeler, Yoklama).
* **Naming Conventions:** camelCase for vars/functions, PascalCase for classes.

## [4. ACTIVE RULES (The "Laws")]
*(Yapay zekanın asla çiğnememesi gereken kurallar)*
1.  **UI Consistency:** Her zaman premium ve modern bir estetik kullan; glassmorphism ve yumuşak geçişleri önceliklendir.
2.  **Modular Code:** Yeni özellikleri her zaman `/lib/features` altında modüler bir yapıda oluştur.
3.  **Turkish Support:** Kullanıcı arayüzünde Türkçe dil desteğine ve karakterlerine dikkat et.

## [5. PROGRESS & ROADMAP]
- [x] Phase 1: Setup & Configuration
- [x] Phase 2: Core Features (Program & Diet Assignment)
- [x] Phase 3: Attendance & Scanning (QR Integration)
- [/] Phase 4: UI Polish & Premium Widgets
- [ ] Phase 5: Testing & Deployment

## [6. DECISION LOG & ANTI-PATTERNS]
*(Hatalardan ders çıkarma günlüğü)*
* **[Karar - 2026-03-10]:** Universal Memory Protocol (PROJECT_MEMORY.md) sistemi başlatıldı.
* **[Anti-Pattern]:** Standart UI widget'ları yerine `premium_glass_card` gibi özel tasarım öğelerini kullanmaya devam et.

---
**OPERATIONAL DIRECTIVE:**
1.  **Read First:** Before answering any prompt, check this file for context.
2.  **Update Often:** If a task is completed, check the box [x]. If a tech decision changes, update Section 2.
3.  **Stay Consistent:** Do not suggest code that violates "Active Rules".
