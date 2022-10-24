# Plant&Go Frontend Mobile Application (Flutter)

[![Production Release](https://github.com/plantngo/plantngo_frontend/actions/workflows/production-deployment.yml/badge.svg?branch=main)](https://github.com/plantngo/plantngo_frontend/actions/workflows/production-deployment.yml)

The Plant&Go Project consists of two parts:
1. [Plant&Go Backend Server (Spring Boot MVC)](https://github.com/plantngo/plantngo_backend)
2. Plant&Go Frontend Mobile Application (Flutter)

# Quick Start

## Introduction
Plant&Go is a mobile application that encourages the pursuit of a sustainable diet.

## Usage
If you just wish to use the application and don't intend to contribute, you can download pre-built `.apk (Android)` or `.ipa (iOS)` file from the [releases section](https://github.com/plantngo/plantngo_frontend/releases) of this Github Repository.

> Note that the pre-built application uses the Plant&Go Backend Server hosted at [https://plantngo.potatovault.com](https://plantngo.potatovault.com). This project is a demo application, please do not enter any sensitive or important data on this platform. Data entered on this platform will be wiped periodically.

# Overview

## Solution Architecture

![](./.github/README/PlantNGo%20Solution%20Architecture.png)

## Database Entity-Relation Diagram

![](./.github/README/PlantNGo%20ER%20Diagram.png)


# Setup

If you wish to contribute to the project or build your own `.apk`/`.ipa` files, please refer to the guides written in the next few sections.

## Dependencies
Before getting starting with development or running the application, install the following tools:
- [Git](https://git-scm.com/downloads)
- [Flutter](https://docs.flutter.dev/get-started/install)
- Android Emulator/iOS Emulator/Mobile Phone

## Installation 

After installing the above dependencies, make a copy of the repository with the `git clone` command or download the repository by clicking, `Code -> Download Zip` on the Github Repository Page.
```bash
git clone https://github.com/plantngo/plantngo_frontend
```
When you're done cloning the project, you will need to `cd` into the project directory and use `flutter` to start the project. Open up your terminal and run the following commands:
```bash
# change directory into the project
cd plantngo_frontend
```

## Running
As this project is a Frontend Application, it's only able to function when referencing the Backend Server built for it.

### Demo Backend Server
For demo purposes, a Backend Server is already setup at [https://plantngo.potatovault.com](https://plantngo.potatovault.com) and by default, the source code references the demo server as its Backend Server.

To run the application:
```bash 
flutter run -d <emulator/device-id>
```

### Self-Hosted Backend Server
If you wish to host the Backend Server yourself, you can refer to the guide on [Plant&Go Backend Server's Github Repository](https://github.com/plantngo/plantngo_backend) on setting up a [Plant&Go Backend Server](https://github.com/plantngo/plantngo_backend).

To run the mobile application with a Self-Hosted Backend Server, modify and execute the `run.sh` bash script provided.
```bash
<run.sh>
# runs the app with the SPRINGBOOT_HOST variable
# change the IP Below to your locally hosted server's ip:port
flutter run --dart-define=SPRINGBOOT_HOST="http://localhost:8080"
```
Note that if you are using an Android Emulator, you should specify the IP Address of your device instead of localhost. This is because localhost in the Android Emulator's perspective refers to the Emulator's Internal IP Address instead of the Host's IP Address.



