class App.Views.Helpers.Locations.Select extends System.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Locations()
    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      text: "#{item.escape('display_name')}"
    }
