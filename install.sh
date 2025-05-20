base_packages=(
  "wget"
  "unzip"
  "rsync"
  "git"
)

download_folder="$HOME/.jizzarch-tmp"

# Create download_folder if not exists
if [ ! -d $download_folder ]; then
  mkdir -p $download_folder
fi

# Install required packages
_installPackages() {
  toInstall=()
  for pkg; do
    if [[ $(_isInstalled "${pkg}") == 0 ]]; then
      echo ":: ${pkg} is already installed."
      continue
    fi
    toInstall+=("${pkg}")
  done
  if [[ "${toInstall[@]}" == "" ]]; then
    # echo "All pacman packages are already installed.";
    return
  fi
  printf "Package not installed:\n%s\n" "${toInstall[@]}"
  sudo pacman --noconfirm -S "${toInstall[@]}"
}

# install yay if needed
_installYay() {
  _installPackages "base-devel"
  SCRIPT=$(realpath "$0")
  temp_path=$(dirname "$SCRIPT")
  git clone https://aur.archlinux.org/yay.git $download_folder/yay
  cd $download_folder/yay
  makepkg -si
  cd $temp_path
  echo ":: yay has been installed successfully."
}

# Synchronizing package databases
sudo pacman -Sy
echo

# Install required base packages
echo ":: Checking that required packages for this installation are installed..."
_installPackages "${base_packages[@]}"

# Install yay if needed
if _checkCommandExists "yay"; then
  echo ":: yay is already installed"
else
  echo ":: The installer requires yay. yay will be installed now"
  _installYay
fi
echo

removed_packages=(
  "figlet"
  "stow"
)

may_be_missing_packages=(
  "wl-clipboard"
)

packages=(
  "pacman-contrib"
  "sed"
  "nvim"
  "xdg-user-dirs"
  "man-pages"
  "networkmanager"
  "bluez"
  "bluez-utils"
  "hyprland"
  "hyprpaper"
  "hyprlock"
  "hypridle"
  "hyprpicker"
  "noto-fonts"
  "noto-fonts-emoji"
  "noto-fonts-cjk"
  "noto-fonts-extra"
  "xdg-desktop-portal"
  "xdg-desktop-portal-hyprland"
  "libnotify"
  "dunst"
  "kitty"
  "qt5-wayland"
  "qt6-wayland"
  "sddm"
  "qt5-graphicaleffects"
  "qt5-quickcontrols2"
  "qt5-svg"
  "uwsm"
)
