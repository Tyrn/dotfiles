## Android Studio
*IDE for mobile development (mostly flutter)*

- :snowflake: - supposedly obsolete entry.

### Notes

- Directories to be most heavily populated:
    - `~/Android/Sdk`
    - `~/.local/share/JetBrains`

- Important directories:
    - `~/.local/share/JetBrains/Toolbox/apps/android-studio` (JBR (JetBrains Runtime) and things)
    - `~/.local/share/JetBrains/Toolbox/scripts` (IDE starters, like **pycharm** and **studio**)

- [Run Anything](https://www.jetbrains.com/help/idea/running-anything.html): Ctrl Ctrl

### Install

- Get JetBrains Toolbox:
```
$ yay -S jetbrains-toolbox
```
- In case of [Unable to find bundled Java version on Flutter](https://stackoverflow.com/questions/51281702/unable-to-find-bundled-java-version-on-flutter) trouble, create a soft link:
```
$ cd ~/AndroidStudio
$ ln -s jbr jre
```
- Make sure *File > Settings > Appearance & Behavior > System Settings > Android SDK > SDK Tools > Android SDK Command Line Tools (latest)* gets checked and installed;

- With `flutter doctor`, `cmdline-tools` component is probably still [missing](https://stackoverflow.com/questions/68236007/i-am-getting-error-cmdline-tools-component-is-missing-after-installing-flutter); make it available:
```
$ flutter config --android-sdk ~/Android/Sdk
```
- The relevant part of `~/.xprofile` may look like this (mostly unnecessary?):
```
export PATH=/opt/flutter/bin:$PATH
export ANDROID_HOME=~/Android/Sdk
export PATH=$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest:$PATH
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
```
- Manage permissions (relogin required): :snowflake:
```
$ sudo groupadd flutterusers
$ sudo gpasswd -a $USER flutterusers
```
- Check:
```
$ flutter doctor
```
