
rm lib/buildTime/flutterVersion.dart
echo "Building flutterVersion.dart"
echo "const Map<String,String> version = " >> lib/buildTime/flutterVersion.dart
flutter --version --machine >> lib/buildTime/flutterVersion.dart
echo ";" >> lib/buildTime/flutterVersion.dart

rm lib/buildTime/flutterDate.dart
echo "Building flutterdate.dart"
printf "const String buildDate  = \"" >> lib/buildTime/flutterDate.dart
printf '%s' "$(date)" >> lib/buildTime/flutterDate.dart
# printf '%s' "$(date "+%d.%m.%Y")" >> lib/buildTime/flutterDate.dart
# printf '%(%m-%d %H:%M:%S)T'
# date  >> lib/buildTime/flutterDate.dart
printf  "\";" >> lib/buildTime/flutterDate.dart
echo "Continuing flutter build"

flutter build web --release
firebase deploy
flutter build ios --release

