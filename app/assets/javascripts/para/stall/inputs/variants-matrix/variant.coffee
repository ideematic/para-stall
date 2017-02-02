class VariantsMatrix.Variant extends Vertebra.View
  events:
    'change [data-variants-matrix-variant-published]': 'onPublishedStateChanged'

  initialize: (options = {}) ->
    @combination = options.combination
    @persisted = @$el?.data('variant-id')
    @input = options.input
    @onPublishedStateChanged()

  renderTo: ($container) ->
    $variant = $(@input.nestedFieldsManager.render())
    $variant.appendTo($container)
    @setElement($variant)
    @$el.simpleForm()
    @fillProperties()

  fillProperties: ->
    for property in @properties()
      $property = @$("[data-variants-matrix-variant-property='#{ property.type }']")
      $property.find('[data-property-name]').html(property.name)
      $property.find('[data-property-id]').val(property.id)

  remove: ->
    if @persisted
      @$el.hide(0)
      @setDestroyed(true)
    else
      @$el.remove()
      @trigger('destroy', this)

  show: ->
    @$el.show(0)
    @setDestroyed(false)

  matches: (combination) ->
    VariantsMatrix.objectsAreEqual(@combination, combination)

  properties: ->
    @_properties ?= (@buildPropertyFor(key, value) for key, value of @combination when @combination.hasOwnProperty(key))

  buildPropertyFor: (key, value) ->
    id: value
    name: @input.nameForProperty(key, value)
    type: key

  onPublishedStateChanged: ->
    checked = @$('[data-variants-matrix-variant-published]').prop('checked')
    @$el.toggleClass('disabled', !checked)
