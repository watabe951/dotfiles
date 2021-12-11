mkdir -p $(dirname $PROFILE)
touch $PROFILE
gsudo ln -T -s -f $HOME/dotfiles/pwsh/Microsoft.PowerShell_profile.ps1 $PROFILE
