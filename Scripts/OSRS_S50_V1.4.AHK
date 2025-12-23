#Requires AutoHotkey v2.0+

; === AUTHOR ===
;Created by Pardoxum
;Don't sell this shit, its free

; === PAUSE ===
; Use ALT+S TO PAUSE

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
; Co-ordinates are currently set for 4K monitor, fullscreen runelite, 50% stretched mode, and side-bar open.
; Use MOUSE_POSITION.ahk to obtain your correct co-ordinates if you are using a different setup.
; Make Sure F1 = INVENTORY, F2 = PRAYERS, F3 = MAGIC , F4 = EQUIPMENT

; = Prayers =
1::UsePrayer(3050, 3100, 1695, 1745) ;Mage Defensive Prayer
2::UsePrayer(3135, 3185, 1695, 1745) ;Ranged Defensive Prayer
3::UsePrayer(3215, 3265, 1695, 1745) ;Melee Defensive Prayer
z::UsePrayer(3215, 3265, 1865, 1915) ;Magic Offensive Prayer
x::UsePrayer(3135, 3185, 1865, 1915) ;Ranged Offensive Prayer
c::UsePrayer(3050, 3100, 1865, 1915) ;Melee Offensive Prayer

; = Arceuus Spells =
t::UseMagic(3045, 3085, 1785, 1830) ;Summon Ghost Thrall (Arceuus)
m::UseMagic(3045, 3085, 1665, 1710) ;Mark of Darkness (Arceuus)
n::UseMagic(3045, 3085, 1845, 1885) ;Death Charge (Arceuus)

; = Ancient Spells =
b::UseMagic(3000, 3040, 1910, 1945) ;Ice Barrage (Ancient)
v::UseMagic(3280, 3315, 1835, 1865) ;Blood Barrage (Ancient)

; = Lunar Spells =
h::UseMagic(3130, 3180, 1480, 1525) ;Humidify (Lunar)

; = Inventory =
e::UseItem(2990, 3040, 1435, 1480) ;1st inv slot (top left)
r::UseItem(3075, 3135, 1435, 1480) ;2nd inv slot (2nd top left)
;::UseItem(2990, 3040, 1845, 1900) ;21st inv slot (above bottom left)
f::UseItem(2990, 3040, 1930, 1985) ;25th inv slot (bottom left)
g::UseItem(3075, 3135, 1930, 1985) ;26th inv slot (2nd bottom left)
y::UseItem(3275, 3335, 1930, 1985) ;28th inv slot (bottom right)

,::QuickUse(2990, 3040, 1435, 1480) ;top left item
.::QuickUse(3075, 3135, 1435, 1480) ;top mid-left item

; = Spec =
q::ClickSpecial(3100, 3135, 360, 400) ;Special Attack

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
		Sleep Random(75, 95)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(30, 40)
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
		Sleep Random(75, 95)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(30, 40)
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
		Sleep Random(75, 95)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(30, 40)
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
		Sleep Random(75, 95)
		Click Random(xMin, xMax), Random(yMin, yMax)
		Sleep Random(30, 40)
		MouseMove originalX, originalY, 0
	} finally {
        BlockInput "Off"
    }
}