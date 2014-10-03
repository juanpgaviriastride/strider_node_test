class App.Views.IM.LeftBar extends Null.Views.Base
  template: JST['app/im/left_bar.html']

  initialize: (opt) =>
    super
    # load roster
    @roster = new App.Views.IM.Chats.Roster()
    @

  render: () =>
    super
    @appendView @roster.render(), '[data-role=roster]'
    @
