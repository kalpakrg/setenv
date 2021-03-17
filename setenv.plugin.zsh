if [[ $SETENV_CONFIG_PATH && -d $SETENV_CONFIG_PATH ]] ; then
	true
elif [ -d $XDG_CONFIG_HOME ] ; then
	SETENV_CONFIG_PATH=$XDG_CONFIG_HOME/setenv
	if [ ! -d $SETENV_CONFIG_PATH ] ; then
		mkdir $SETENV_CONFIG_PATH &> /dev/null || SETENV_CONFIG_PATH=$HOME
	fi
elif [ -d $HOME/.config ] ; then
	SETENV_CONFIG_PATH=$HOME/.config/setenv
	if [ ! -d $SETENV_CONFIG_PATH ] ; then
		mkdir $SETENV_CONFIG_PATH &> /dev/null || SETENV_CONFIG_PATH=$HOME
	fi
fi
export SETENV_WHITELIST=$SETENV_CONFIG_PATH/.setenv-whitelist

_setenv_run() {
    if [ -x ".setenv" ] ; then 
        execute=1
        grep -Fx "$PWD" $SETENV_WHITELIST &> /dev/null
        
        if [ 1 -eq $? ] ; then
        	echo "Directory $current_dir is not in setenv whitelist, but contains a .setenv file, do you still want to execute it? (y/n): "
        	read choice 

            if [ "$choice" != "y" ] ; then 
                execute=0
            fi
        fi

        if [ 1 -eq $execute ] ; then
            echo "File .setenv exists and is executable, will execute it."
            source "$PWD/.setenv"
        fi
    fi
}

function setenv_run () {
    if [ ! -f $SETENV_WHITELIST ]; then
        touch $SETENV_WHITELIST
    fi

    _setenv_run
}

function setenv_whitelist () {
    grep -Fx "$PWD" $SETENV_WHITELIST &> /dev/null

    if [ 1 -eq $? ];
    then
        pwd >> $SETENV_WHITELIST
    else 
        echo "Directory $PWD is already in whitelist."
    fi
}

function setenv_whitelist_remove () {
    tmpfile=$(mktemp)
    grep -vFx "$PWD" $SETENV_WHITELIST > $tmpfile
    cp $tmpfile $SETENV_WHITELIST
}  

function setenv_show_whitelist () {
    cat $SETENV_WHITELIST
} 

test_fn="setenv_run"
if [[ -z ${(M)chpwd_functions:#${test_fn}} ]]; then
    chpwd_functions+=(setenv_run)
fi

