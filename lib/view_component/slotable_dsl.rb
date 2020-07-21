# frozen_string_literal: true

require "active_support/concern"
require "view_component/slot"
require "view_component/slotable"

module ViewComponent
  module SlotableDSL
    extend ActiveSupport::Concern

    class_methods do
      def slot(name, collection: false, &block)
        slot_class_name = generate_slot_class_name(name)
        slot_class = Class.new(ViewComponent::Slot)

        argument_names = block.parameters.map(&:second)
        argument_args = argument_names.map { |arg| "#{arg}: nil" }.join(", ")
        argument_attrs = argument_names.map do |param|
          "@#{param} = #{param}"
        end.join(";")
        argument_accessors = "attr_reader " + argument_names.map { |arg| ":#{arg}" }.join(", ")

        initializer = "def initialize(#{argument_args});#{argument_attrs};end"
        slot_class.class_eval(initializer)
        puts "WAT" * 5
        puts initializer
        puts argument_accessors
        slot_class.class_eval(argument_accessors)

        slot_class.class_eval(&block)

        const_set(slot_class_name, slot_class)

        with_slot(name, class_name: slot_class_name)
      end

      private

      def generate_slot_class_name(name)
        "#{name.to_s.classify}Slot"
      end
    end

    # Slotable has to be loaded before the DSL which means it unintuitively has
    # to be at the bottom of the file
    include Slotable
  end
end
