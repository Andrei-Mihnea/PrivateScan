# AGENTS.md

## Mission

Build a native Swift document-scanning application that is genuinely useful to its developer, enjoyable to build, and respectful of the user's privacy. Optimize first for a delightful personal tool and a strong learning experience. Keep the architecture clean enough that a larger audience could be supported later, but do not let hypothetical scale turn the first version into an over-engineered product.

The app should make scanning feel calm, fast, trustworthy, and almost effortless:

1. Point the camera at a document.
2. Capture or automatically detect the page.
3. Correct perspective, improve legibility, and review the result.
4. Save, organize, search, export, or share it on the user's terms.

## Product principles

- Local-first is the default. Documents, OCR output, thumbnails, metadata, and search indexes stay on the device unless the user explicitly initiates an export or sync.
- Privacy is a product feature, not a legal afterthought. Make privacy visible through clear copy, understandable settings, and predictable behavior.
- Minimize surprise. Never upload, analyze remotely, track, or require an account for core scanning functionality.
- Prefer excellent defaults over a maze of settings. Expose advanced controls only when they solve a real problem.
- Make the happy path obvious, forgiving, and quick. Preserve originals and make edits reversible.
- Treat accessibility as part of the design: Dynamic Type, VoiceOver labels, sufficient contrast, reduced motion, large touch targets, and meaningful haptics.
- Make the app feel personal and crafted. Small moments of delight are welcome when they never interfere with speed, clarity, or privacy.
- Build for learning. Favor understandable Swift and SwiftUI, focused experiments, and explanations of meaningful architectural decisions over premature abstraction.
- For syncing when user expresses the decision to save documents for syncing always use iCloud storage and nothing else

## Technical direction

- Use current stable Swift and Apple platform APIs appropriate to the deployment target. Confirm API availability before adopting newer frameworks.
- Prefer SwiftUI for UI and modern Swift concurrency with strict, clear ownership of state.
- Use VisionKit for document-camera capture where appropriate, and Vision for perspective correction, image enhancement, text recognition, and document understanding.
- Keep capture, image processing, OCR, persistence, search, export, and UI behind small protocols or focused types so each area can be tested and replaced.
- Perform expensive image processing and OCR off the main actor. Keep UI state updates on the main actor and make cancellation explicit.
- Preserve the highest-quality local source image available. Generate smaller derivatives for previews and search when useful; document the quality tradeoffs.
- Use Apple-provided encryption and protected storage where appropriate. Avoid inventing cryptography.
- Store sensitive data in a format that can be migrated. Include schema versioning from the first persistent model.
- Avoid third-party dependencies unless they provide substantial value, have a credible maintenance story, and do not weaken privacy or build reliability.

## Privacy requirements

- No analytics, advertising SDKs, trackers, fingerprinting, or hidden telemetry.
- No network access for scanning, enhancement, OCR, or search unless the user explicitly enables a clearly described future feature.
- Do not request contacts, location, microphone, photo-library, or network permissions unless the feature truly needs them. Explain every requested permission in user-centered language.
- Make export destinations and formats explicit. Do not silently copy documents to cloud storage or retain temporary exported files longer than necessary.
- Keep temporary images, OCR intermediates, logs, crash diagnostics, and caches free of unnecessary sensitive content. Delete temporary data promptly and safely.
- Redact or avoid document contents in debug logs. Never log raw images, recognized text, filenames containing sensitive information, or security-related secrets.
- Include a simple privacy README or in-app privacy explanation that states what stays local, what permissions are used, and what the app does not collect.
- When adding a feature, ask: what is the minimum data it needs, where does that data live, how long does it live, and how can the user remove it?
- Add option for user to create secured crypted folders that can be accessed via biometrics or password

## UX expectations

- Start with the scanner, not an empty dashboard full of setup work.
- Support one-tap capture as well as manual capture and recapture.
- Give immediate visual feedback for page detection, capture, processing, save completion, and errors.
- Make multi-page scanning natural: clear page count, reorder, retake, delete, and finish controls.
- Provide a review screen before committing changes. Make crop, rotate, filter, and enhancement easy to understand and undo.
- Make failure states useful: explain what happened and provide the next action, without blaming the user.
- Make saved documents easy to browse by recency and name. Keep naming lightweight and editable.
- Search should work locally and transparently. Clearly distinguish OCR text from user-entered metadata.
- Make export/share a deliberate action with a preview of the destination and format when possible.
- Support dark mode, Dynamic Type, VoiceOver, keyboard navigation where relevant, iPad layouts, and localization-ready strings from the beginning.

## Engineering workflow

- Before coding, write a short user story and define the smallest useful vertical slice.
- Build in thin end-to-end increments: capture, review, save, browse, OCR, search, then export and polish.
- Keep changes small and easy to revert. Avoid broad rewrites while a feature is still being learned.
- Explain non-obvious choices in code comments or lightweight decision notes, especially when learning a framework or choosing a privacy boundary.
- Use previews, sample documents, and local fixtures to iterate quickly without depending on external services.
- Test on the simulator and at least one real device when camera behavior, performance, haptics, storage, or permissions are involved.
- Treat compiler warnings, concurrency warnings, accessibility issues, and data-loss risks as work to resolve—not noise to suppress.

## Quality bar

Every meaningful change should include the appropriate combination of:

- Unit tests for document models, naming, transformations, OCR parsing, search, migrations, and permission-independent logic.
- UI tests for the main scan-to-save flow, multi-page editing, deletion/undo, and export confirmation.
- Performance checks for large images, multi-page documents, OCR, launch time, and memory pressure.
- Manual verification of camera permissions, denial/recovery, interrupted capture, app relaunch, low storage, backgrounding, and failed exports.
- Accessibility verification with VoiceOver, Dynamic Type, contrast, reduced motion, and non-touch navigation.
- Privacy verification that network access remains absent or explicit, logs contain no sensitive content, temporary files are cleaned up, and delete actions remove the intended local data.

Do not claim a feature is complete until the happy path and the most likely failure path have both been exercised.

## Scope and prioritization

Prioritize features that improve the personal daily workflow: reliable capture, excellent image quality, quick review, local OCR, simple organization, and dependable export. Defer accounts, collaboration, sync, server-side processing, social features, and subscription mechanics until there is a demonstrated need.

When considering future scale, preserve these boundaries:

- Core scanning must remain useful offline.
- A future sync layer must be optional and replaceable.
- Local data formats and migrations must remain documented.
- Privacy settings must not become a dark pattern.
- Product complexity must earn its place through real use.

## Working style

The developer is building this to learn Swift and have fun. Encourage curiosity, visual feedback, small experiments, and tasteful personality. Choose a simple implementation when it teaches the underlying concept well. When there are multiple valid approaches, briefly explain the tradeoff and choose one rather than creating an abstraction framework.

It is fine to leave room for playful details—custom empty states, satisfying animations, thoughtful haptics, or a memorable app voice—as long as they are accessible, optional where appropriate, and never compromise privacy or task completion.

## Definition of done

A feature is done when it is useful on a real device, works offline, has an understandable UX, handles common errors, respects the privacy requirements above, is accessible, is tested at the appropriate level, and leaves the codebase easier to learn from than before.
