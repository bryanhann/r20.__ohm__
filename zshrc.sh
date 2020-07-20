source      $(dirname $(grealpath $0))/functions.sh
_r20_enter  $(basename $0)
_r20_show   PATH
_r20_show   ZDOTDIR
_r20_show   R20
_r20_show   R20_INIT_CFG
_r20_show   R20_INIT_BLD
_r20_show   R20_INIT_URL
_r20_show   R20_ZPROFILE_TMP
_r20_show   R20_ZPROFILE_BIN

##### DEPTH #####
_r20_export R20_DEPTH $(( ${R20_DEPTH} + 1 ))
function exit() { [[ "${R20_DEPTH}" == "0" ]] && echo try 'builtin exit' || builtin exit }
function depth() { echo ${R20_DEPTH} }

export dst=$R20/__BUILD__/VENV
if [ ! -d $dst ];
    then
        python3 -m venv $dst
        source $dst/bin/activate
        pip install --upgrade pip
        r20pip_install virtualenv
        r20pip_install virtualenvwrapper
        deactivate
    else
fi

source $dst/bin/activate
source $dst/bin/virtualenvwrapper.sh

r20install  dunders #-r
r20install  bch
r20install  zjot
r20install  omzsh
r20install  libre
r20install  ws852
_r20_exit
#_colors
