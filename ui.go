package main

import (
	"fmt"

	"fyne.io/fyne"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/widget"

	"github.com/Ariemeth/gearforce/faction"
	"github.com/Ariemeth/gearforce/notifier"
	"github.com/Ariemeth/gearforce/unit"
)

// buildMainWindow creates the main application window.
func buildMainWindow(app fyne.App) fyne.CanvasObject {

	selectedFaction := notifier.String{}
	// Configure the Faction select
	factionSelect := widget.NewSelect(faction.Names(), func(s string) {
		selectedFaction.Set(s)
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
				subfactionSelect.Options = faction.SubList(factionName)
				subfactionSelect.ClearSelected()
			}
		}
	}()
	selectedFaction.Subscribe("subfaction-update", subfactionUpdate)

	sublistItem := widget.NewFormItem("Sub-list:", subfactionSelect)

	// Create combat group display
	forceDisplay := buildForceDisplay(&selectedFaction)

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

func buildForceDisplay(faction notifier.ReadOnlyString) fyne.CanvasObject {

	w := widget.NewVBox()

	tabMenu := widget.NewTabContainer(widget.NewTabItem("CG1", buildCombatGroup(faction)))
	addCombatGroupButton := widget.NewButton("Add CG", func() {
		tabMenu.Append(widget.NewTabItem(fmt.Sprintf("CG%d", len(tabMenu.Items)+1), buildCombatGroup(faction)))
	})

	w.Append(widget.NewHBox(addCombatGroupButton))
	w.Append(tabMenu)

	return w
}

func buildCombatGroup(faction notifier.ReadOnlyString) fyne.CanvasObject {

	cg := widget.NewVBox()

	primary := buildPrimaryUA(faction)
	secondary := buildSecondaryUA(faction)

	cg.Append(primary)
	cg.Append(secondary)

	return cg
}

func buildPrimaryUA(faction notifier.ReadOnlyString) *widget.Group {
	selectedUA := notifier.String{}
	primaryUASelection := widget.NewSelect(unit.UALists(), func(ua string) {
		selectedUA.Set(ua)
	})

	primaryUAPoints := widget.NewLabel("0")
	primaryUAActions := widget.NewLabel("0")
	primaryUnits := widget.NewHBox()
	primaryInfo := widget.NewVBox(
		widget.NewForm(
			widget.NewFormItem("UA", widget.NewHBox(primaryUASelection)),
			widget.NewFormItem("Points", primaryUAPoints),
			widget.NewFormItem("Actions", primaryUAActions),
		),
		widget.NewHBox(widget.NewButton("Add Unit",
			func() {
				// TODO: Update to allow only 1 unit select window to be opened at at time.
				ua := primaryUASelection.Selected
				fmt.Printf("UA selected: %s\n", ua)
				unitDisplay, err := buildUnitSelectionWindow(faction.Get(), &selectedUA)
				if err != nil {
					fmt.Print(err)
					return
				}
				w := fyne.CurrentApp().NewWindow("Units")
				w.SetContent(unitDisplay)
				w.CenterOnScreen()
				w.Show()
			})),
	)

	primary := widget.NewGroup(
		"Primary",
		fyne.NewContainerWithLayout(
			layout.NewBorderLayout(
				nil,
				nil,
				primaryInfo,
				nil,
			),
			primaryInfo,
			widget.NewHScrollContainer(primaryUnits),
		))

	return primary
}

func buildUnitSelectionWindow(faction string, selectedUA notifier.ReadOnlyString) (fyne.CanvasObject, error) {
	units, err := unit.GetFactionUnits(faction)
	if err != nil {
		return nil, err
	}
	main := widget.NewVBox()

	ua := selectedUA.Get()

	for _, unit := range units.FilterByUA(ua) {
		main.Append(widget.NewHBox(
			widget.NewLabel(fmt.Sprintf("%s %s", unit.SubModel, unit.Model)),
		))
	}

	if len(main.Children) == 0 {
		main.Append(widget.NewLabel(fmt.Sprintf("No Units available for %s", ua)))
	}

	return main, nil
}

func buildSecondaryUA(faction notifier.ReadOnlyString) *widget.Group {
	secondaryUASelection := widget.NewSelect(unit.UALists(), func(string) {})
	secondaryUAPoints := widget.NewLabel("0")
	secondaryUAActions := widget.NewLabel("0")
	secondaryInfo := widget.NewVBox(
		widget.NewForm(
			widget.NewFormItem("UA", widget.NewHBox(secondaryUASelection)),
			widget.NewFormItem("Points", secondaryUAPoints),
			widget.NewFormItem("Actions", secondaryUAActions),
		),
	)

	secondaryUnits := widget.NewHScrollContainer(widget.NewHBox())

	secondary := widget.NewGroup(
		"Secondary",
		fyne.NewContainerWithLayout(
			layout.NewBorderLayout(
				nil,
				nil,
				secondaryInfo,
				nil,
			),
			secondaryInfo,
			secondaryUnits,
		))
	return secondary
}
