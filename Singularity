Bootstrap: shub
From: willgpaik/centos7_aci

%setup

%files

%environment

%runscript

%post
    yum -y install lapack-devel blas-devel ocl-icd-devel
    
    set +e

    
    source /opt/rh/devtoolset-8/enable
    
    export PATH=/usr/local/bin
        
    mkdir -p /opt/sw
    cd /opt/sw
    
    wget https://raw.githubusercontent.com/willgpaik/emsoft_aci/master/emsoft_install.sh
    chmod +x emsoft_install.sh
    ./emsoft_install.sh
    rm emsoft_install.sh
