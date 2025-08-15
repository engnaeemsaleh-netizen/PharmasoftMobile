
# PharmaSoft Pro (Prototype)

A Flutter prototype for a pharmacy accounting & admin app. Multi-tenant by design:
- Set pharmacy name, language (AR/EN/FR), and theme from Settings.
- Placeholder screens for Sales, Purchases, Inventory, Expenses, Reports, Employees, Clients & Suppliers.
- Local persistence for basic settings. Ready to integrate SQLite for data and add APIs later.
- Export to PDF/Excel planned via included deps.

## Quick Start

1) Install Flutter SDK.
2) Create a new project:
   ```bash
   flutter create pharmasoft_pro
   ```
3) Replace the generated `lib/` and `pubspec.yaml` with the ones from this package.
   Also copy the `assets/` folder.
4) Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Next Steps (Development Roadmap)
- Implement SQLite schema for items, invoices, suppliers, clients, employees, expenses.
- Add barcode scanning on Sales and Inventory screens.
- Add authentication & roles (admin/manager/cashier).
- Add reports generation (PDF/Excel) and printing.
- Add data backup/sync (e.g., Firebase or custom API).
- Add expiry alerts and low-stock notifications.


---
## DB & CRUD Implemented (Phase 1)
- **SQLite schema** for `items` and `expenses` (v1).
- **Repositories (DAOs)** for items & expenses.
- **Inventory screen** now lists, searches, adds, edits, deletes items.
- **Expenses screen** now lists, adds, deletes expenses.
- Ready to add: suppliers/clients/employees/invoices (same pattern).



## Build APK in the Cloud (No PC Setup)
- Push this project to GitHub.
- Go to **Actions** tab → run **Flutter Android Debug APK** workflow.
- Download `app-debug.apk` from the workflow **Artifacts**.
- For signed release, configure secrets as documented in `android/keystore/README_SIGNING.md` then run **Flutter Android Release APK (Signed)**.
