# frozen_string_literal: true

require_relative "dependency_container/version"

module Unity
  module DependencyContainer
    class Error < StandardError; end

    def di_container_repository
      @di_container_repository ||= {}
    end

    def di_instances
      @di_instances ||= {}
    end

    def di(name)
      di_instances[name] ||= di_container_repository[name].call
    end

    def dependency(name, &block)
      di_container_repository[name] = block
    end
  end
end
