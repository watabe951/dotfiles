mkdir -p $(dirname $PROFILE)
# touch $PROFILE
gsudo New-Item -ItemType SymbolicLink -Path (dirname $PROFILE) -Name Microsoft.PowerShell_profile.ps1 -Value $HOME\dotfiles\pwsh\Microsoft.PowerShell_profile.ps1
# gsudo ln -T -s -f $HOME/dotfiles/pwsh/Microsoft.PowerShell_profile.ps1 $PROFILE
