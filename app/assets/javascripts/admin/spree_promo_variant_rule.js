//= require admin/spree_backend

$.fn.variantMultiAutocomplete = function() {
  this.select2({
    minimumInputLength: 1,
    multiple: true,
    initSelection: function(element, callback) {
      $.get(Spree.routes.variants_search, { ids: element.val().split(',') }, function(data) { 
        callback(data['variants'])
      })
    },
    ajax: {
      url: Spree.routes.variants_search,
      datatype: 'json',
      data: function(term, page) {
        return { 
          q: {
            "product_name_or_sku_cont": term
          }
        }
      },
      results: function(data, page) {
        return { results: data['variants'] }
      }
    },
    formatResult: function(variant) {
      return variant.name + (variant.options_text ? ' - ' + variant.options_text : '');
    },
    formatSelection: function(variant) {
      return variant.name + (variant.options_text ? ' - ' + variant.options_text : '');
    }
  });
}

$(document).ready(function () {
  $('.variant_picker').variantMultiAutocomplete();
})
