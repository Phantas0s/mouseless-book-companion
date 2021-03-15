#!/bin/bash

name=$(cat /tmp/user_name)

apps_path="/tmp/apps.csv"

# Don't forget to replace "Phantas0s" by the username of your Github account
curl https://raw.githubusercontent.com/Phantas0s\
/arch_installer/master/apps.csv > $apps_path

dialog --title "Welcome!" \
--msgbox "Welcome to the install script for your apps and dotfiles!" \
    10 60

# Allow the user to select the group of packages he (or she) wants to install.
apps=("essential" "Essentials" on
      "network" "Network" on
      "tools" "Nice tools to have (highly recommended)" on
      "tmux" "Tmux" on
      "notifier" "Notification tools" on
      "git" "Git & git tools" on
      "i3" "i3 wm" on
      "zsh" "The Z-Shell (zsh)" on
      "neovim" "Neovim" on
      "urxvt" "URxvt" on
      "firefox" "Firefox (browser)" off
      "js" "JavaScript tooling" off
      "qutebrowser" "Qutebrowser (browser)" off
      "lynx" "Lynx (browser)" off)

dialog --checklist \
"You can now choose what group of application you want to install. \n\n\
You can select an option with SPACE and valid your choices with ENTER." \
0 0 0 \
"${apps[@]}" 2> app_choices
choices=$(cat app_choices) && rm app_choices

# Create a regex to only select the packages we want
selection="^$(echo $choices | sed -e 's/ /,|^/g'),"
lines=$(grep -E "$selection" "$apps_path")
count=$(echo "$lines" | wc -l)
packages=$(echo "$lines" | awk -F, {'print $2'})

echo "$selection" "$lines" "$count" >> "/tmp/packages"

pacman -Syu --noconfirm

rm -f /tmp/aur_queue

dialog --title "Let's go!" --msgbox \
"The system will now install everything you need.\n\n\
It will take some time.\n\n " \
13 60

c=0
echo "$packages" | while read -r line; do
    c=$(( "$c" + 1 ))

    dialog --title "Arch Linux Installation" --infobox \
    "Downloading and installing program $c out of $count: $line..." \
    8 70

    ((pacman --noconfirm --needed -S "$line" > /tmp/arch_install 2>&1) \
    || echo "$line" >> /tmp/aur_queue) \
    || echo "$line" >> /tmp/arch_install_failed

    if [ "$line" = "zsh" ]; then
        # Set Zsh as default terminal for our user
        chsh -s "$(which zsh)" "$name"
    fi

    if [ "$line" = "networkmanager" ]; then
        systemctl enable NetworkManager.service
    fi
done

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Don't forget to replace "Phantas0s" by the username of your Github account
curl https://raw.githubusercontent.com/Phantas0s\
/arch_installer/master/install_user.sh > /tmp/install_user.sh;

# Switch user and run the final script
sudo -u "$name" sh /tmp/install_user.sh
