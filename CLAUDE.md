# À Corps — Accordeur chromatique & spécialiste du solfège

Application web **100 % locale** (aucune donnée envoyée) qui : accorde un maximum
d'instruments au micro, reconnaît une note ou un accord, et **décompose** les accords
en notes / intervalles / théorie, comme un spécialiste du solfège.

La₄ = 440 Hz · Notation au choix : anglo-saxonne (C D E…) ou latine (Do Ré Mi…).

---

## Fichiers du projet

| Fichier | Rôle |
|---|---|
| `A-Corps.html` | **L'application complète** (un seul fichier : HTML + CSS + JS, sans dépendance). C'est le cœur du projet — tout le reste sert à la lancer. |
| `A-Corps.cs` | Source C# d'un lanceur autonome qui embarque l'app et la sert sur `localhost`. Sert à produire le `.exe`. |
| `Construire-A-Corps-exe.bat` | Double-clic → compile `A-Corps.exe` avec le **.NET intégré à Windows** (hors-ligne, sans installation). |
| `Lancer-A-Corps.bat` | Lance l'app sans compiler (serveur PowerShell local). Nécessite `A-Corps.html` à côté. |
| `A-Corps.exe` | *(généré sur la machine de l'utilisateur)* exécutable autonome. |
| `LISEZ-MOI.txt` | Instructions pour l'utilisateur final (3 façons de lancer). |

---

## Comment lancer

- **Vrai exécutable** : double-cliquer sur `Construire-A-Corps-exe.bat` → produit `A-Corps.exe` → double-cliquer dessus.
- **Sans compiler** : double-cliquer sur `Lancer-A-Corps.bat`.
- **Navigateur seul (sans micro)** : ouvrir `A-Corps.html`.

⚠️ **Le micro exige un contexte sécurisé.** Les navigateurs bloquent `getUserMedia`
sur `file://`. Les lanceurs (.exe / .bat) servent donc l'app sur `http://127.0.0.1`
(secure context), ce qui débloque le micro. Ouvrir le `.html` directement désactive
le micro mais conserve la décomposition d'accords par saisie.

---

## Architecture interne de `A-Corps.html`

Tout est en vanilla JS, organisé en blocs `<script>` :

1. **Théorie musicale**
   - `freqToNote(f)` : Hz → {midi, classe de note, octave, cents}. `midi = 69 + 12·log2(f/440)`.
   - `noteToFreq(midi)`, `nameToMidi("E2")`.
   - `INSTRUMENTS` : dictionnaire instrument → accordages → liste de cordes (ex. guitare
     Standard/Drop D/Open G/D/DADGAD/7 cordes/½ ton, basse 4-5, ukulélé, violon, alto,
     violoncelle, contrebasse, mandoline, banjo, piano, harmonica, chromatique/diapason).
   - `QUALITIES` : table des qualités d'accord (intervalles en demi-tons + noms de degrés).
     `parseChord()` accepte l'anglo (`Cmaj7`, `F#dim`) **et** le latin (`Rém`, `Solm7`),
     distingue note simple vs accord, renvoie notes + intervalles + degrés.

2. **Audio — détection de hauteur** : `getUserMedia` → `AnalyserNode` (fftSize 8192).
   `detectPitch()` = autocorrélation + interpolation parabolique (monophonique, pour l'accordeur).

3. **UI Accordeur** : aiguille `<canvas>` (±50 cents, vert/jaune/rouge), cordes cliquables
   pour cibler une note, VU-mètre, verdict trop bas/juste/trop haut.

4. **UI Accords** : saisie + `analyze()` (décomposition + clavier piano illuminé) ;
   reconnaissance micro via **chromagramme** (FFT → énergie par classe de note → matching
   de templates maj/min/7/maj7/m7/dim/sus4/aug). La polyphonie reste **approximative**.

---

## Décisions & contraintes (à connaître avant de modifier)

- **Pas de framework, pas de build** : `A-Corps.html` doit rester un fichier unique
  ouvrable tel quel. Toute lib externe casserait le « 100 % hors-ligne ».
- **Préférences utilisateur** : interface en français ; réponses concises.
- L'exe n'a **pas pu être cross-compilé** depuis l'environnement Cowork (Go/.NET/binaire
  Node Windows non téléchargeables). D'où l'approche « compilation locale via .NET intégré ».
- Le lanceur sert **la même page pour toute requête** (SPA mono-fichier) via un mini
  serveur TCP/HTTP (C# `TcpListener` ou PowerShell), pour éviter les ACL http.sys (`HttpListener`).
- Vérifications déjà faites : conversions Hz↔note↔cents validées sur fréquences de
  référence (A4=440, E2=82.41, etc.) ; décompositions d'accords validées (C, Am, G7,
  Cmaj7, Dm7, Bm7b5, Fdim, Eaug, Cadd9). Re-tester après toute modif de la théorie.

## Pistes d'évolution demandées / possibles
- Générateur de sons de référence (jouer chaque corde).
- Mode tablature / diagrammes d'accords guitare.
- Icône personnalisée pour l'exe ; installateur unique (setup).
- Améliorer la reconnaissance polyphonique d'accords.
