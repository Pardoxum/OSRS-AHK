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
;    LEFT  TOP  RIGHT BOTTOM
; = BOXES =
boxes := [
    [2835, 1220, 2925, 1310],
    [2960, 1220, 3050, 1310],
    [3085, 1220, 3175, 1310],
	[3210, 1220, 3300, 1310],
    [2835, 1330, 2925, 1420],
    [2960, 1330, 3050, 1420],
    [3085, 1330, 3175, 1420],
    [3210, 1330, 3300, 1420],
    [2835, 1435, 2925, 1525],
    [2960, 1435, 3050, 1525],
    [3085, 1435, 3175, 1525],
    [3210, 1435, 3300, 1525],
    [2835, 1545, 2925, 1635],
    [2960, 1545, 3050, 1635],
    [3085, 1545, 3175, 1635],
    [3210, 1545, 3300, 1635],
    [2835, 1655, 2925, 1750],
    [2960, 1655, 3050, 1750],
    [3085, 1655, 3175, 1750],
    [3210, 1655, 3300, 1750],
    [2835, 1765, 2925, 1855],
    [2960, 1765, 3050, 1855],
    [3085, 1765, 3175, 1855],
    [3210, 1765, 3300, 1855],
    [2835, 1875, 2925, 1965],
    [2960, 1875, 3050, 1965],
    [3085, 1875, 3175, 1965],
    [3210, 1875, 3300, 1965]
]
#HotIf !isPaused
; ================================================================================================================
; === KEYBINDS ===
; Co-ordinates are currently set for 4K monitor, fullscreen runelite, 100% stretched mode, and side-bar open.
; Use MOUSE_POSITION.ahk to obtain your correct co-ordinates if you are using a different setup.
; Make Sure F1 = INVENTORY, F2 = PRAYERS, F3 = MAGIC , F4 = EQUIPMENT

; = Gear Swaps + =
z::
{
    RunColorSearch("magic.png")
    UsePrayer(3145, 3210, 1795, 1855) ;Magic Offensive Prayer
}

x::
{
    RunColorSearch("ranged.png")
    UsePrayer(3045, 3095, 1795, 1855) ;Ranged Offensive Prayer
}

c::
{
    RunColorSearch("melee.png")
    UsePrayer(2925, 2990, 1795, 1855) ;Melee Offensive Prayer
}

q::
{
    RunColorSearch("spec.png")
	Sleep 350
    ClickSpecial(2980, 3045, 480, 525) ;Special Attack
}

h::
{
	RunColorSearch("keris.png")
	Sleep 350
    ClickSpecial(2980, 3045, 480, 525) ;Special Attack
}

; = Gear Swaps =
;c::RunColorSearch("melee.png")
;x::RunColorSearch("ranged.png")
;z::RunColorSearch("magic.png")

; = Defensive Prayers =
1::UsePrayer(2925, 2990, 1575, 1630) ;Mage Defensive Prayer
2::UsePrayer(3045, 3095, 1575, 1630) ;Ranged Defensive Prayer
3::UsePrayer(3145, 3210, 1575, 1630) ;Melee Defensive Prayer

; = Offensive Prayers =
;z::UsePrayer(3145, 3210, 1795, 1855) ;Magic Offensive Prayer
;x::UsePrayer(3045, 3095, 1795, 1855) ;Ranged Offensive Prayer
;c::UsePrayer(2925, 2990, 1795, 1855) ;Melee Offensive Prayer

; = Arceuus Spells =
t::UseMagic(2925, 2975, 1685, 1745) ;Summon Ghost Thrall (Arceuus)
m::UseMagic(2925, 2975, 1525, 1580) ;Mark of Darkness (Arceuus)
n::UseMagic(2925, 2975, 1765, 1815) ;Death Charge (Arceuus)

; = Ancient Spells =
b::UseMagic(2830, 2880, 1855, 1905) ;Ice Barrage (Ancient)
v::UseMagic(3260, 3310, 1745, 1795) ;Blood Barrage (Ancient)

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
;q::ClickSpecial(2980, 3045, 480, 525) ;Special Attack

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


;Gear Swapper
RunColorSearch(colorImageFile)
{
    CoordMode("Pixel", "Screen")
    CoordMode("Mouse", "Screen")
    global boxes

    imagePath := "C:\Users\lukem\iCloudDrive\RS\runescape\Pack\" colorImageFile
    clickedPositions := []
    MouseGetPos &originalX, &originalY

    BlockInput "On"
    Send "{F1}"

    try {
        loop boxes.Length
        {
            box := boxes[A_Index]
            fx := fy := ""
            found := false

            try {
                ImageSearch &fx, &fy, box[1], box[2], box[3], box[4], imagePath
                found := true
            } catch {
                continue
            }

            if found && fx != "" && fy != "" {
                alreadyClicked := false
                for pos in clickedPositions {
                    if (Abs(fx - pos.x) <= 25 && Abs(fy - pos.y) <= 25) {
                        alreadyClicked := true
                        break
                    }
                }

                if !alreadyClicked {
					adjustedX := fx + 3
					adjustedY := fy + 15
                    Click adjustedX, adjustedY
                    clickedPositions.Push({x: fx, y: fy})
                    Sleep 30
                }
            }
        }
    } finally {
        MouseMove originalX, originalY, 0
        BlockInput "Off"
    }
}