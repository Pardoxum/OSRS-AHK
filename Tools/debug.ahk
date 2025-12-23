#Requires AutoHotkey v2.0
#SingleInstance Force

; === CONFIGURATION ===
CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")

; Search box corners (user settings)
topLeft := [2950, 1420]
topRight := [3365, 1420]
bottomLeft := [2950, 2005]
bottomRight := [3365, 2005]

; Click delay in ms
clickDelay := 15

; Color to search
targetColor := 0x00FF4D
colorVariation := 255

; Compute bounding rectangle
searchLeft   := min(topLeft[1], topRight[1], bottomLeft[1], bottomRight[1])
searchTop    := min(topLeft[2], topRight[2], bottomLeft[2], bottomRight[2])
searchRight  := max(topLeft[1], topRight[1], bottomLeft[1], bottomRight[1])
searchBottom := max(topLeft[2], topRight[2], bottomLeft[2], bottomRight[2])

; Register hotkey
Hotkey("z", AutoClickTargetColor)

; === SCRIPT FUNCTION ===
AutoClickTargetColor(*) {
    global searchLeft, searchTop, searchRight, searchBottom
    global targetColor, colorVariation, clickDelay

    options := "Variation" colorVariation " RGB"
    Hotkey("z", "Off")

    try {
        x := searchLeft
        y := searchTop

        MsgBox "Starting search from (" x "," y ") to (" searchRight "," searchBottom ") with color " Format("0x{:06X}", targetColor)

        Loop {
            try {
                PixelSearch &foundX, &foundY, x, y, searchRight, searchBottom, targetColor, options
            } catch {
                MsgBox "No more matching pixels found."
                break
            }

            MsgBox "FOUND at " foundX ", " foundY
            MouseClick("left", foundX, foundY)
            Sleep(clickDelay)

            x := foundX + 1
            if (x > searchRight) {
                x := searchLeft
                y := foundY + 1
                if (y > searchBottom)
                    break
            }
        }
    } finally {
        Hotkey("z", "On")
    }
}

