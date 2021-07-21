APP_DIRECTORY="$(dirname "$0")/app"
cd "$APP_DIRECTORY"
echo "Do cleaning root project on app..."
fvm flutter clean

## declare array variables
declare -a generator=("assets" "language")
declare -a module_shared=("shared_extensions" "shared_launcher" "shared_manifest" "shared_router" "shared_router_registry" "shared_storage" "shared_utilities")
declare -a module_foundation=("foundation_authenticator" "foundation_identifiers" "foundation_injector")
declare -a module_library=("lib_event" "lib_network" "lib_storage_auth_token")
declare -a module_product=("product_authentication" "product_splash")

for item in "${generator[@]}"; do
  DIRECTORY="$(dirname "$0")/generator/$item"
  cd "$DIRECTORY"
  dart pub get
done

for item in "${module_foundation[@]}"; do
  DIRECTORY="$(dirname "$0")/module_foundation/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  fvm flutter pub get
  fvm flutter pub run build_runner build --delete-conflicting-outputs
done

for item in "${module_shared[@]}"; do
  DIRECTORY="$(dirname "$0")/module_shared/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  fvm flutter pub get
  fvm flutter pub run build_runner build --delete-conflicting-outputs
done

for item in "${module_library[@]}"; do
  DIRECTORY="$(dirname "$0")/module_library/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  fvm flutter pub get
  fvm flutter pub run build_runner build --delete-conflicting-outputs
done

for item in "${module_product[@]}"; do
  DIRECTORY="$(dirname "$0")/module_product/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  fvm flutter pub get
  fvm flutter pub run build_runner build --delete-conflicting-outputs
done

APP_DIRECTORY="$(dirname "$0")/app"
cd "$APP_DIRECTORY"
echo "$APP_DIRECTORY"
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs

echo ""
echo "Make project finished"
