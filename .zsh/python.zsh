#### pyenv config


if [ -f "$HOME/.pyenv/bin/pyenv" ] && ! type -P pyenv &>/dev/null ; then
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
  export CFLAGS="-O2"
  export PYTHON_BUILD_ARIA2_OPTS="-x 10 -k 1M"
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
