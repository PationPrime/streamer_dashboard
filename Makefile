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

config\:main\:dev:
	flutter pub run environment_config:generate --config-extension=dev --config=main_environment_config.yaml

config\:main\:test:
	flutter pub run environment_config:generate --config-extension=test --config=main_environment_config.yaml

config\:main\:prod:
	flutter pub run environment_config:generate --config-extension=prod --config=main_environment_config.yaml

config\:dev:
	flutter pub run environment_config:generate --config=dev_environment_config.yaml

config\:test:
	flutter pub run environment_config:generate --config=test_environment_config.yaml

config\:prod:
	flutter pub run environment_config:generate --config=prod_environment_config.yaml

config\:all\:dev:
	make config:dev
	make config:test
	make config:prod
	make config:main:dev

config\:all\:test:
	make config:dev
	make config:test
	make config:prod
	make config:main:test

config\:all\:prod:
	make config:dev
	make config:test
	make config:prod
	make config:main:prod