#Requires AutoHotkey v2.0

; === AUTHOR ===
;Created by Alfa
;Don't sell this shit, its free

CoordMode "Mouse", "Screen"

SetTimer ShowMousePos, 100

ShowMousePos() {
    x := 0, y := 0
    MouseGetPos &x, &y
    ToolTip "Mouse Position:`nX: " x "`nY: " y
}

Esc::ExitApp  ; Press ESC to exit the script
