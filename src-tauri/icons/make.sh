
CUR_DIR=
get_cur_dir() {
    # Get the fully qualified path to the script
    case $0 in
        /*)
            SCRIPT="$0"
            ;;
        *)
            PWD_DIR=$(pwd);
            SCRIPT="${PWD_DIR}/$0"
            ;;
    esac
    # Resolve the true real path without any sym links.
    CHANGED=true
    while [ "X$CHANGED" != "X" ]
    do
        # Change spaces to ":" so the tokens can be parsed.
        SAFESCRIPT=`echo $SCRIPT | sed -e 's; ;:;g'`
        # Get the real path to this script, resolving any symbolic links
        TOKENS=`echo $SAFESCRIPT | sed -e 's;/; ;g'`
        REALPATH=
        for C in $TOKENS; do
            # Change any ":" in the token back to a space.
            C=`echo $C | sed -e 's;:; ;g'`
            REALPATH="$REALPATH/$C"
            # If REALPATH is a sym link, resolve it.  Loop for nested links.
            while [ -h "$REALPATH" ] ; do
                LS="`ls -ld "$REALPATH"`"
                LINK="`expr "$LS" : '.*-> \(.*\)$'`"
                if expr "$LINK" : '/.*' > /dev/null; then
                    # LINK is absolute.
                    REALPATH="$LINK"
                else
                    # LINK is relative.
                    REALPATH="`dirname "$REALPATH"`""/$LINK"
                fi
            done
        done

        if [ "$REALPATH" = "$SCRIPT" ]
        then
            CHANGED=""
        else
            SCRIPT="$REALPATH"
        fi
    done
    # Change the current directory to the location of the script
    CUR_DIR=$(dirname "${REALPATH}")
}


get_cur_dir

SRC_PNG=${CUR_DIR}/logo.png

magick $SRC_PNG -resize 32x32 icon.ico

sips -z 32 32 $SRC_PNG --out ${CUR_DIR}/32x32.png
sips -z 128 128 $SRC_PNG --out ${CUR_DIR}/128x128.png
sips -z 256 256 $SRC_PNG --out ${CUR_DIR}/128x128@2x.png
sips -z 512 512 $SRC_PNG --out ${CUR_DIR}/icon.png
sips -z 30 30 $SRC_PNG --out ${CUR_DIR}/Square30x30Logo.png
sips -z 44 44 $SRC_PNG --out ${CUR_DIR}/Square44x44Logo.png
sips -z 71 71 $SRC_PNG --out ${CUR_DIR}/Square71x71Logo.png
sips -z 89 89 $SRC_PNG --out ${CUR_DIR}/Square89x89Logo.png
sips -z 107 107 $SRC_PNG --out ${CUR_DIR}/Square107x107Logo.png
sips -z 142 142 $SRC_PNG --out ${CUR_DIR}/Square142x142Logo.png
sips -z 150 150 $SRC_PNG --out ${CUR_DIR}/Square150x150Logo.png
sips -z 284 284 $SRC_PNG --out ${CUR_DIR}/Square284x284Logo.png
sips -z 310 310 $SRC_PNG --out ${CUR_DIR}/Square310x310Logo.png
sips -z 50 50 $SRC_PNG --out ${CUR_DIR}/StoreLogo.png
#sips -z 512 512 $SRC_PNG --out ${CUR_DIR}/tray-icon.png
#sips -z 512 512 $SRC_PNG --out ${CUR_DIR}/tray-icon-light.png

cd ${CUR_DIR}
iconutil -c iconset icon.icns

sips -z 16 16     $SRC_PNG --out icon.iconset/icon_16x16.png
sips -z 32 32     $SRC_PNG --out icon.iconset/icon_16x16@2x.png
sips -z 32 32     $SRC_PNG --out icon.iconset/icon_32x32.png
sips -z 64 64     $SRC_PNG --out icon.iconset/icon_32x32@2x.png
sips -z 128 128   $SRC_PNG --out icon.iconset/icon_128x128.png
sips -z 256 256   $SRC_PNG --out icon.iconset/icon_128x128@2x.png
sips -z 256 256   $SRC_PNG --out icon.iconset/icon_256x256.png
sips -z 512 512   $SRC_PNG --out icon.iconset/icon_256x256@2x.png
sips -z 512 512   $SRC_PNG --out icon.iconset/icon_512x512.png
sips -z 1024 1024   $SRC_PNG --out icon.iconset/icon_512x512@2x.png

iconutil -c icns ${CUR_DIR}/icon.iconset

rm -rf ${CUR_DIR}/icon.iconset
