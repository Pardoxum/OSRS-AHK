#Requires AutoHotkey v2.0+

; === AUTHOR ===
;Created by Pardoxum
;Don't sell this shit, its free

; === SETTINGS ===
CoordMode "Mouse", "Screen"

; === PAUSE ===
; Use ALT+S TO PAUSE
isPaused := false

!s::
{
    global isPaused
    isPaused := !isPaused
    ToolTip(isPaused ? "PAUSED" : "RUNNING")
    SetTimer () => ToolTip(), -1000
}

; === AUTO ALTERNATE TOGGLE (/) ===
isAuto := false

/::
{
    global isAuto
    isAuto := !isAuto

    if (isAuto) {
        ToolTip("AUTO: ON")
        SetTimer () => ToolTip(), -800
        ; kick off the alternator immediately
        SetTimer AutoAlt, -10
    } else {
        ToolTip("AUTO: OFF")
        SetTimer () => ToolTip(), -800
        ; stop scheduling new ticks
        SetTimer AutoAlt, 0
    }
}

; Schedules itself with a new random delay each tick
AutoAlt() {
    global isAuto, isPaused
    static side := 0  ; 0 = use ',', 1 = use '.'

    if !isAuto
        return

    if isPaused {
        ; while paused, just check back shortly
        SetTimer AutoAlt, -150
        return
    }

    ; === YOUR TWO ACTIONS ===
    if (side = 0) {
        ; mimic ',' action (top left item)
        QuickUse(2990, 3040, 1435, 1480)
        delay := Random(25, 120)      ; random interval for ','
        side := 1
    } else {
        ; mimic '.' action (top mid-left item)
        QuickUse(3075, 3135, 1435, 1480)
        delay := Random(25, 120)      ; random interval for '.'
        side := 0
    }

    ; schedule next tick with the chosen delay
    SetTimer AutoAlt, -delay
}

#HotIf !isPaused
; === KEYBINDS ===
,::QuickUse(2990, 3040, 1435, 1480) ; top left item
.::QuickUse(3075, 3135, 1435, 1480) ; top mid-left item
#HotIf

; === FUNCTIONS ===
QuickUse(xMin, xMax, yMin, yMax)
{
    Click Random(xMin, xMax), Random(yMin, yMax)
}
