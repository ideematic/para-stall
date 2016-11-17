#= require_self
#= require ./variants_matrix/helpers
#= require ./variants_matrix/nested_fields
#= require ./variants_matrix/input
#= require ./variants_matrix/variant

@VariantsMatrix = {}

$(document).on 'page:change turbolinks:load', ->
  $('[data-variants-matrix-input]').each (i, el) ->
    new VariantsMatrix.Input(el: el)
