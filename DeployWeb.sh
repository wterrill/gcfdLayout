
echo "BE SURE TO SET TO :88 for UAT, and :90 for testing"
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
### UAT #####
#############
# # sed -i '' "s/:90/:88/g" lib/pages/developer/authenticationEndpoint.dart/testAuthentication.dart
# # sed -i '' "s/:90/:88/g" lib/communications/Comms.dart
echo "building web version"
flutter build web --release
echo "moving built web version to wterrill.github.io"
cp -fr ./build/web/* ./wterrill.github.io/ 
cd wterrill.github.io
echo "pushing new version to github"
git add .
now=$(printf '%s' "$(date)")
git commit -m "AutoCommit wterrill.github.io $now"
git push
cd ..
echo "new version pushed to github. Building ios version with :88"
# flutter build ios --release


#############
## Testing ##
#############

echo "DEPLOYING ON :90 THE TEST SERVER"
# # echo "replacing :88 with :90"
# # sed -i '' "s/:88/:90/g" lib/pages/developer/authenticationEndpoint.dart/testAuthentication.dart
# # sed -i '' "s/:88/:90/g" lib/communications/Comms.dart
echo "building web version"
flutter build web --release
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
flutter build ios --release

