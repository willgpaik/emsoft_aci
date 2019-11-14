Boostrap: shub
From: willgpaik/qt5_aci:qt5

%setup

%files

%environment

%runscript

%post
    yum -y install lapack-devel blas-devel
      
    source /opt/rh/devtoolset-8
    export PATH=/usr/local/Qt-5.12.5/bin:/usr/local/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/Qt-5.12.5/lib:$LD_LIBRARY_PATH
    export CPATH=/usr/local/Qt-5.12.5/include:$CPATH
    
    set +e
    
    cd /opt/sw
    wget https://raw.githubusercontent.com/willgpaik/emsoft_aci/master/emsoft_install.sh
    chmod +x emsoft_install.sh
    ./emsoft_install.sh
    rm emsoft_install.sh
