# Auto-Typist Tool (Linux GUI Version) 🐧🚀

A native Bash utility featuring a complete Graphical User Interface (GUI) designed to bypass restrictive user interfaces where copy-paste operations are blocked or disabled (e.g., specific web forms, secure terminals, virtual desktops like Citrix/VMware, or online exams). It simulates real keyboard strokes using `xdotool`.

Ce script Bash fournit une interface graphique complète pour contourner le blocage du copier-coller dans les champs de saisie protégés sous Linux en simulant des pressions de touches réelles.

---

## 🧰 Prerequisites / Prérequis

Before running the script, you must install `xdotool` (the keyboard simulator) and `zenity` (the GUI windows manager). Open your terminal and run the appropriate command for your distribution:

Avant de lancer le script, vous devez installer `xdotool` et `zenity`. Ouvrez votre terminal et exécutez la commande correspondant à votre système :

*   **Ubuntu / Debian / Linux Mint / Pop!_OS:**
    ```bash
    sudo apt update && sudo apt install xdotool zenity
    ```
*   **Fedora / RHEL / CentOS:**
    ```bash
    sudo dnf install xdotool zenity
    ```
*   **Arch Linux / Manjaro:**
    ```bash
    sudo pacman -S xdotool zenity
    ```

---

## 🛠️ Features / Fonctionnalités

- **Full GUI (Zenity)**: No terminal required during execution. Interactive dialog boxes handle all inputs and options.
- **Visual Countdown**: Displays a real-time progress bar counting down the remaining seconds before typing starts.
- **Dual Speed Modes**: 
  - *Turbo Mode*: Instantly drops the text into the field.
  - *Human Mode*: Introduces randomized natural delays and punctuation pauses.
- **Native Encoding**: Automatically supports all special characters and symbols without needing complex string escaping.

---

## 📖 How to Use / Mode d'emploi

1. **Give execution permissions** to the script by running this command in your terminal:
   ```bash
   chmod +x autotypist_gui.sh
   ```
2. **Launch the script**: Double-click the file in your graphical file manager and select **"Run / Execute"** (or run `./autotypist_gui.sh` from your terminal).
3. **Paste your text** into the graphical input window and click **OK**.
4. **Select your speed mode** from the interactive list.
5. **Watch the countdown progress bar** and quickly click inside your target input field before the countdown reaches 100%.

---

## ⚠️ Important Notes / Attention

- **Active Window Dependency**: Do not switch windows while the script is actively typing, or it will inject the remaining text into whatever application you switched to.
- **Focus de la Fenêtre**: Ne changez pas de fenêtre pendant que le script écrit, sous peine d'injecter le reste du texte dans la mauvaise application.
- **Wayland Compatibility**: This script relies on `xdotool`, which is native to X11 sessions. If your Linux distribution uses Wayland by default (like newer Ubuntu or Fedora releases), make sure `XWayland` is enabled or switch to an X11/Xorg session at login if keys are not dropping correctly.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
