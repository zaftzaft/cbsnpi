version="0.0.2"
releaseDir=release/v${version}

# Clean
if [ -e ./build ]; then
  rm -r ./build
fi

if [ ! -d ./release ]; then
  mkdir release
fi

if [ -d $releaseDir ]; then
  rm -r $releaseDir
fi
mkdir $releaseDir

gulp build
cp package.json ./build/source/
cd build
electron-packager ./source cbsnpi \
  --platform=win32,linux,darwin \
  --arch=x64 \
  --version=0.31.2 \
  --asar

#tar -czvf ../release/linux-x64.tar.gz ./cbsnpi-linux-x64
echo "compress bz2"
tar -cjvf ../${releaseDir}/cbsnpi-v${version}-linux-x64.tar.bz2 ./cbsnpi-linux-x64
echo "compress zip (win32)"
zip -r ../${releaseDir}/cbsnpi-v${version}-win-x64.zip ./cbsnpi-win32-x64/*
echo "compress zip (darwin)"
zip -r ../${releaseDir}/cbsnpi-v${version}-darwin-x64.zip ./cbsnpi-darwin-x64/*
