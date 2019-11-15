set +e

mkdir -p $PWD/emsoft
mkdir -p $PWD/emtmp

BASE=$PWD
BUILDDIR=$BASE/emsoft
TMPDIR=$BASE/emtmp

cd $TMPDIR

# install EMsoft SDK
wget https://github.com/EMsoft-org/EMsoftSuperbuild/archive/v5.0.0.tar.gz
tar -xf v5.0.0.tar.gz 
cd EMsoftSuperbuild-5.0.0/
sed -i '59 a -DCMAKE_Fortran_COMPILER=/opt/rh/devtoolset-8/root/usr/bin/gfortran' ./projects/JsonFortran.cmake
mkdir build
cd build
# emsoft workbench is disabled to make life easier:
# https://github.com/EMsoft-org/EMsoftSuperbuild/issues/11
cmake .. -DEMsoft_SDK=$BUILDDIR/EMsoft_SDK -DCMAKE_BUILD_TYPE=Release -DEMsoft_ENABLE_EMsoftWorkbench=OFF
make -j 2

cd $TMPDIR

# install EMsoft
rm v5.0.0.tar.gz
wget https://github.com/EMsoft-org/EMsoft/archive/v5.0.0.tar.gz
tar -xf v5.0.0.tar.gz
cd EMsoft-5.0.0/
sed -i "s|git@github.com:EMsoft-org/SHTfile.git|https://github.com/EMsoft-org/SHTfile.git|g" CMakeLists.txt
sed -i "s|https://github.com/emsoft-org/EMsoftData|https://github.com/EMsoft-org/EMsoftData.git|g" Source/Test/CMakeLists.txt
mkdir build
cd build
cmake .. -DEMsoft_SDK=$BUILDDIR/EMSoft_SDK -DCMAKE_BUILD_TYPE=Release \
-DHDF5_DIR=$BUILDDIR/EMsoft_SDK/hdf5-1.8.20-Release/share/cmake \
-Djsonfortran-gnu_DIR=$BUILDDIR/EMsoft_SDK/jsonfortran-4.2.1-Release/lib64/cmake/jsonfortran-gnu-4.2.1/ \
-DFFTW3_INSTALL=$BUILDDIR/EMsoft_SDK/fftw-3.3.8 \
-DCLFortran_DIR=$BUILDDIR/EMsoft_SDK/CLFortran-0.0.1-Release/lib/cmake/CLFortran \
-Dbcls_DIR=$BUILDDIR/EMsoft_SDK/bcls-0.1-Release/lib/cmake/bcls \
-DBUILD_SHARED_LIBS=ON \
-DEMsoft_ENABLE_EMsoftWorkbench=OFF \
-DCLFortran_LIB_PATH=$BUILDDIR/EMsoft_SDK/CLFortran-0.0.1-Release/lib
make -j 2

cd $BASE
rm -rf $TMPDIR
