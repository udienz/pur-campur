#!/bin/sh
# script from Jamin W. Collins  BTS: #255165
# use ~/bin/ubuntu.sh create/build hardy/jaunty somefile.dsc
# Mahyuddin Susanto (2009) udienz@unej.ac.id

OPERATION=$1
DISTRIBUTION=unstable
PROCEED=false
BASE_DIR="$HOME/project/pbuilder"
RESULT="$BASE_DIR/result/$DISTRIBUTION/"
if [ ! -d "$BASE_DIR" ] || [ ! -d "$RESULT" ] || [ ! -d $BASE_DIR/apt-cache ] || [ ! -d $BASE_DIR/hooks ] ; then
sudo mkdir -p "$BASE_DIR" "$RESULT" "$BASE_DIR/apt-cache/$DISTRIBUTION/"
fi

#sudo mkdir -p $BASE_DIR/$DISTRIBUIOTN/result/`date +%d%m%y`
case $OPERATION in
   create|update|build|clean|login|execute )
      PROCEED=true
      ;;      
esac

if ( $PROCEED == true ) then
   shift 

sudo pbuilder $OPERATION \
        --basetgz $BASE_DIR/$DISTRIBUTION-base.tgz \
        --distribution $DISTRIBUTION \
	--hookdir "$BASE_DIR/hooks" \
        --mirror "http://kambing.ui.ac.id/debian" --components "main contrib non-free" \
        --debbuildopts -j4 \
        --buildresult $RESULT "$@"
else
   echo "Invalid command..."
   echo "Valid commands are:"
   echo "   create"
   echo "   update"
   echo "   build"
   echo "   clean"
   echo "   login"
   echo "   execute"
   exit 1
fi
