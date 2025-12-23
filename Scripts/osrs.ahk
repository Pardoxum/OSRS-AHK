#Requires AutoHotkey v2.0

isPaused := false

; Alt+S to toggle pause
!s::
{
    global isPaused  ; This is the fix

    isPaused := !isPaused
    ToolTip isPaused ? "Script Paused" : "Script Running"
    SetTimer () => ToolTip(), -1000
}

; --- Hotkeys active only when NOT paused ---
#HotIf !isPaused

; Magic Prayer - 1
1::
{
    if isPaused
        return

    MouseGetPos &originalX, &originalY
    Send "{F3 down}{F3 up}"
	Sleep 50 
;    Click 3080, 1725
	x := Random(3050, 3100)
	y := Random(1695, 1745)
	Click x, y
    MouseMove originalX, originalY, 0
	Sleep 50
	Send "{F1 down}{F1 up}"
}

; Ranged Prayer - 2
2::
{
    if isPaused
        return

    MouseGetPos &originalX, &originalY
    Send "{F3 down}{F3 up}"
	Sleep 50
;    Click 3160, 1725
	x := Random(3135, 3185)
	y := Random(1695, 1745)
	Click x, y
    MouseMove originalX, originalY, 0
	Sleep 50
	Send "{F1 down}{F1 up}"
}

; Mellee Prayer - 3
3::
{
    if isPaused
        return

    MouseGetPos &originalX, &originalY
    Send "{F3 down}{F3 up}"
	Sleep 50
;    Click 3240, 1725
	x := Random(3215, 3265)
	y := Random(1695, 1745)
	Click x, y
    MouseMove originalX, originalY, 0
	Sleep 50
	Send "{F1 down}{F1 up}"
}

; Home TP - H
h::
{
    if isPaused
        return
	
	MouseGetPos &originalX, &originalY
	Send "{F1 down}{F1 up}"
	Sleep 50
;    Click 3300, 1955
	x := Random(3275, 3335)
	y := Random(1930, 1985)
	Click x, y
    MouseMove originalX, originalY, 0
}

; Swap Bottom left wep - E
e::
{
    if isPaused
        return
	
	MouseGetPos &originalX, &originalY
	Send "{F1 down}{F1 up}"
	Sleep 50
;    Click 3010, 1955
	x := Random(2990, 3040)
	y := Random(1930, 1985)
	Click x, y
    MouseMove originalX, originalY, 0
}

; Special Attack - Q
q::
{
    if isPaused
        return
	
	MouseGetPos &originalX, &originalY
	Sleep 50
;    Click 3110, 380
	x := Random(3100, 3135)
	y := Random(360, 400)
	Click x, y
    MouseMove originalX, originalY, 0
}

#HotIf  ; <== This ends the HotIf block23