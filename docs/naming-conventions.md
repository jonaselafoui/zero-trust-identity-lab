### Benutzer

| Typ | UPN | Anzeigename | Beispiel |
|---|---|---|---|
| Mitarbeiter | `vorname.nachname@<domain>` | `Vorname Nachname` | `frank.mueller@<domain>` – „Frank Müller“ |
| Admin-Konto | `adm-vorname.nachname@<domain>` | `ADM Vorname Nachname` | `adm-thomas.becker@<domain>` |
| Break-Glass | `bg-xxxxxxx@<domain>` | `Break Glass xx` | `bg-1234567@<domain>` |

Regeln:
- UPN nur Kleinbuchstaben; ä → ae, ö → oe, ü → ue, ß → ss; Anzeigename behält Umlaute.
- Namensgleichheit: Ziffer anhängen (`max.mueller2`).
- **Nur Mitarbeiter haben eine `employeeId`** (`KE0001`–`KE0080`). Admin- und Break-Glass-Konten haben keine.
- Admin-Konten bekommen **keine Abteilung, keine Lizenz, kein Postfach**.

### Gruppen

Schema: `<Typ>-<Kategorie>-<Name>` · keine Umlaute, keine Leerzeichen.

| Präfix | Bedeutung | Beispiel |
|---|---|---|
| `SG-ABT-` | Abteilung | `SG-ABT-Entwicklung` |
| `SG-TEAM-` | Team innerhalb einer Abteilung | `SG-TEAM-Firmware` |
| `SG-ALL-` | Alle einer Personengruppe | `SG-ALL-Mitarbeiter` |
| `SG-ROLE-` | Persona/Funktion | `SG-ROLE-Fuehrungskraefte` |
| `SG-LOC-` | Standort | `SG-LOC-Hamburg` |
| `SG-CA-` | Conditional-Access-Ein-/Ausschluss | `SG-CA-Excl-BreakGlass` |
| `SG-LIC-` | Lizenzzuweisung | `SG-LIC-EntraP1` |
| `SG-APP-` | App-Zuweisung | `SG-APP-<AppName>` |
| `SG-PIM-` | Rollenzuweisbare Gruppe für PIM | `SG-PIM-Helpdesk` |
| `SG-CFG-` | Technische Konfiguration | `SG-CFG-GroupCreators` |

`SG` = Sicherheitsgruppe. Microsoft-365-Gruppen bekämen `M365-`

### Administrative Units

| Präfix | Bedeutung | Beispiel |
|---|---|---|
| `AU-` | normale Administrative Unit | `AU-Vertrieb` |
| `RMAU-` | Restricted Management AU | `RMAU-Tier0-Konten` |