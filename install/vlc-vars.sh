THIS_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)

export LD_LIBRARY_PATH=${THIS_DIR}/lib/3rdparty:${THIS_DIR}/lib:${THIS_DIR}/lib/vlc:$LD_LIBRARY_PATH
export PATH=${THIS_DIR}/bin:$PATH
export QT_QPA_PLATFORM_PLUGIN_PATH=${THIS_DIR}/lib/3rdparty/plugins
