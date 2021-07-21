# Flutter Modular
Flutter based project, implementing multi-module approach.

## Getting Started

### Setup your FVM

Please run command below

```shell
brew tap leoafarias/fvm
brew install fvm
fvm install
fvm doctor
fvm flutter doctor
cd asphalt_aloha && fvm flutter pub get && cd ..
cd asphalt_aloha_demo && fvm flutter pub get && cd ..
cd mystique && fvm flutter pub get && cd ..
fvm flutter run # ensure a device is connected 
```

Please run this command on your root project after pulling from repository

```
bash make_project.sh
```