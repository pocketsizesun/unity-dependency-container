# frozen_string_literal: true

require_relative "dependency_container/version"

module Unity
  module DependencyContainer
    class Error < StandardError; end

    def di_container_repository
      @di_container_repository ||= {}
    end

    def di_instances
      Thread.current[:di_instances]
    end

    def di(name)
      return di_instances[name] if !di_instances.nil? && di_instances.key?(name)

      Thread.current[:di_instances] ||= {}

      unless di_container_repository.key?(name)
        raise Error, "Dependency '#{name}' does not exists"
      end
      Thread.current[:di_instances][name] = di_container_repository[name].call
    end

    def dependency(name, &block)
      di_container_repository[name] = block
    end
  end
end
