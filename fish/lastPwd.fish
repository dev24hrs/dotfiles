
set -g LAST_PWD_FILE "$HOME/.fish_last_pwd"
function __save_last_pwd --on-variable PWD
    if status is-interactive
        echo $PWD > $LAST_PWD_FILE
    end
end
if status is-interactive
    if test -f $LAST_PWD_FILE
        set -l last_dir (cat $LAST_PWD_FILE)
        if test -d "$last_dir"
            cd "$last_dir"
        end
    end
end

