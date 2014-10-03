class App.Views.Common.Helpers.Locations.Select extends Null.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Locations()
    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      text: "#{item.escape('display_name')}"
    }
