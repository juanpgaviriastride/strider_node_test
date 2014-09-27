class App.Views.Helpers.Users.Select extends System.Views.Helpers.Select

  initialize: (options) =>
    @collection = new App.Collections.Users()

    super
    @render()

  renderOption: (item) =>
    return {
      value: item.id,
      data:
        username: item.get('username') 
      text: "#{item.escape('prefix_name')} #{item.escape('first_name')} #{item.escape('last_name')}"
    }
