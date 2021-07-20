cd "$(dirname "$0")"
echo "Do cleaning root project..."
flutter clean
flutter pub get

## declare array variables
declare -a generator=("assets" "language")
declare -a module_core=("core_extensions" "core_launcher" "core_manifest" "core_router" "core_router_registry" "core_storage" "core_utilities")
declare -a module_foundation=("foundation_authenticator" "foundation_identifiers" "foundation_injectors")
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
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
done

for item in "${module_core[@]}"; do
  DIRECTORY="$(dirname "$0")/module_core/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
done

for item in "${module_library[@]}"; do
  DIRECTORY="$(dirname "$0")/module_library/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
done

for item in "${module_product[@]}"; do
  DIRECTORY="$(dirname "$0")/module_product/$item"
  cd "$DIRECTORY"
  echo "$DIRECTORY"
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
done

echo "make project finished"
