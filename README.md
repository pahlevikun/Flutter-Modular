# Flutter Modular
Flutter based project, implementing multi-module approach. 

## Getting Started

### 1. Setup your Flutter Environment

Since I'm working on a mac machine, what you need is to install HomeBrew first, then you need to install Flutter Version Manager (FVM) on your machine:

```shell script
brew tap leoafarias/fvm
brew install fvm
```
After you install Flutter Version Manager, you need to install Flutter SDK using FVM, FVM is a very helpful tools for managing different flutter version on multiple project:

```shell script
fvm install
fvm use stable --force
```
Why using `--force`? Because we need to set FVM on a non-flutter root directory since we are move all of our Flutter module inside another package.
Last part is to make the project and generate dependencies tree, just run command below on root project:

```
bash make_project.sh
```

### 2. Setup your IDE

Basically I'm an Android Developer, my main weapon is Android Studio, which is an Intellij IDE. So if you are using Visual Studio code, you can adjust or contribute to this readme file.
What you need is to setup the SDK location inside the IDE since you will see your entire project showing compilation errors when you opening the project first time.
To resolve this, below are some step:

1. Open the preferences, or you can just press `command` + `,`.
2. Go to Languages & Frameworks, then select Flutter.
3. Open the Flutter SDK path dropdown.
4. Select a shortcut folder provide by FVM: `flutter_boilerplate/.fvm/flutter_sdk`
5. Apply and restart your IDE.

## Architecture Diagram

Basically there is 2 type of module, public module and private module, public stand for a module that can be shared and owned by another module while private module stand for a module who have owner.

Below is the outline of architecture diagram showing the level of modules:

![Architecture Layering](https://raw.githubusercontent.com/pahlevikun/Flutter-Modular/main/readme/flutter_modular_2.png)

If you are a back-end guy, you may see this is similar to micro-services architecture, actually yes this is the same approach but on our case we use this approach for:

1. Separate of concern, each module have their own responsibility, independent between each other module, and has clear API.
2. Allowing better re-usability.
3. A modular system design or product can be easily upgraded (for example, for better performance of a smartphone or laptop). In non-modular products, it is harder to achieve incremental upgrades.
4. More easier to customize according to individual customer needs or preferences.
5. More easier to manage development on each product or feature parallel by different and multiple team.

## Rule of Layering

Below is illustration for rule for layering

![Rule of Layering](https://raw.githubusercontent.com/pahlevikun/Flutter-Modular/main/readme/flutter_modular_3.png)