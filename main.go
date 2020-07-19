package main

import (
	"fyne.io/fyne"
	fapp "fyne.io/fyne/app"
	gapp "gioui.org/ui/app"

	"github.com/Ariemeth/gearforce/ui/fyneui"
)

const (
	windowTitle    = "Heavy Gear Blitz 3.0 Force Builder"
	startingWidth  = 700
	startingHeight = 400
)

func main() {
	runGioApp()
}

func runGioApp() {
	go func() {
		w := gapp.NewWindow()
		for range w.Events() {
		}
	}()

	gapp.Main()
}

func runFyneApp() {
	a := fapp.New()

	w := a.NewWindow(windowTitle)
	w.Resize(fyne.NewSize(startingWidth, startingHeight))
	w.CenterOnScreen()
	w.SetContent(fyneui.BuildMainWindow(a))

	w.ShowAndRun()
}
