# Flutter Modular
Flutter-based project, implementing the multi-module approach. 

## Getting Started

### 1. Setup your Flutter Environment

Since I'm working on a mac machine, what you need is to install HomeBrew first, then you need to install Flutter Version Manager (FVM) on your machine:

```shell script
brew tap leoafarias/fvm
brew install fvm
```
After you install Flutter Version Manager, you need to install Flutter SDK using FVM, FVM is a very helpful tool for managing different flutter versions on multiple projects:

```shell script
fvm install
fvm use stable --force
```
Why use `--force`? Because we need to set FVM on a non-flutter root directory since we are moving all of our Flutter modules inside another package.
The last part is to make the project and generate a dependencies tree, just run command below on the root project:

```
bash make_project.sh
```

### 2. Setup your IDE

Basically, I'm an Android Developer, my main weapon is Android Studio, which is an Intellij IDE. So if you are using Visual Studio code, you can adjust or contribute to this readme file.
What you need is to set up the SDK location inside the IDE since you will see your entire project showing compilation errors when you opening the project first time.
To resolve this, below are some steps:

1. Open the preferences, or you can just press `command` + `,`.
2. Go to Languages & Frameworks, then select Flutter.
3. Open the Flutter SDK path dropdown.
4. Select a shortcut folder provide by FVM: `flutter_boilerplate/.fvm/flutter_sdk`
5. Apply and restart your IDE.

## Architecture Diagram

Basically, there is 2 types of module, public module and private module, public stand for a module that can be shared and following the rule, while private module stands for a module who have an owner and can't depend or implemented by another module.

Below is the outline of the architecture diagram showing the level of modules:

![Architecture Layering](https://raw.githubusercontent.com/pahlevikun/Flutter-Modular/main/readme/flutter_modular_6.png)

If you are a back-end guy, you may see this is similar to micro-services architecture, actually yes this is the same approach but in our case, we use this approach for:

1. Separate of concern, each module have their own responsibility, independent between each other module, and has clear API.
2. Allowing better re-usability.
3. A modular system design or product can be easily upgraded (for example, for better performance of a smartphone or laptop). In non-modular products, it is harder to achieve incremental upgrades.
4. Easier to customize according to individual customer needs or preferences.
5. Easier to manage development on each product or feature parallel by different and multiple teams.

## Rule of Layering

Based on the previous section, there is 4 layer on this architecture:

1. **Application**: main module, used for register some services and running the app.
2. **Product**: this layer contains a set of features on each module, can be owned by a separate team.
3. **Library**: this layer can be called an integration layer, any 3rd party / data sources / services should be integrated here.
4. **Shared**: this layer contains shared logic and can be shared on each module.
5. **Foundation**: this layer is the basic infrastructure and the core for building the entire framework.
 
And below is the illustration for the rule of layering:

![Rule of Layering](https://raw.githubusercontent.com/pahlevikun/Flutter-Modular/main/readme/flutter_modular_7.png)

You need to follow rules below to avoid new issues comes up (such as circular dependencies):

1. **Application**: the main module used to run the app, all layers can be dependent here.
2. **Product**: modules on the layer below can be dependent here, but can't depend on modules on the same level or above.
3. **Library**: modules on the layer below can be dependent here, can depend on the module on the same level but need to avoid circular dependency, and can't depend on the upper level, all 3rd party / data sources / services should be integrated here.
4. **Shared**: modules on the layer below can be dependent here, can depend on the module on the same level but need to avoid circular dependency, and can't depend on the upper level.
5. **Foundation**: an independent module, can't depend on the modules on the same level and can depend on the module on the upper layer.

## Navigation

**WIP**