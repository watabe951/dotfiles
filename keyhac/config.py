import sys
import os
import datetime
import re
import pyauto
from keyhac import *


def configure(keymap):

    # --------------------------------------------------------------------
    # Text editer setting for editting config.py file

    # Setting with program file path (Simple usage)
    if 0:
        keymap.editor = "code.exe"

    # Setting with callable object (Advanced usage)
    if 1:
        def editor(path):
            shellExecute( None, "C:\\Users\\yuuya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe", '"%s"'% path, "" )
        keymap.editor = editor

    # --------------------------------------------------------------------
    # Customizing the display

    # Font
    keymap.setFont( "MS Gothic", 12 )

    # Theme
    keymap.setTheme("black")

    # --------------------------------------------------------------------

    # Simple key replacement
    keymap.replaceKey("(29)", 235)      # 無変換（29）を 235 とする
    keymap.replaceKey("(28)", 234)      # 変換 (28) を 235 とする
    keymap.replaceKey("LAlt", 235)      # 無変換（29）を 235 とする
    keymap.defineModifier(235, "User0") # 235 を U0 修飾キーとして使う
    keymap.defineModifier(234, "User0") # 235 を U0 修飾キーとして使う

    # keymap.replaceKey("ESC", 233)      # 無変換（29）を 235 とする
    # keymap.replaceKey("ESC", "LWin")      # 無変換（29）を 235 とする
    # keymap.defineModifier(233, "User2") # 無変換を U0 修飾キーとして使う

    # Global keymap which affects any windows
    # SpaceをRShiftにわりあててSandSを実現  
    keymap_global = keymap.defineWindowKeymap(check_func = lambda window : not "mstsc.exe" in window.getProcessName())
    keymap.replaceKey("Space", "RShift")
    keymap_global["O-RShift"] = "Space"
    # keymap_global[ "O-C-RShift"]  = "A-(25)"
    # keymap_global["O-Shift"] = "Space"
    # keymap.replaceKey("Space", "Shift")
    # keymap.defineModifier("Space", "User2")
    # keymap.replaceKey("Space", 234)
    # keymap.defineModifier(234, "User1")
    # keymap_global["O-234"] = "Space"
    # keymap_global["Ctrl-O-234"] = "Ctrl-Space"
    # ワンショットモディファイアとしてShiftをSpaceに定義
    # oops 
    # for any in ("", "S-", "C-", "C-S-", "A-", "A-S-", "A-C-", "A-C-S-", "W-", "W-S-", "W-C-", "W-C-S-", "W-A-", "W-A-S-", "W-A-C-", "W-A-C-S-"):
    #     keymap_global[any + "U1-1"] = any + "Shift"
    # keymap_global["233"] = lambda : shellExecute( None, "C:\\Users\\yuuya\\Desktop\\screencolor\\o.vbs", "", "C:\\Users\\yuuya\\Desktop\\screencolor\\" )

    keymap_global["233"] = lambda : shellExecute( None, "C:\\Users\\yuuya\\workspace\\screencolor\\target\\o.exe", "", "" )

    for arrow in ["Left", "Right", "Up", "Down"]:

        keymap_global[ "U0-"+arrow] = "Win-" + arrow

    keymap_global[ "O-235"] = "ESC"
    keymap_global[ "O-234"] = "ESC"

    keymap_global[ "U0-OpenBracket"] = keymap.MouseWheelCommand(1.0)
    keymap_global[ "U0-CloseBracket"  ] = keymap.MouseWheelCommand(-1.0)
    
    keymap_global[ "U0-N"  ] = keymap.MouseMoveCommand(-10,0)
    keymap_global[ "U0-M"  ] = keymap.MouseMoveCommand(0,10)
    keymap_global[ "U0-Period"    ] = keymap.MouseMoveCommand(10,0)
    keymap_global[ "D-U0-Slash" ] = keymap.MouseButtonDownCommand('left')
    keymap_global[ "U-U0-Slash" ] = keymap.MouseButtonUpCommand('left')

    for modifier in ("", "S-", "C-", "A-", "C-S-", "C-A-", "S-A-", "C-A-S-", "W-", "W-C-", "W-S-"):
        # tab
        keymap_global[modifier + "U0-Comma" ] = modifier + "TAB"
        
        # U0 + numeric {n} = F{n}
        for numeric in [1,2,3,4,5,6,7,8,9,0]:
            keymap_global[modifier + f"U0-{numeric}"] = modifier + f"F{numeric}"
        # 上下左右
        keymap_global[modifier + "U0-U"] = modifier + "Back"
        keymap_global[modifier + "U0-O"] = modifier + "Enter"
        keymap_global[modifier + "U0-H"] = modifier + "Home"
        keymap_global[modifier + "U0-P"] = modifier + "Delete"

        keymap_global[modifier + "U0-J"] = modifier + "Left"
        keymap_global[modifier + "U0-K"] = modifier + "Down"
        keymap_global[modifier + "U0-L"] = modifier + "Right"
        
        # keymap_global[modifier + "U0-Y"] = modifier + "Home"
        keymap_global[modifier + "U0-N"] = modifier + "PageDown"
        keymap_global[modifier + "U0-I"] = modifier + "Up"
        keymap_global[modifier + "U0-M"] = modifier + "PageUp"
        keymap_global[modifier + "U0-Plus"] = modifier + "End"
        # Home / End
        keymap_global[modifier + "U0-E"] = modifier + "W-Up"
        keymap_global[modifier + "U0-S"] = modifier + "W-Left"
        keymap_global[modifier + "U0-D"] = modifier + "W-Down"
        keymap_global[modifier + "U0-F"] = modifier + "W-Right"
        keymap_global[modifier + "U0-A"] = modifier + "ESC"
        keymap_global[modifier + "U0-C"] = modifier + "Space"

        # Toy Runner
        keymap_global[modifier + "U0-R"] = modifier + "Alt-Space"

        # 「カタカナひらがなローマ」キーを徹底的に無視
        keymap_global["D-" + modifier + "(240)"] = lambda: None
        keymap_global["U-" + modifier + "(240)"] = lambda: None
        keymap_global["D-" + modifier + "(241)"] = lambda: None
        keymap_global["U-" + modifier + "(241)"] = lambda: None
        keymap_global["D-" + modifier + "(242)"] = lambda: None
        keymap_global["U-" + modifier + "(242)"] = lambda: None


        # [B]ackSpace / [D]elete
        # keymap_global["U0-D"] = "Delete"
        # keymap_global["U0-B"] = "Back"
        # keymap_global["C-U0-D"] = "C-Delete"
        # keymap_global["C-U0-B"] = "C-Back"
        # keymap_global["S-U0-B"] = "S-Home", "C-X" # 先頭まで切り取り
        # keymap_global["S-U0-D"] = "S-End", "C-X" # 末尾まで切り取り
        # keymap_global["C-S-U0-B"] = "Home", "Back", "End" # 前の行と連結
        # keymap_global["C-S-U0-D"] = "End", "Delete", "End" # 次の行と連結

    # print(keymap_global)
    # keymap_remote_desktop = keymap.defineWindowKeymap(exe_name="mstsc.exe")
