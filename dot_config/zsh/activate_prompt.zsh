# No Virtualenv we will handle the display
export VIRTUAL_ENV_DISABLE_PROMPT=yes

function virtual_env_indicator {
    if [[ -z $VIRTUAL_ENV ]] then
        psvar[1]=''
    else
        psvar[1]=${VIRTUAL_ENV##*/}
    fi
}

add-zsh-hook precmd virtual_env_indicator

# Activate Prompt
prompt ditc
