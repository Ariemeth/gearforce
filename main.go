package main

import (
	"fmt"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/widget"

	"github.com/Ariemeth/gearforce/unit"
)

const (
	windowTitle    = "Heavy Gear Blitz 3.0 Force Builder"
	startingWidth  = 600
	startingHeight = 400
)

func main() {

	a := app.New()

	w := a.NewWindow(windowTitle)
	w.Resize(fyne.NewSize(startingWidth, startingHeight))
	w.CenterOnScreen()
	w.SetContent(buildMainWindow(a))

	w.ShowAndRun()
}

func buildMainWindow(app fyne.App) fyne.CanvasObject {

	subfactionSelect := widget.NewSelect([]string{}, func(string) {})
	subfactionSelect.PlaceHolder = "Select faction sub-list"

	factionSelect := widget.NewSelect(factionList(), func(s string) {
		subfactionSelect.Options = getSubLists(s)
		subfactionSelect.SetSelected("")
	})
	factionSelect.PlaceHolder = "Select Faction"

	sublistItem := widget.NewFormItem("Sub-list:", subfactionSelect)

	// consider creating a custom widget for the combat groups
	cgLayout := layout.NewGridLayoutWithColumns(4)
	combatGroupList := fyne.NewContainerWithLayout(cgLayout)
	combatGroupBox := widget.NewHBox()
	combatGroupBox.Append(widget.NewButton("Add Combat Group", func() {
		combatGroupList.AddObject(buildCombatGroupDisplay())
		combatGroupBox.Refresh()
	}))

	w := widget.NewVBox(
		widget.NewForm(
			widget.NewFormItem("Player Name:", widget.NewEntry()),
			widget.NewFormItem("Force Name:", widget.NewEntry()),
		),
		widget.NewForm(
			widget.NewFormItem("Faction:", factionSelect),
			sublistItem,
		),
		combatGroupBox,
		combatGroupList,
		widget.NewButton("Quit", func() {
			app.Quit()
		}),
	)

	return w
}

func buildCombatGroupDisplay() fyne.CanvasObject {
	g := unit.Hunter

	f := widget.NewForm(
		widget.NewFormItem("Model:", widget.NewLabel(fmt.Sprintf("%s %s", g.Model, g.SubModel))),
		widget.NewFormItem("TV:", widget.NewLabel(fmt.Sprintf("%d", g.TV))),
		widget.NewFormItem("Armor:", widget.NewLabel(fmt.Sprintf("%d", g.Armor))),
		widget.NewFormItem("H/S:", widget.NewLabel(fmt.Sprintf("%d/%d", g.Hull, g.Structure))),
	)

	return f
}

func factionList() []string {
	return []string{
		"North",
		"South",
		"Peace River",
	}
}

func getSubLists(faction string) []string {
	switch faction {
	case "North":
		return northSubLists()
	case "South":
		return southSubLists()
	case "Peace River":
		return peaceRiverSubLists()
	}
	return []string{}
}

func northSubLists() []string {
	return []string{
		"",
		"Northern Guard",
		"Western Frontier Protectorate",
		"United Mercantile Federation",
		"Northern Lights Confederacy",
	}
}

func southSubLists() []string {
	return []string{
		"",
		"MILitary Intervention and Counter Insurgency Army",
		"Southern Republic Army",
		"Mekong Dominion",
		"Eastern Sun Emirates",
		"Humanist Alliance Protection Force",
	}
}

func peaceRiverSubLists() []string {
	return []string{
		"",
		"Peace River Defense Force",
		"Peace Officer Corps",
		"Home Guard Security Forces",
		"Combined Task Force",
		"Protectorate Sponsored Badlands Militia",
	}
}
