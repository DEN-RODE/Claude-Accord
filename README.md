# Claude-Accord · À Corps

**Appli pour accorder les instruments à cordes**, avec un module de solfège qui reconnaît et décompose les accords.

100 % locale et hors-ligne : aucune donnée n'est envoyée, aucune dépendance externe. Référence La₄ = 440 Hz, notation anglo-saxonne (C D E…) ou latine (Do Ré Mi…) au choix.

---

## Fonctionnalités

### Accordeur chromatique (micro)
- Détection de hauteur en temps réel (autocorrélation + interpolation parabolique).
- Aiguille ±50 cents avec code couleur vert / jaune / rouge, verdict « trop bas / juste / trop haut ».
- Cordes cliquables pour cibler une note précise, VU-mètre d'entrée.

### Instruments et accordages

| Instrument | Accordages |
|---|---|
| Guitare | Standard EADGBE, Drop D, ½ ton plus bas (Eb), Open G, Open D, DADGAD, 7 cordes (BEADGBE) |
| Basse | 4 cordes EADG, 5 cordes BEADG, Drop D |
| Ukulélé | Soprano/Concert GCEA, Ténor bas GCEA, Baryton DGBE |
| Violon | GDAE |
| Alto | CGDA |
| Violoncelle | CGDA |
| Contrebasse | EADG |
| Mandoline | GDAE |
| Banjo | 5 cordes Open G (gDGBD) |
| Piano / Clavier | Repères sur 88 touches (A0 à C8) |
| Harmonica | Diatonique en Do |
| Chromatique / Diapason | Toutes les notes, diapason La 440 |

### Solfège : décomposition d'accords
Tape un accord (`Cmaj7`, `F#dim`, `Rém`, `Solm7`…) et l'appli donne ses notes, ses intervalles et ses degrés, avec un clavier de piano illuminé.

Qualités reconnues : majeur, mineur, 5 (power chord), 6, m6, 7, maj7, m7, mMaj7, m7b5 (ø), dim, dim7, aug, sus2, sus4, add9, 9, maj9, m9, 11, 13.

Reconnaissance d'accord au micro via chromagramme (maj, min, 7, maj7, m7, dim, sus4, aug). La polyphonie reste approximative.

---

## Lancer l'appli

Le micro exige un contexte sécurisé : un double-clic sur le `.html` ouvre l'appli en `file://`, où le micro est bloqué. Les lanceurs servent l'appli sur `http://127.0.0.1` pour le débloquer.

| Méthode | Comment | Micro |
|---|---|---|
| Exécutable Windows | Double-clic sur `Construire-A-Corps-exe.bat` → génère `A-Corps.exe` → double-clic dessus | Oui |
| Sans compiler | Double-clic sur `Lancer-A-Corps.bat` (garder `A-Corps.html` à côté) | Oui |
| Navigateur seul | Ouvrir `A-Corps.html` | Non |
| Android (PWA) | Héberger `Android/PWA/` en HTTPS, puis « Ajouter à l'écran d'accueil » | Oui |
| Android (APK) | Compiler `Android/APK-WebView/` (voir `Android/LISEZ-MOI-ANDROID.txt`) | Oui |

SmartScreen peut alerter sur le `.exe` non signé : « Informations complémentaires » puis « Exécuter quand même ».

---

## Structure du repo

```
A-Corps.html                  L'appli complète (HTML + CSS + JS, fichier unique)
A-Corps-V1.html               Version précédente (archive)
A-Corps.cs                    Lanceur C# : embarque l'appli et la sert sur localhost
Construire-A-Corps-exe.bat    Compile A-Corps.exe avec le .NET intégré à Windows
Lancer-A-Corps.bat            Lance l'appli via un mini serveur PowerShell
LISEZ-MOI.txt                 Guide utilisateur
CLAUDE.md                     Notes techniques et règles de travail
Android/
  PWA/                        Version installable (manifest + service worker)
  APK-WebView/                Projet Android qui embarque A-Corps.html
  LISEZ-MOI-ANDROID.txt       Guide Android
```

**À savoir quand on modifie** : `A-Corps.html` est la source. Les copies `Android/APK-WebView/app/src/main/assets/A-Corps.html` (identique) et `Android/PWA/index.html` (identique + balises manifest, theme-color, icône iOS et enregistrement du service worker) doivent être resynchronisées après chaque modif.

---

## Pistes d'évolution
- Générateur de sons de référence (jouer chaque corde).
- Diagrammes d'accords guitare et mode tablature.
- Icône personnalisée pour l'exe, installateur unique.
- Meilleure reconnaissance polyphonique des accords.

## Historique
Voir [CHANGELOG.md](CHANGELOG.md).
