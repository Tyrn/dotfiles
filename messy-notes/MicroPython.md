## MicroPython

### On Linux

- Clone [MicroPython](https://github.com/micropython/micropython) into `~`, and build it

- Check result (and run it):
```
$ where micropython
~/micropython/ports/unix/build-standard/micropython
```

### Embedded (mostly ESP32), the easiest way 

- Install [esptool](https://github.com/espressif/esptool):
```
$ yay -S esptool
```
- Install [Thonny IDE](https://linuxhint.com/micropython-esp32-thonny-ide/):
```
$ yay -S thonny
```
- Consult [downloads](https://micropython.org/download/) (scroll down)

- Download [ESP32 firmware, generic](https://micropython.org/download/esp32/), e.g. to `~/Downloads`

#### Reference

- [ESP-IDF](https://www.espressif.com/en/products/sdks/esp-idf), Espressif IoT Development Framework (MicroPython build tool)

- [Thonny Wiki](https://github.com/thonny/thonny/wiki)

- [Thonny, Upload multiple files/folders to esp32 at once](https://groups.google.com/g/thonny/c/7gyz0THi22M?pli=1)

- [micropython-lib](https://pypi.org/user/micropython-lib/) (What is it?)

- [MicroPython Stubber](https://github.com/Josverl/micropython-stubber)

- [MicroPython Stubs](https://github.com/Josverl/micropython-stubs)

- Unit testing not working as expected, [#10275](https://github.com/orgs/micropython/discussions/10275)

- [micropy-cli](https://www.agilepartner.net/en/micropython-esp8266-and-vscode/)

#### Examples

- [Thonny, multifile project](https://techexplorations.com/guides/esp32/micropython-with-the-esp32/14-micropython-programming-with-files/)

- [ESP32 BLE](https://techtotinker.com/2021/08/025-esp32-micropython-esp32-bluetooth-low-energy/)

- [HD44780, RPi Pico](https://raphaelkabo.com/blog/pi-pico-hd44780/)

- [HD44780, ESP32, ESP8266](https://microcontrollerslab.com/i2c-lcd-esp32-esp8266-micropython-tutorial/)

#### Thonny Tips and Tricks

- Remember that access to MicroPython shell is possible only when the flashed firmware is running, so use RST button.
Use Ctrl-F2 on the dead red console; use Ctrl-C on not quite good console; use Ctrl-D on Python shell `>>>` whenever you want.

#### Micropy Cli and rshell

- Create a project
```
$ mkdir hello
$ cd hello/
$ python -m venv .venv
$ source .venv/bin/activate
(.venv) $ pip install micropy-cli
(.venv) $ pip install rshell
(.venv) $ pip install pylint
(.venv) $ pip install micropython-esp32-stubs
...
```
- ...or adopt a cloned Poetry project
```
$ git clone .../hello.git
$ cd hello
$ poetry install
$ poetry shell
(.venv) $
```
- ...initialize newly created or adopted project
```
(.venv) $ cd ..
(.venv) $ micropy init hello    # Agree to "Settings for Autocompletion", if you have all cloned and already here.
...
(.venv) $ micropy stubs add micropython-esp32-stubs-1.20.0.post1
(.venv) $ cd hello
```
- Start `rshell` in the project directory
```
(.venv) $ rshell -p /dev/ttyUSB0
...
> help
```
- Inside `rshell`, follow this pattern:
```
repl.C-d         => soft_reboot; mcu.running
    .C-x         => rshell; mcu.?

soft_reboot.C-c  => repl; mcu.?
          [.C-x  => rshell; mcu.?; game_over]
```
