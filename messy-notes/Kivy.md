## Kivy framework
### Miscellany
Groups:
```
$ sudo gpasswd -a user input
```
Input, laptop touch pad (`~/.kivy/config.ini`):
```
...
[input]
mouse = mouse
#%(name)s = probesysfs
...
```
Location:
```
import os, kivy
os.path.dirname(kivy.__file__)
```
Gstreamer:
```
yaourt -S gst-plugins-ugly
```
KivyMD
```
$ pip install kivymd --user -v
```
Examples on the system: `/usr/share/kivy-examples`

### Signing APKs

[Merge/install split APKs](https://stackoverflow.com/questions/55212788/is-it-possible-to-merge-install-split-apk-files-aka-app-bundle-on-android-d)
[Signing tools: uber-apk-signer, etc.](https://stackoverflow.com/questions/4853011/how-to-sign-an-android-apk-file)
[Uber Apk Signer Showcase](https://asciinema.org/a/91092)
[Debug Kivy for Android](https://stackoverflow.com/questions/59384085/how-to-debug-a-kivy-kivymd-app-for-android)
[Bundletool](https://www.north-47.com/knowledge-base/bundletool-and-how-to-utilize-android-app-bundle/)

### Resources
[Reference](https://kivy.org/docs/)
[Widget positioning](https://blog.kivy.org/2014/01/positionsize-of-widgets-in-kivy/)

### Buildozer
#### Building [Buildozer](https://github.com/kivy/buildozer) from source
*2019-10-9*; *Python 3*

- Configure toolchain:
```
$ archlinux-java status
Available Java environments:
  java-13-jdk
  java-8-openjdk (default)
```
Everything C/C++ assumed (`autoconf` certainly features prominently :smiley_cat:)

- Supply `adb` (`archlinuxcn` repo required):
```
$ sudo pacman -S android-sdk-platform-tools
```
- Supply `libtinfo` (`archlinuxcn` repo required):
```
$ sudo pacman -S ncurses5-compat-libs
```
- Supply LLVM linker and Cython:
```
$ sudo pacman -S lld cython
```
- Clone:
```
$ cd
$ git clone https://github.com/kivy/buildozer
$ cd buildozer
$ python setup.py build
$ sudo pip install -e .
```
- `cd` to your (first ever, "Hello, World!" in `main.py`) project directory, then
```
$ buildozer init
```
- Edit `buildozer.spec`:
```
android.accept_sdk_license = True
# Optionally:
requirements = python3,kivy,kivymd
## Good for Android 5.0:
android.minapi = 21
android.ndk_api = 21

```
- Build:
```
$ buildozer android debug
```
- Upload to the mobile device via USB:
```
$ adb install -r bin/*.apk
```
NB The first run ever takes a lot of time. Android SDK/NDK gets downloaded, all the specific tools get compiled. Some build results go into the global `~/.buildozer` directory, some in the project `.buildozer` directory. The `*.apk` target goes into the project `bin` directory. You will certainly need `cython` as a dependency, global or in the project virtual environment; probably also `pygame` (deprecated).


#### Building Buildozer docker image

- Build basic image:
```
$ cd
$ git clone https://github.com/kivy/buildozer
$ cd buildozer
$ docker build --tag=buildozer .
$ docker run --volume "$(pwd)":/home/user/hostcwd buildozer --version
```

#### Create your own (Git) project to be used with dockered buildozer

- Create build directories, once for the project's lifetime:
```
$ mkdir .buildozer
$ echo "*" >> .buildozer/.gitignore
$ git add .buildozer/.gitignore
$ mkdir .gradle
$ echo "*" >> .gradle/.gitignore
$ git add .gradle/.gitignore
```
- Create `docker-compose.yml`:
```
services:
  buildozer:
    image: buildozer:latest
    volumes:
      - .:/home/user/hostcwd
      - ./.buildozer:/home/user/.buildozer
      - ./.gradle:/home/user/.gradle
```
- Run `buildozer` in the project directory:
```
$ docker-compose run buildozer <...>
```

#### ADB

```
$ docker-compose run buildozer android debug
$ adb install -r bin/*.apk
$ adb devices
$ adb logcat -s "python"  ;; Drop quotes safely :)
```
