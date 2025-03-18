# GNOME 47 and upwards

Mostly Fedora

- Update/[Upgrade](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/) System, see also
  [dnf cheat sheet](https://opensource.com/sites/default/files/gated-content/osdc_cheatsheet-dnf-2021.5.15.pdf)

```
sudo dnf update --refresh
sudo dracut -f regenerate-all
```

NB `dnf update` means `dnf upgrade` as of 2023

- Check System
  - Settings > System > About > System Details
- Check [Extensions](https://docs.fedoraproject.org/en-US/quick-docs/gnome-shell-extensions/)
  - Install Extension app 🧩
  ```
  sudo dnf install gnome-extensions-app -y
  ```
