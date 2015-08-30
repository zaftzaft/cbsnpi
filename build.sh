# Clean
if [ -e ./build ]; then
  rm -r ./build
fi

if [ -d ./release ]; then
  rm -r ./release
fi
mkdir release

gulp build
cp package.json ./build/
cd build
electron-packager ./ cbsnpi \
  --platform=win32,linux \
  --arch=x64 \
  --version=0.30.6 \
  --asar

#tar -czvf ../release/linux-x64.tar.gz ./cbsnpi-linux-x64
echo "compress bz2"
tar -cjvf ../release/linux-x64.tar.bz2 ./cbsnpi-linux-x64
echo "compress zip"
zip -r ../release/win-x64.zip ./cbsnpi-win32-x64/*
