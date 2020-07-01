

echo Jarsigner command started...

sudo jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.jks ~/git/flutter/activeProjects/gcfdLayout/build/app/outputs/flutter-apk/app-release.apk salsaconnect -storepass 1Fraggle

echo Jarsigner command finished.

echo Zipalign command started...

sudo ~/Library/Android/sdk/build-tools/28.0.3/zipalign -v 4 ~/git/flutter/activeProjects/gcfdLayout/build/app/outputs/flutter-apk/app-release.apk ~/git/flutter/activeProjects/gcfdLayout/build/app/outputs/flutter-apk/Auditor.apk

echo Zipalign command finished.

echo Apksigner command started...
sudo ~/Library/Android/sdk/build-tools/28.0.3/apksigner verify ~/git/flutter/activeProjects/gcfdLayout/build/app/outputs/flutter-apk/Auditor.apk

sudo ~/Library/Android/sdk/build-tools/28.0.3/apksigner verify ~/git/flutter/activeProjects/gcfdLayout/build/app/outputs/flutter-apk/app-release.apk 

echo Apksigner command finished.


