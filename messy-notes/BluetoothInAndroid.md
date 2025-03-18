## Bluetooth

*by Tony Gaitatzis*

### Chapter 1

#### Introduction

Bluetooth Low Energy with Java on Android.

Tutorial projects:

- A Beacon and Scanner
- An Echo Server and Client
- A Remote Controlled Device

Basic concepts:

- How BLE works
- How data is sent and received
- Common paradigms for handling data

#### Overview

Architecture:

- hub-and-spoke model
    - single Central, may hold several connections
        - scanning mode
        - connected mode
    - multiple Peripherals, each may hold one connection at a time. The Peripheral must be advertising to be seen by the Central
        - advertising mode
        - connected mode

##### Advertising

A Peripheral advertises by advertising its device name and other information on one radio frequency, then on another in a process known as frequency hopping.

##### Scanning

Similarly, the Central listens for a server’s advertisement first on one radio frequency, then on another until it discovers an advertisement from a Peripheral.

Each device has a unique media access control address (MAC address) that identifies it on the network. Peripherals advertise this MAC address along with other information about the Peripheral’s settings.

##### Connecting

While connected, the Peripheral may not connect to any other device.

##### Disconnecting

A Central may disconnect from a Peripheral at any time. The Peripheral is aware of the disconnection.

##### Communication

*Characteristics* are provided by the Peripheral for the Central to access.

A Characteristic may have one or more properties, for example READ or WRITE. Each Characteristic belongs to a Service, which is like a container for Characteristics. This paradigm is called the Bluetooth Generic Attribute Profile (GATT).

The GATT paradigm is laid out as follows (GATT structure example):

- Profile
    - Service
        - Characteristic
        - Characteristic
        - Characteristic
    - Service
        - Characteristic
        - Characteristic
        - Characteristic

To transmit or request data from a Characteristic, a Central must first connect to the Characteristic’s Service.

For example, a heart rate monitor might have the following GATT profile, allowing a Central to read the beats per minute, name, and battery life of the server.

- Example Heartrate Monitor
    - Device Info
        - Name
        - Manufacturer
        - Battery Life
    - Heartrate Data
        - Beats Per Minute
        - Highest BPM
        - Lowest BPM

In order to retrieve the battery life Characteristic, the Central must be connected also to the Peripheral's *Device Info* Service.

A Characteristic is provided by a Peripheral

A Characteristic is a field that can be written to or read from. A Service is a container that may hold one or more Characteristics. GATT is the layout of these Services and Characteristics. Characteristic can be written to or read from.

##### Byte Order

Bluetooth orders data in both Big-Endian and LittleEndian depending on the context.

During advertisement, data is transmitted in Big Endian, with the most significant bytes of a number at the end.
```
int FF 00 00 00 00 00 00 00 # 255
```
Data transfers inside the GATT however are transmitted in Little Endian, with the least significant byte at the end.
```
int 00 00 00 00 00 00 00 FF # 255
```

##### Permissions

A Characteristic grants certain Permissions of the Central. These permissions include the ability to read and write data on the Characteristic, and to subscribe to Notifications.

##### Descriptors

A Characteristic grants certain Permissions of the Central. These permissions include the ability to read and write data on the Characteristic, and to subscribe to Notifications.

##### UUIDs

BLE uses UUIDs to label Services and Characteristics so that Services and Characteristics can be identified accurately even when switching devices or when several Characteristics share the same name.

For example, if a Peripheral has two “Temperature” Characteristics, one for Celsius and the other in Fahrenheit, UUIDs allow for the right data to be communicated.

16-bit UUIDs are supported along with the standard 128-bit UUIDs.

Each Characteristic and each Service is identified by its own UUID. Certain UUIDs are reserved for specific purposes.

For example, UUID 0x180F is reserved for Services that contain battery reporting Characteristics.

Similarly, Characteristics have reserved UUIDs in the Bluetooth Specification.

[Reserved GATT Services](https://www.bluetooth.com/specifications/gatt/services)
[Reserved GATT Characteristics](https://www.bluetooth.com/specifications/gatt/characteristics)

##### Bluetooth Hardware

##### Power and Range

## Chapter 2

### Introducing Android

## Chapter 3

### Bootstrapping



