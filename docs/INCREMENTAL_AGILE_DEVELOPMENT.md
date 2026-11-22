# Incremental Agile Development Evidence

## Scope and evidence policy

The repository history currently contains a complete project snapshot, not separate commits for every original development phase. The milestone breakdown below is a **reconstructed architectural model**, not a claim that each milestone was an actual historical Git commit.

All improvements documented here were made on branch `incremental-agile-improvements` after the original snapshot. Git commit hashes, GitHub Issues, pull requests, and CI runs will be recorded only after they exist.

## Incremental Development Model

The project is developed as a sequence of deployable, verifiable increments. Each increment preserves existing behavior and adds or hardens one area. Agile practices are demonstrated through a visible backlog, short example sprints, acceptance criteria, tests, retrospectives, and reviewable pull requests.

## Reconstructed incremental architecture

### 1. Authentication and project foundation
- Functionality: Firebase initialization, role-gated authentication, Student/Officer/Director dashboards, registration, profile access.
- Dependencies: Firebase Core/Auth/Firestore, Flutter routing, `AuthGate`, `AuthService`, student auth mapper.
- Acceptance: valid roles route to the correct dashboard; unknown/missing profiles show an access error; staff roles cannot be self-created as students.
- Testing: role mapper/unit tests and isolated splash/widget tests.
- Known limitations: password reset UI is not implemented and Firebase setup is platform-specific.
- Improvement completed: Android Firebase options are restored and live smoke testing is opt-in rather than default.

### 2. Student services
- Functionality: service request submission, tracking, document upload, legacy character certificate and hall transfer compatibility.
- Dependencies: Firestore, Storage, request models, notification and history services.
- Acceptance: supported category, non-empty title, and at least 20 description characters are accepted; invalid input is rejected consistently.
- Testing: model serialization/lifecycle tests and submission validation tests.
- Known limitations: some legacy screens still use mock data and the submission UI can be improved with inline field errors.
- Improvement completed: request submission now validates the category, title, and description at the service boundary.

### 3. Complaint and request management
- Functionality: complaint submission, tracking, status history, attachments, duplicate detection and staff management.
- Dependencies: Firebase Auth/Firestore/Storage, complaint model/service, AI service.
- Acceptance: category, title, description, office, and urgency are complete; status history remains available.
- Testing: new complaint validation tests; emulator tests for rules and history remain planned.
- Known limitations: production Firebase writes are not emulator-isolated in every integration path.
- Improvement completed: complaint submissions validate required fields and trim stored text.

### 4. DSW administrative workflow
- Functionality: officer review, resubmission, director approval/rejection/resolution, audit logs and notifications.
- Dependencies: Firestore role profiles, history subcollections, audit-log and notification services.
- Acceptance: only valid status transitions are accepted; staff role and expected status are enforced.
- Testing: transition unit tests plus planned emulator tests for direct Firestore rule enforcement.
- Known limitations: final decision actions are partly UI-dependent and emulator coverage is incomplete.
- Improvement completed: centralized `ServiceRequest.isValidTransition` guard added to model and service checks.

### 5. Gemini AI integration
- Functionality: form checks, complaint triage, request priority/duplicate/image analysis and analytics prompts.
- Dependencies: `firebase_ai`, Firebase AI Logic/Gemini, Firestore records and Storage paths.
- Acceptance: AI output is structured, handled as advisory, and failure never blocks official decisions.
- Testing: deterministic local AI service tests and priority separation tests.
- Known limitations: no live Gemini credentials in tests; no offline cache or formal prompt/evaluation suite.
- Improvement completed: emergency triage and advisory-office behavior now have unit coverage.

### 6. Testing, security, and documentation
- Functionality: Flutter unit/widget tests, Firestore/Storage rules, App Check, setup and operations documentation.
- Dependencies: Flutter SDK, Firebase projects, emulator tooling, GitHub Actions.
- Acceptance: formatting, analysis and tests run automatically; live data writes require explicit opt-in.
- Testing: local format/test/analyze checks and GitHub Actions verification.
- Known limitations: emulator rule tests, Firebase deployment automation and FCM delivery are future work.
- Improvement completed: Dart formatting, widget isolation, opt-in live smoke test, and Flutter CI workflow.

## Product backlog

