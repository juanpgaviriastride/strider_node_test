class App.Views.Helpers.Patients.Select extends System.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Patients()

    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      text: "#{item.get('name').prefix} #{item.get('name').first} #{item.get('name').last}"
    }
