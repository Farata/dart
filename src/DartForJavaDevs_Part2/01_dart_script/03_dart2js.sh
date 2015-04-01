# Create compiled Dart file
# NOTE: You should specify package root option that exists on your machine.
dart2js --package-root=/Users/amoiseev/Projects/dart_repo/dart/xcodebuild/ReleaseIA32/packages \
        --output-type=dart \
        --out=02_package_import.compiled.dart \
        02_package_import.dart
