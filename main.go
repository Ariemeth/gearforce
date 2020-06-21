package main

import (
	"fmt"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/widget"

	"github.com/Ariemeth/gearforce/notifier"
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

	faction := notifier.String{}
	// Configure the Faction select
	factionSelect := widget.NewSelect(factionList(), func(s string) {
		faction.Set(s)
	})
	factionSelect.PlaceHolder = "Select Faction"

	// Configure the subfaction select
	subfactionSelect := widget.NewSelect([]string{}, func(s string) {

	})
	subfactionSelect.PlaceHolder = "Select faction sub-list"
	subfactionUpdate := make(chan string)
	go func() {
		for {
			select {
			case factionName := <-subfactionUpdate:
				subfactionSelect.Options = getSubLists(factionName)
				subfactionSelect.ClearSelected()
			}
		}
	}()
	faction.Subscribe("subfaction-update", subfactionUpdate)

	sublistItem := widget.NewFormItem("Sub-list:", subfactionSelect)

	// Create combat group display
	forceDisplay := buildForceDisplay()

	pointsDisplay := widget.NewLabel("0")

	w := widget.NewVBox(
		widget.NewForm(
			widget.NewFormItem("Player Name:", widget.NewEntry()),
			widget.NewFormItem("Force Name:", widget.NewEntry()),
		),
		widget.NewForm(
			widget.NewFormItem("Faction:", factionSelect),
			sublistItem,
		),
		widget.NewForm(
			widget.NewFormItem("Points:", pointsDisplay),
		),
		forceDisplay,
		widget.NewButton("Quit", func() {
			app.Quit()
		}))

	return w
}

func buildForceDisplay() fyne.CanvasObject {

	w := widget.NewVBox()

	tabMenu := widget.NewTabContainer(widget.NewTabItem("CG1", buildCombatGroup()))
	addCombatGroupButton := widget.NewButton("Add CG", func() {
		tabMenu.Append(widget.NewTabItem(fmt.Sprintf("CG%d", len(tabMenu.Items)+1), buildCombatGroup()))
	})

	w.Append(widget.NewHBox(addCombatGroupButton))
	w.Append(tabMenu)

	return w
}

func buildCombatGroup() fyne.CanvasObject {

	w := widget.NewVBox()

	primaryUASelection := widget.NewSelect(uaLists(), func(string) {})
	primaryUAPoints := widget.NewLabel("0")
	primaryUAActions := widget.NewLabel("0")
	primaryInfo := widget.NewVBox(
		//		widget.NewLabel("Primary"),
		widget.NewHBox(widget.NewLabel("UA"), widget.NewHBox(primaryUASelection)),
		widget.NewHBox(widget.NewLabel("Points"), primaryUAPoints),
		widget.NewHBox(widget.NewLabel("Actions"), primaryUAActions),
	)
	primaryUnits := widget.NewHScrollContainer(widget.NewHBox())
	primary := widget.NewGroup("Primary", primaryInfo, fyne.NewContainerWithLayout(layout.NewAdaptiveGridLayout(4), primaryUnits))

	secondaryUASelection := widget.NewSelect(uaLists(), func(string) {})
	secondaryUAPoints := widget.NewLabel("0")
	secondaryUAActions := widget.NewLabel("0")
	secondaryInfo := widget.NewVBox(
		widget.NewHBox(widget.NewLabel("UA"), widget.NewHBox(secondaryUASelection)),
		widget.NewHBox(widget.NewLabel("Points"), secondaryUAPoints),
		widget.NewHBox(widget.NewLabel("Actions"), secondaryUAActions),
	)
	secondaryUnits := widget.NewHScrollContainer(widget.NewHBox())
	secondary := widget.NewGroup("Secondary", secondaryInfo, fyne.NewContainerWithLayout(layout.NewAdaptiveGridLayout(4), secondaryUnits))

	w.Append(primary)
	w.Append(secondary)

	return w
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

func uaLists() []string {
	return []string{
		"GP",
		"SK",
		"FS",
		"RC",
		"SF",
		"PT",
		"VL",
		"AIR",
		"FORT",
	}
}

func northSubLists() []string {
	return []string{
		"Northern Guard",
		"Western Frontier Protectorate",
		"United Mercantile Federation",
		"Northern Lights Confederacy",
	}
}

func southSubLists() []string {
	return []string{
		"MILitary Intervention and Counter Insurgency Army",
		"Southern Republic Army",
		"Mekong Dominion",
		"Eastern Sun Emirates",
		"Humanist Alliance Protection Force",
	}
}

func peaceRiverSubLists() []string {
	return []string{
		"Peace River Defense Force",
		"Peace Officer Corps",
		"Home Guard Security Forces",
		"Combined Task Force",
		"Protectorate Sponsored Badlands Militia",
	}
}
