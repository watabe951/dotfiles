Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete


if(-not $env:path.Split(';').Contains('.')){
    $env:path += ";."
}

function Run-AsAdmin() {
    if($args.count -eq 0){
        Start-Process -Verb runas powershell
        return
    }
    Start-Process -Verb runas -ArgumentList @('-command', "$($args -join ' ')") powershell
}

Set-Alias -Name:"sudo" -Value:"Run-AsAdmin" -Description:"Start the certain process as administrator" -Option:"None"


# ついでに、初期位置を変更しておく。
# Set-Location "C:\Users\{UserName}\Documents\GitHub"


function prompt {
    $origLastExitCode = $LASTEXITCODE
    Write-Host "PS " -nonewline
    Write-VcsStatus
    Write-Host ($ExecutionContext.SessionState.Path.CurrentLocation) -ForegroundColor Green  -nonewline
    $LASTEXITCODE = $origLastExitCode
    "$('>' * ($nestedPromptLevel + 1)) "
}

# Import-Module posh-git
# $global:GitPromptSettings.BeforeText = '['
# $global:GitPromptSettings.AfterText  = '] '


# function global:Write-ColoredHost
# {
#     Param(
#         [switch]$noNewLine,
#         [String]$separator=" ",
#         [System.ConsoleColor]$foregroundColor = $Host.UI.RawUI.ForegroundColor,
#         [System.ConsoleColor]$backgroundColor = $Host.UI.RawUI.BackgroundColor
#     )
#     BEGIN {
#         $fgc, $bgc = $foregroundColor, $backgroundColor
#     }
#     PROCESS {
#         $token, $coloredTokens = $_ -split "\e\["
#         Write-Host $token `
#                    -noNewLine -separator $separator `
#                    -foregroundColor $fgc `
#                    -backgroundColor $bgc
#         foreach ($coloredToken in $coloredTokens) {
#             $colorCodes, $token = $coloredToken -split "m", 2
#                 $colorCodes -split ";" | foreach-object {
#                     switch -regex ($_) {
#                         "^0{1,2}$" { $fgc, $bgc = $foregroundColor, $backgroundColor }
#                         "^30$"     { $fgc       = "Black"                            }
#                         "^31$"     { $fgc       = "Red"                              }
#                         "^32$"     { $fgc       = "Green"                            }
#                         "^33$"     { $fgc       = "Yellow"                           }
#                         "^34$"     { $fgc       = "Blue"                             }
#                         "^35$"     { $fgc       = "Magenta"                          }
#                         "^36$"     { $fgc       = "Cyan"                             }
#                         "^37$"     { $fgc       = "White"                            }
#                         "^39$"     { $fgc       = $foregroundColor                   }
#                         "^40$"     {       $bgc =                   "Black"          }
#                         "^41$"     {       $bgc =                   "Red"            }
#                         "^42$"     {       $bgc =                   "Green"          }
#                         "^43$"     {       $bgc =                   "Yellow"         }
#                         "^44$"     {       $bgc =                   "Blue"           }
#                         "^45$"     {       $bgc =                   "Magenta"        }
#                         "^46$"     {       $bgc =                   "Cyan"           }
#                         "^47$"     {       $bgc =                   "White"          }
#                         "^49$"     {       $bgc =                   $backgroundColor }
#                     }
#                 }
#             Write-Host $token `
#                        -noNewLine -separator $separator `
#                        -foregroundColor $fgc `
#                        -backgroundColor $bgc
#         }
#         if (!$noNewLine) { Write-Host }
#     }
# }

# Function pdmc{pdm $args | Write-ColoredHost}

function rmrf {
    <#
       .DESCRIPTION
       Deletes the specified file or directory.
       .PARAMETER target
       Target file or directory to be deleted.
       .NOTES
       This is an equivalent command of "rm -rf" in Unix-like systems.
       #>
   Param(
       [Parameter(Mandatory=$true)]
       [string]$Target
   )
   Remove-Item -Recurse -Force $Target
}

function poe() {poetry run poe $args}

Set-Alias gti git
Set-Alias which where.exe
# Invoke-Expression (&starship init powershell)
$env:XDG_CONFIG_HOME = "$HOME\.config"
