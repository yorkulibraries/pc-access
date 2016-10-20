module BestInPlaceHelper

  ## WRAPPER FOR BEST_IN_PLACE WITH SOME DEFAULTS
  def in_place_edit( object, field, *args)
    ok = "\u2713";  cancel = "\u2A09"
    defaults = {
      place_holder: "<span class='weak small'>Fill #{field.to_s.humanize}</span>",
      inner_class: "field",
      ok_button: ok , ok_button_class: "btn btn-link green",
      cancel_button: cancel,
      cancel_button_class: "btn btn-link red"
    }

    options = args.extract_options!
    defaults.merge!(options)

    best_in_place object, field, defaults
  end
end
