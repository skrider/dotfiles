#!/bin/bash

# variables
config_file="$HOME/.dotfiles/themes/config.json"

# get theme
new_theme=$(
    cat $config_file | \
    jq ".themes | .[]" | \
    sd \" '' | \
    fzf
)

echo $new_theme

# if empty, exit
if [[ z$new_theme == z ]]; then
    exit
fi

# set theme
for (( i = 0; i < $(cat $config_file | jq ".programs | keys | length"); i++ )); do
    program=$(cat $config_file | jq ".programs | keys | .[$i]")
    source_file=$(cat $config_file | jq -r ".programs[$program] | .source_dir + \"/\" + .theme_name_mapping.$new_theme")
    dest_file=$(cat $config_file | jq -r ".programs[$program] | .destination_file")
    echo Linking to $source_file from $dest_file
    eval rm $dest_file
    # unsafe, allows for code injection
    eval ln -s $source_file $dest_file
done

background_dest=$(cat $config_file | jq -r ".programs.background.destination_file" | sd '~' $HOME)
gsettings set org.gnome.desktop.background picture-uri $background_dest

