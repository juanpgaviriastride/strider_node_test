class App.Views.Common.Helpers.Patients.Select extends Null.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Patients()

    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      text: "#{item.get('name').prefix} #{item.get('name').first} #{item.get('name').last}"
    }
