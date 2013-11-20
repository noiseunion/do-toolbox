# DigitalOpera::Presenter::Base
#
# @author:  JD Hendrickson
# @date:    11/08/2013
#
module DigitalOpera
  module Presenter
    class Base < SimpleDelegator
      def initialize(base, view_context=nil)
        super(base)
        @view_context = view_context || ActionController::Base.new.view_context
      end

      def _h
        @view_context
      end

      def source
        __getobj__
      end

      def method_missing(sym, *args, &block)
        source.send sym, *args, &block
      end
    end
  end
end