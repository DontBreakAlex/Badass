wget https://drive.google.com/u/0/uc\?id\=1YCFmbjz8sZ1W97zmg899U6HJze-K2CMC\&export\=download\&confirm\=yes -P /goinfre/$USER
cd /goinfre/$USER
lz4 -d uc\?id\=1YCFmbjz8sZ1W97zmg899U6HJze-K2CMC\&export\=download\&confirm\=yes debian.qcow2
virt-manager