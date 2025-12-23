#Requires AutoHotkey v2.0+
; = SINGLE INSTANCE PROTECTION =
if !SingleInstance()
{
    MsgBox "Script is already running.", "Info", "OK"
    ExitApp
}
SingleInstance() {
    static hMutex := DllCall("CreateMutex", "ptr", 0, "int", false, "str", "AlfaScripts", "ptr")
    return !A_LastError  ; A_LastError = 0 → mutex was created, script is first instance
}

; === AUTHOR ===
;Created by Pardoxum
;Don't sell this shit, its free

; === PAUSE ===
; Use ALT+S TO PAUSE

A_DetectHiddenWindows := true
DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr") ; Per-monitor DPI aware

global isPaused := false
global isClicking := false

!s::
{
	global isPaused
    isPaused := !isPaused
    ToolTip(isPaused ? "PAUSED" : "RUNNING")
    SetTimer () => ToolTip(), -1000
}

; === AUTO CLICK ===
/:: ; Press / to start/stop auto-click
{
    global isPaused, isClicking
    if isPaused {
        SendText("/") ; Fix: no recursive hotkey trigger
        return
    }

    isClicking := !isClicking
	ToolTip(isClicking ? "CLICKING" : "STOPPED")
	SetTimer () => ToolTip(), -1000
    if isClicking {
        StartClicking()
    } else {
        StopClicking()
    }
}

StartClicking()
{
    ClickLoop()
}

StopClicking()
{
    SetTimer ClickLoop, 0
}

ClickLoop()
{
    global isClicking, isPaused
    if !isClicking or isPaused
        return

    Click() ; Perform click

    interval := Random(1000, 2000)
    SetTimer ClickLoop, -interval
}

#HotIf !isPaused
; ================================================================================================================
; === KEYBINDS ===
; Co-ordinates are currently set for 4K monitor, fullscreen runelite, 100% stretched mode, and side-bar open.
; Use MOUSE_POSITION.ahk to obtain your correct co-ordinates if you are using a different setup.
; Make Sure F1 = INVENTORY, F2 = PRAYERS, F3 = MAGIC , F4 = EQUIPMENT

; = Prayers =
1::UsePrayer(2925, 2990, 1575, 1630) ;Mage Defensive Prayer
2::UsePrayer(3045, 3095, 1575, 1630) ;Ranged Defensive Prayer
3::UsePrayer(3145, 3210, 1575, 1630) ;Melee Defensive Prayer
z::UsePrayer(3145, 3210, 1795, 1855) ;Magic Offensive Prayer
x::UsePrayer(3045, 3095, 1795, 1855) ;Ranged Offensive Prayer
c::UsePrayer(2925, 2990, 1795, 1855) ;Melee Offensive Prayer

; = Arceuus Spells =
t::UseMagic(2925, 2975, 1685, 1745) ;Summon Ghost Thrall (Arceuus)
m::UseMagic(2925, 2975, 1525, 1580) ;Mark of Darkness (Arceuus)
n::UseMagic(2925, 2975, 1765, 1815) ;Death Charge (Arceuus)

; = Ancient Spells =
b::UseMagic(2830, 2880, 1855, 1905) ;Ice Barrage (Ancient)
v::UseMagic(3260, 3310, 1745, 1795) ;Blood Barrage (Ancient)

; = Lunar Spells =
h::UseMagic(3035, 3095, 1280, 1335) ;Humidify (Lunar)

; = Inventory =
e::UseItem(2840, 2915, 1225, 1300) ;1st inv slot (top left)
r::UseItem(2965, 3040, 1225, 1300) ;2nd inv slot (2nd top left)
;::UseItem(2840, 2915, 1765, 1845) ;21st inv slot (above bottom left)
f::UseItem(2840, 2915, 1875, 1950) ;25th inv slot (bottom left)
g::UseItem(2965, 3040, 1875, 1950) ;26th inv slot (2nd bottom left)
y::UseItem(3220, 3295, 1875, 1950) ;28th inv slot (bottom right)

,::QuickUse(2840, 2915, 1225, 1300) ;top left item
.::QuickUse(2965, 3040, 1225, 1300) ;top mid-left item

; = Spec =
q::ClickSpecial(2980, 3045, 480, 525) ;Special Attack

; ================================================================================================================

#HotIf

; === FUNCTIONS ===

;F2 For prayer Menu Required
;Use Prayer Spell
UsePrayer(xMin, xMax, yMin, yMax)
{
	try {
		BlockInput "On"
		originalX := 0, originalY := 0
		MouseGetPos &originalX, &originalY
		Send "{F2}"
		Sleep Random(70, 80)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(25, 35)
		MouseMove originalX, originalY, 0
		Send "{F1}"
	} finally {
        BlockInput "Off"
    }
}

;F1 For Inventory Required
;Use Item Selected
UseItem(xMin, xMax, yMin, yMax)
{
	try {
		BlockInput "On"
		originalX := 0, originalY := 0
		MouseGetPos &originalX, &originalY
		Send "{F1}"
		Sleep Random(70, 80)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(25, 35)
		MouseMove originalX, originalY, 0
	} finally {
        BlockInput "Off"
    }
}

;Use Selected
QuickUse(xMin, xMax, yMin, yMax)
{
    Click Random(xMin, xMax), Random(yMin, yMax)
}

;F3 For Magic Book Required
;Use Magic Spell
UseMagic(xMin, xMax, yMin, yMax)
{
	try {
		BlockInput "On"
		originalX := 0, originalY := 0
		MouseGetPos &originalX, &originalY
		Send "{F3}"
		Sleep Random(70, 80)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(25, 35)
		MouseMove originalX, originalY, 0
		Send "{F1}"
	} finally {
        BlockInput "Off"
    }
}

;Toggle special attack
ClickSpecial(xMin, xMax, yMin, yMax)
{
	try {
		BlockInput "On"
		originalX := 0, originalY := 0
		MouseGetPos &originalX, &originalY
		Sleep Random(70, 80)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(25, 35)
		MouseMove originalX, originalY, 0
	} finally {
        BlockInput "Off"
    }
}