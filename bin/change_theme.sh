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

# if empty, exit
if [[ z$new_theme == z ]]; then
    exit
fi

# set theme
for (( i = 0; i < $(cat $config_file | jq ".programs | keys | length"); i++ )); do
    program=$(cat $config_file | jq ".programs | keys | .[$i]")
    source_file=$(cat $config_file | jq -r ".programs[$program] | .source_dir + \"/\" + .theme_name_mapping.solarized_light")
    dest_file=$(cat $config_file | jq -r ".programs[$program] | .destination_file")
    echo Linking to $source_file from $dest_file
    rm $dest_file
    ln -s $dest_file $source_file
done

