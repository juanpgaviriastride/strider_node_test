class App.Views.Helpers.Contacts.Select extends System.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Contacts()

    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      text: "#{item.escape('contact_name')} (#{item.escape('contact_username')})"
    }