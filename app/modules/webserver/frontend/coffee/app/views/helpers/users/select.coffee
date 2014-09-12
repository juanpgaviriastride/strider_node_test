class App.Views.Helpers.Users.Select extends System.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Users()

    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      text: "#{item.get('name')?.prefix} #{item.get('name')?.first} #{item.get('name')?.last}"
    }
