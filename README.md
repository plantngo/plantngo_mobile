# Plant&Go Frontend (Flutter)

The Plant&Go project consists of two parts:
1. [Plant&Go Backend Server (Spring Boot MVC)](https://github.com/plantngo/plantngo_backend)
2. Plant&Go Frontend (Flutter)

## Getting Started

### Installation
If you just wish to download and use the pre-built mobile application, you can download the `.apk (Android)` or `.ipa (iOS)` file from the releases section of this Github Repository.

Note that the pre-built application uses the production Plant&Go Backend Server hosted at [https://plantngo.potatovault.com](https://plantngo.potatovault.com).
> This project is a demo application, please do not enter any sensitive or important data on this platform.

### Self-Hosted Locally
As this project is a frontend application, it's only able to function when referencing the backend built for it. If you wish to host the project yourself, you will need to have an instance of the [Plant&Go Backend Server (Spring Boot MVC)](https://github.com/plantngo/plantngo_backend) running locally. When you run this project, you will need to modify and use the `run.sh` provided.
```bash
# run.sh
# runs the app with the SPRINGBOOT_HOST environment variable, change the IP Below to your locally hosted server's IP Address
flutter run --dart-define=SPRINGBOOT_HOST="http://192.168.18.2:8080"
```

This enables us to inject the IP Address/Endpoint of the API Server you've hosted locally

To start, make a copy of the repository with the `git clone` command or download the repository by clicking, `Code -> Download Zip` on the Github Repository Page.
```bash
git clone https://github.com/plantngo/plantngo_frontend
```

After cloning the project, you will need to `cd` into the project directory and use `flutter` to start the project. Open up your terminal and run the following commands:
```bash
# change directory into the project
cd plantngo_frontend
# start the project with flutter
flutter run
```

## Contributing



### Dependencies
Before getting starting with development/running the application, install the following tools:
- [Flutter](https://docs.flutter.dev/get-started/install)

