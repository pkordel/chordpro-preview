ChordproView = require './chordpro-view'
{CompositeDisposable} = require 'atom'

module.exports = Chordpro =
  chordproView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @chordproView = new ChordproView(state.chordproViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @chordproView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'chordpro:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @chordproView.destroy()

  serialize: ->
    chordproViewState: @chordproView.serialize()

  toggle: ->
    console.log 'Chordpro was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
