package main

import (
	"image/color"

	"fyne.io/fyne"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/theme"
	"fyne.io/fyne/widget"
)

type table struct {
	widget.BaseWidget
	background color.Color

	Children []*tableRow
}

func newTable(children ...*tableRow) *table {
	return &table{BaseWidget: widget.BaseWidget{}, Children: children}
}

// CreateRenderer creates a renderer that is linked to the table.
func (t *table) CreateRenderer() fyne.WidgetRenderer {
	return newTableRenderer(t)
}

type tableRenderer struct {
	layout fyne.Layout
	table  *table
}

// NewtableRenderer creates a new tableRenderer.
func newTableRenderer(t *table) *tableRenderer {
	return &tableRenderer{table: t, layout: layout.NewHBoxLayout()}
}

func (r *tableRenderer) Layout(size fyne.Size) {
	r.layout.Layout(r.Objects(), size)
}

func (r tableRenderer) MinSize() fyne.Size {
	return r.layout.MinSize(r.Objects())
}

// Refresh updates this table to match the current theme.
func (r *tableRenderer) Refresh() {
	if r.table.background != nil {
		r.table.background = theme.BackgroundColor()
	}

	r.table.BaseWidget.Refresh()
}

// BackgroundColor returns the theme background color.
// Implements: fyne.WidgetRenderer
func (r *tableRenderer) BackgroundColor() color.Color {
	return theme.BackgroundColor()
}

// Destroy does nothing in the base implementation.
// Implements: fyne.WidgetRenderer
func (r *tableRenderer) Destroy() {
}

// Objects returns the objects that should be rendered.
// Implements: fyne.WidgetRenderer
func (r *tableRenderer) Objects() []fyne.CanvasObject {
	r.table.ExtendBaseWidget(r.table)

	c := []fyne.CanvasObject{}
	for i := 0; i < len(r.table.Children); i++ {
		c = append(c, r.table.Children[i])
	}
	return c
}

type tableRow struct {
	widget.BaseWidget
	background color.Color

	Children []fyne.CanvasObject
}

func newTableRow(children ...fyne.CanvasObject) *tableRow {
	return &tableRow{BaseWidget: widget.BaseWidget{}, Children: children}
}

func (t *tableRow) MinSize() fyne.Size {
	return t.BaseWidget.MinSize()
}

type tableRowRenderer struct {
	layout   fyne.Layout
	tableRow *tableRow
}

// NewTableRowRenderer creates a new tableRowRenderer.
func newTableRowRenderer(t *tableRow) *tableRowRenderer {
	return &tableRowRenderer{tableRow: t}
}

func (r *tableRowRenderer) Layout(size fyne.Size) {
	r.layout.Layout(r.Objects(), size)
}

func (r *tableRowRenderer) MinSize() fyne.Size {
	return r.layout.MinSize(r.Objects())
}

// Refresh updates this table to match the current theme.
func (r *tableRowRenderer) Refresh() {
	if r.tableRow.background != nil {
		r.tableRow.background = theme.BackgroundColor()
	}

	r.tableRow.BaseWidget.Refresh()
}

// BackgroundColor returns the theme background color.
// Implements: fyne.WidgetRenderer
func (r *tableRowRenderer) BackgroundColor() color.Color {
	return theme.BackgroundColor()
}

// Destroy does nothing in the base implementation.
// Implements: fyne.WidgetRenderer
func (r *tableRowRenderer) Destroy() {
}

// Objects returns the objects that should be rendered.
// Implements: fyne.WidgetRenderer
func (r *tableRowRenderer) Objects() []fyne.CanvasObject {
	return r.tableRow.Children
}
