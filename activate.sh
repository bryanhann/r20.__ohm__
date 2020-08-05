source $ZDOTDIR/functions.sh

#======================================================================
#  MAIN
#======================================================================
function main () {
    .call   profile
    .call   venv
    #.source virtualenvwrapper.sh
    .call   omzsh
    .source ${ZDOTDIR}/history.sh
}

#======================================================================
#  MAIN
#======================================================================
profile () {
    [[ -z "$BORG" ]] || return
    .export BORG $ZDOTDIR
    .export BORG_LOCAL                  ~/.local/borg
    .export BORG_VENV                   ${BORG_LOCAL}/VENV
    .export ZSH                         ${BORG_LOCAL}/ZSH
    .export BORG_REPOS                  ${BORG_LOCAL}/BORG_REPOS
    .export WORKON_HOME                 ${BORG_LOCAL}/WORKON_HOME
    .export PROJECT_HOME                ${BORG_LOCAL}/PROJECT_HOME
    .export VIRTUALENVWRAPPER_HOOK_DIR  ${BORG_LOCAL}/VIRTUALENVWRAPPER_HOOK_DIR
    .export VIRTUALENVWRAPPER_PYTHON    ${BORG_VENV}/bin/python
    mkdir -p $WORKON_HOME
    mkdir -p $PROJECT_HOME
    mkdir -p $BORG_REPOS
    .export PATH            $PATH:$BORG_VENV/bin
    .export PYTHONPATH      $BORG/lib/python
}

#======================================================================
#  VENV
#======================================================================
function venv () {
    [[ -d $BORG_VENV ]] || venv.install;
    .exec source $BORG_VENV/bin/activate
    .source $ZDOTDIR/venv.sh;
    .exec deactivate
}
function venv.remove {
    .note removing venv;
    rm -rf $BORG_VENV;
}
function venv.install () {
    .note installing venv;
    .exec python3 -m venv $BORG_VENV;
}

#======================================================================
#  OMZSH
#======================================================================
function omzsh () {
    [[ -d $ZSH ]] || omzsh.install
    .export ZSH_THEME kafeitu # plugins must not contain virtualenv for prompt to show virtual_env)
    plugins=(git virtualenvwrapper)
    .source $ZSH/oh-my-zsh.sh
}
function omzsh.remove   () { rm -rf $ZSH; }
function omzsh.install  () { $BORG/vendor/omzsh/install.sh --unattended; }


.call main
