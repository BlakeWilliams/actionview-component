# frozen_string_literal: true

class SlotDslComponent < ViewComponent::Base
  include ViewComponent::SlotableDSL

  slot :title do |classes|
    def foo
      "bar"
    end
  end

  def initialize(class_names: "")
    @class_names = class_names
  end
end
