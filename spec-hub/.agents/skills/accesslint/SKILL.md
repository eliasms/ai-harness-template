---
name: accesslint
description: Web accessibility (a11y) and WCAG 2.1 / 2.2 AA audit and testing suite. Includes automated scanning, interactive inspection (keyboard navigation, focus, screen reader compatibility, color contrast), diff analysis, and remediation patterns.
---

# AccessLint Web Accessibility (WCAG 2.1 / 2.2 AA)

AccessLint provides comprehensive accessibility guidelines and auditing tools for web applications.

## Available Capabilities & Workflows

1. **Accessibility Scan (`skills/accessibility-scan`)**:
   - Automated rule engine checks for DOM elements, missing attributes, duplicate IDs, and ARIA usage.
2. **Accessibility Inspection (`skills/accessibility-inspect`)**:
   - Hands-on verification of keyboard navigation, focus indicators (`:focus-visible`), touch targets (minimum 44x44px), contrast ratios (4.5:1 text, 3:1 UI), and reflow/responsiveness.
3. **Accessibility Audit (`skills/accessibility-audit`)**:
   - Full WCAG-EM methodology assessment across user journeys and component states.
4. **Accessibility Fixes (`skills/accessibility-fix`)**:
   - Remediation patterns and accessible component blueprints.
5. **Accessibility Diff (`skills/accessibility-diff`)**:
   - Prevention of a11y regressions in pull requests and code modifications.

## Core Checklist for Angular Components
- Contrast: 4.5:1 for normal text, 3:1 for large text and interactive components.
- Keyboard: All actions executable without mouse; logical tab order; focus trap in modals (`cdkTrapFocus`).
- Screen Readers: Semantic HTML elements (`button`, `nav`, `main`, `h1-h6`), descriptive labels (`aria-label` / `aria-labelledby`), live announcements (`@angular/cdk/a11y LiveAnnouncer`).
- Reduced Motion: Support `prefers-reduced-motion` media queries for animations and transitions.
