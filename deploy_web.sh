cd example
flutter build web
rm -rf ../docs
mv build/web ../docs
cd ../docs
sed -i '' '/base href/d' index.html
