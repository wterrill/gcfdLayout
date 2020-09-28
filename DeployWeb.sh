
rm lib/buildTime/flutterVersion.dart
echo "Building flutterVersion.dart"
echo "const Map<String,String> version = " >> lib/buildTime/flutterVersion.dart
flutter --version --machine >> lib/buildTime/flutterVersion.dart
echo ";" >> lib/buildTime/flutterVersion.dart
echo 'const String appVersion = "1.1.1 build 0";' >> lib/buildTime/flutterVersion.dart

rm lib/buildTime/flutterDate.dart
echo "Building flutterdate.dart"
printf "const String buildDate  = \"" >> lib/buildTime/flutterDate.dart
printf '%s' "$(date)" >> lib/buildTime/flutterDate.dart
printf  "\";" >> lib/buildTime/flutterDate.dart
echo "Continuing flutter build"


#############
## Testing ##
#############

echo "building web version"
flutter build web -t lib/websiteMain.dart --release
echo "moving built web version to websiteTesting"
cp -fr ./build/web/* ./websiteTesting/ 
cd websiteTesting
echo "pushing new version to github"
git add .
now=$(printf '%s' "$(date)")
git commit -m "AutoCommit webTesting $now"
git push
cd ..
echo "new version pushed to github."
flutter build ios -t lib/main.dart --release