| ID | Area | Story | Priority | Incremental acceptance |
|---|---|---|---|---|
| PB-01 | Auth | Prevent unsafe live smoke writes in normal test runs | High | Live test is skipped unless explicitly enabled |
| PB-02 | Student | Reject incomplete service submissions | High | Invalid category/title/description tests pass |
| PB-03 | Complaints | Reject incomplete complaint submissions | High | Required fields and minimum description are validated |
| PB-04 | Admin | Centralize workflow transition validation | High | Invalid public transitions are rejected and tested |
| PB-05 | AI | Expand deterministic AI triage coverage | Medium | Emergency mapping remains advisory and structured |
| PB-06 | CI | Run format/analyze/test in GitHub Actions | High | Workflow executes automatically and reports status |
| PB-07 | Docs | Document reconstructed milestones and backlog | Medium | Architecture, criteria, limitations and evidence are complete |
| PB-08 | Security | Add Firebase Emulator rule tests | High | Ownership and role transitions are tested without production data |
| PB-09 | Accessibility | Audit labels and semantics | Medium | Login, form, status and navigation controls have accessible names |
| PB-10 | Operations | Add server-side AI and notification trust boundary | Low | Sensitive enrichment and fan-out move out of the client |

## Sprint planning examples

These are **example planning exercises**, not verified historical sprint records.

### Example Sprint 1 — Safety and foundation
- Goal: make tests deterministic and restore Android build configuration.
- Selected: PB-01.
- Acceptance: application compiles, live smoke test is opt-in, widget tests do not initialize production Firebase.
- Evidence: commit `702041354f6b1ba3f7f240b327fe2dfb91e70139`.

### Example Sprint 2 — Submission validation
- Goal: improve student and complaint input safety.
- Selected: PB-02, PB-03.
- Acceptance: invalid fields throw `StateError` and focused tests pass.
- Evidence: commits `6a9b61f` and `f6ae535`.

### Example Sprint 3 — Workflow, AI, and CI
- Goal: strengthen administrative and AI boundaries and automate checks.
- Selected: PB-04, PB-05, PB-06.
- Acceptance: transition tests pass, emergency triage remains advisory, CI workflow is present.
- Evidence: commits `b281169`, `34b297c`, and the CI workflow commit.

## Actual GitHub artifacts

- Repository: https://github.com/MOHAMMEDHASANMOZUMDER/CUET-DSW-smart-management-system-app
- Working branch: `incremental-agile-improvements`
- Existing open Issues: none as of the 2026-11-22 repository inspection.
- Existing open pull requests: none as of the 2026-11-22 repository inspection.
- New issue and pull request links: to be inserted after GitHub artifacts are created.

## Acceptance criteria

1. Existing application features remain functional.
2. Each improvement is small and reviewable.
3. Validation changes do not replace existing UI or workflow features.
4. Unit/widget tests cover new behavior and do not write production Firebase data.
5. Flutter format, analyze, and test commands complete successfully.
6. GitHub Actions does not deploy Firebase.
7. Git history shows genuine commits on a separate branch.

## Testing evidence

Local verification was run with Flutter 3.35.7 and Dart 3.9.2:

- `dart format --output=none --set-exit-if-changed lib test`: pass, 0 changed files.
- `flutter test`: pass, 12 tests passed, 1 live Firebase smoke test skipped.
- `flutter analyze`: pass, no issues.
- The live Firestore smoke test is opt-in with `RUN_FIREBASE_CONNECTION_TEST=true`; it must target an approved emulator/development project.

## Changes completed during this improvement exercise

- Restored Android Firebase options and removed `firebase_options.dart` from the ignore list.
- Prevented the live Firebase smoke test from running in normal test suites.
- Isolated splash/widget tests from production Firebase initialization.
- Formatted Dart sources for a dependable format check.
- Added service request submission validation and tests.
- Added complaint submission validation and tests.
- Added a service workflow transition guard and tests.
- Added emergency AI triage test coverage.
- Added a GitHub Actions workflow for pub get, format, analysis and tests.

## Retrospective observations

### What went well
- The baseline exposed concrete build/test risks rather than assumed quality.
- Pure validation and deterministic tests could be added without disrupting Firestore workflows.
- Small commits preserve a clear review trail.

### What needs improvement
- Emulator tests and live Gemini testing are not yet automated.
- Existing Firebase-dependent widget/navigation tests need emulator/mocking infrastructure.
- CI status must be confirmed from an actual GitHub Actions run.

## Known limitations

- The AI integration is advisory and deterministic tests do not validate live Gemini output.
- Firestore/Storage emulator tests are not present in the default suite.
- Web Firebase configuration is not included.
- Push delivery, server-side notification fan-out, and Cloud Functions are not implemented.
- No claim is made that existing Firebase rules passed production attack testing.

## Future improvements

- Add Firebase Emulator Suite tests for rules and workflow transitions.
- Add secrets-safe CI for explicitly approved emulator integration tests.
- Improve inline form validation and accessibility semantics.
- Add password reset and account recovery flows.
- Move AI enrichment and notification fan-out to trusted server-side code.
- Add accessible status announcements and keyboard/web review checks.
- Add FCM delivery and privacy/retention policies for institutional production.
