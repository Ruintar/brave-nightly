**If you only want the stable version of Brave, you can use the [Flatpak instead](https://flathub.org/apps/details/com.brave.Browser), which is probably a more secure and easier way to install Brave.**

# brave-nightly package for Void Linux

This package provides Brave Browser Nightly, the nightly development version of Brave, a browser based on Chromium with privacy in mind and a built-in ad blocker.

This package merely takes the `.deb` nightly release from the authors, extracts and installs the files as is, while ensuring the required dependencies are present. **Note:** This repackages binaries instead of building from source.

Because this is the Nightly channel, it may contain bugs, regressions, or other unstable behavior.

The template file is prepared for use with [xbps-src](https://wiki.voidlinux.org/Xbps-src) in Void Linux.

## Installation & update

```sh
# Setup - do it once if not done already:
git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
git clone -b mv2-support https://github.com/Ruintar/brave-nightly ./srcpkgs/brave-nightly

# To install and update Brave Nightly:
git -C ./srcpkgs/brave-nightly pull
./xbps-src pkg brave-nightly
sudo xbps-install --repository hostdir/binpkgs brave-nightly
```

---

## 📌 Manifest V2 (MV2) Support Branch

> [!WARNING]  
> **This branch is frozen.** Automatic updates are disabled here to preserve the last functional version of Brave Nightly that supports Manifest V2 (MV2) extensions.

### Why is this branch frozen?
Brave Nightly has deprecated MV2 support in favor of MV3 in the main branch (`master`). This branch was created from a past commit to keep the MV2-compatible version intact for legacy extension support. 

* **Status:** Nightly / Legacy
* **Automations:** Disabled (No auto-updates)

---

## Project Status & Maintenance Notice

This repository is maintained primarily for personal use and convenience. It is publicly available and anyone is welcome to use it; however, please be aware of the following:

- I am a relatively new maintainer.
- Updates are performed according to my own needs and availability.
- No guarantees are provided regarding long-term maintenance, response time to issues, or compatibility across all Void Linux configurations.
- This repository is unofficial and not affiliated with the Void Linux project.
