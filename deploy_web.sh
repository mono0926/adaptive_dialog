cd example
flutter build web \
  --base-href="/adaptive_dialog/" \
  --web-renderer=canvaskit
rm -rf ../docs
mv build/web ../docs
