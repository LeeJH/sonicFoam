#!/bin/bash
Makefile="dummyMake"
CFHOME=/home/jiahuili/sonicfoam
echo "LIB_SRC = $CFHOME/src" > $Makefile
echo "LIB_DIR = $CFHOME/lib" >> $Makefile
echo "FOAM_LIBBIN = $CFHOME/lib" >> $Makefile
grep "=" Make/files >> $Makefile
cat Make/options >> $Makefile
echo "" >> $Makefile
echo 'src = \' >> $Makefile

for line in `grep "\.C" Make/files | grep -v \*`
do
	echo "$line \\">> $Makefile
done
echo "" >> $Makefile
echo 'CFLAGS = -std=c++11 -m64 -Dlinux64 -DWM_ARCH_OPTION=64 -DWM_DP -DWM_LABEL_SIZE=32 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -Wno-attributes -O3  -DNoRepository -ftemplate-depth-100  -fPIC -I../OpenFOAM/lnInclude/ -I../OSspecific/POSIX/lnInclude -I./lnInclude -shared -Xlinker --add-needed -Xlinker --no-as-needed' >> $Makefile
echo "all:" >> $Makefile
echo -e "\tg++ \$(CFLAGS) \$(src) \$(EXE_INC) -I\$(LIB_SRC)/OpenFOAM/lnInclude/ -I\$(LIB_SRC)/OSspecific/POSIX/lnInclude -L\$(LIB_DIR) \$(LIB_LIBS) -o \$(LIB).so"  >> $Makefile
