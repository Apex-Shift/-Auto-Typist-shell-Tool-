# Auto-Typist Tool 🚀

A cross-platform utility designed to bypass restrictive user interfaces where copy-paste operations are blocked or disabled (e.g., specific web forms, secure terminals, virtual desktops like Citrix/VMware, or online exams). It simulates real keyboard strokes to safely inject your text.

Ce projet fournit un outil multi-plateforme pour contourner le blocage du copier-coller dans les champs de saisie protégés. Il simule des pressions de touches réelles sur votre clavier.

---

## 💻 Windows Version (`AutoTypist.vbs`)

A lightweight, standalone VBScript. No installation required, runs natively on any Windows environment.

### 🛠️ Features (Windows)
- **Zero Hardcoding**: Prompts you via an input box to paste your text at runtime.
- **Special Characters Protection**: Automatically escapes reserved VBScript `SendKeys` symbols (`{`, `}`, `+`, `^`, `%`, `~`, `(`, `)`, `[`, `]`) to prevent layout crashes.
- **Turbo Mode**: Types long paragraphs almost instantly (5ms delay).
- **Human Mode**: Adds randomized delays and punctuation pauses to mimic natural typing.

### 📖 How to Use (Windows)
1. Double-click `AutoTypist.vbs`.
2. Paste your text into the popup box and click **OK**.
3. Choose your speed profile (**Yes** for Turbo, **No** for Human speed).
4. Click **OK** on the preparation prompt. You have **3 seconds** to focus/click inside your target input field.

---

## 🐧 Linux Version (`autotypist_gui.sh`)

A native Bash script featuring a complete Graphical User Interface (GUI) powered by `zenity`.

### 🧰 Prerequisites (Linux)
Before running the script, you must install `xdotool` (keyboard simulator) and `zenity` (GUI windows manager). Run the following command in your terminal:

```bash
sudo apt update && sudo apt install xdotool zenity
```
*(For Fedora/RHEL: `sudo dnf install xdotool zenity`)*

### 🛠️ Features (Linux)
- **Full GUI**: No terminal required during execution; interactive dialog boxes handle inputs.
- **Visual Countdown**: Displays a progress bar counting down the remaining seconds before typing starts.
- **Native Encoding**: Automatically supports all special characters without complex escaping.

### 📖 How to Use (Linux)
1. Give execution permissions to the script:
   ```bash
   chmod +x autotypist_gui.sh
   ```
2. Double-click the script in your file manager and select **"Run / Execute"** (or launch it via `./autotypist_gui.sh`).
3. Paste your text into the graphical window.
4. Select your preferred speed mode from the interactive list.
5. Watch the countdown progress bar and click on your target input field before it reaches 100%.

---

## ⚠️ Important Notes & Security / Notes Importantes

- **Antivirus False Positives**: Because these scripts automate keyboard keystrokes (`SendKeys` / `xdotool`), strict heuristic antivirus or security software might flag them as suspicious. This is a false positive. You can inspect the open-source code yourself to verify it operates entirely locally.
- **Faux Positifs Antivirus**: Parce que ces scripts simulent des frappes de touches, certains antivirus stricts peuvent les catégoriser comme suspects. Le code étant 100% open-source, vous pouvez l'inspecter pour vérifier qu'il est totalement sain et local.
- **Active Window Dependency**: Do not switch windows while the script is actively typing, or it will inject the remaining text into whatever application you switched to.
- **Focus de la Fenêtre**: Ne changez pas de fenêtre pendant que le script écrit, sous peine d'injecter le reste du texte dans la mauvaise application.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
