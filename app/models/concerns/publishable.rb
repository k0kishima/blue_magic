# TODO: 実装場所は再考する
module Publishable
  extend ActiveSupport::Concern

  included do
    def add_observer(observer)
      @observers ||= []
      @observers << observer
    end

    def notify_observers
      observers.each do |observer|
        observer.subscribe(self)
      end
    end

    def observers
      @observers || []
    end
  end
end
