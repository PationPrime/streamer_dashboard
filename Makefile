clean:
	flutter clean
	flutter pub get
	flutter pub upgrade

run:
	flutter run

build:
	flutter build windows

app_icon:
	dart run icons_launcher:create
	make clean

build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs
