# flut_hub

Flutter application to search for repositories and see their issues

## Getting Started

<img src="https://github.com/liodali/flut_hub/blob/main/fluthub.gif?raw=true" alt="flut_hub preview"><br>
<br>
### build

before build the project,should run those cmd

```shell


cd flut_hub_core && flutter pub run build_runner build && cd ..
cd flut_hub_domain && flutter pub run build_runner build && cd ..

flutter pub run flutter_app_name
flutter pub run flutter_native_splash:create
flutter pub run flutter_launcher_icons:main

```
after run those cmd you can build the project easily
1) Android 
```shell
flutter build apk --release
```
2) iOS
```shell
flutter build ios --no-codesign
```


##### In this project, we implement the  clean architecture
* in this project , we divided each layer in separate package 
* we have 3 layer:

    * <srong>App </string>             : This main app project that  contains all  the code related to the UI/Presentation layer such as widget,route,localization  and contain viewModel
    * <srong>Core package</string>     : separate package that holds all concrete implementations of our repositories,UseCases and other data sources like  network,DI
    * <srong>Domain package </string>  : separate package that contain all interfaces of repositories  and  classes



> I used getIt as dependency injection for this project

> I used dio for http calls

> I used FlutterHook and Provider for reactive UI