### Neovim

**Windows - Admin Powershell**
```
New-Item -Path "~/AppData/Local/nvim" -ItemType SymbolicLink -Target "./nvim"
```

```
New-Item -Path "~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Target "./Microsoft.PowerShell_profile.ps1"
```

### Git hooks

Hooks live in `hooks/`. Enable them once per clone:
```
git config core.hooksPath hooks
```

### Kando (macOS)

Kando writes its settings in place, so the files are symlinked and every change shows up here directly. Quit Kando before linking.
```
for f in config.json menus.json icon-themes menu-themes; do
  rm -rf ~/Library/Application\ Support/kando/$f
  ln -s ~/Projects/configs/kando/$f ~/Library/Application\ Support/kando/$f
done
```
`/Applications/Kando.app` is a patched build (the `kando/main` branch of the `forks` repo); `config.json` and `menus.json` use settings that only it understands.

### BetterTouchTool (macOS)

BetterTouchTool keeps its configuration in a private database, so it is stored here as an export of the `Default` preset, including general settings. `bettertouchtool/export.sh` refreshes `bettertouchtool/Default.bttpreset`; the pre-commit hook runs it and stages the result, so every commit carries the current setup. Run it by hand to update without committing.

To restore, import `bettertouchtool/Default.bttpreset` from BetterTouchTool's preset menu, or:
```
osascript -e 'tell application "BetterTouchTool" to import_preset "'"$HOME"'/Projects/configs/bettertouchtool/Default.bttpreset"'
```