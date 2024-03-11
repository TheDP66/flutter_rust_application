launcher:
	dart run flutter_launcher_icons

build_runner:
	dart run build_runner build

build-apk:
	flutter build apk --target-platform android-arm64 --analyze-size --split-per-abi

clean-run:
	flutter clean
	flutter run