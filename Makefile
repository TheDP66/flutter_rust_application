launcher:
	flutter pub run flutter_launcher_icons

build-apk:
	flutter build apk --target-platform android-arm64 --analyze-size --split-per-abi