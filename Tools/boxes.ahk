#Requires AutoHotkey v2.0
DllCall("SetProcessDPIAware")
;    LEFT  TOP   RIGHT  BOT
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

0::PreviewBoxes()


PreviewBoxes() {
    local previews := []

    for box in boxes {
        x := box[1], y := box[2]
        w := box[3] - box[1]
        h := box[4] - box[2]

        myGui := Gui("+AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x20")
        myGui.BackColor := "Red"
        myGui.SetFont("s10", "Arial")
        myGui.Add("Text", "cWhite BackgroundTrans Center", "")
        myGui.Show("x" x " y" y " w" w " h" h " NA")
        WinSetTransparent(100, myGui.Hwnd)

        previews.Push(myGui)
    }

    SetTimer () => DestroyPreviews(previews), -3000
}

DestroyPreviews(previews) {
    for myGui in previews
        myGui.Destroy()
}