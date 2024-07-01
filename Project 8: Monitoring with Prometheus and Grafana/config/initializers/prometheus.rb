# In the Gemfile add: gem 'prometheus-client', '~> 4.2', '>= 4.2.2'
require 'prometheus/client'

module PrometheusMetrics
  def self.register_metric(type, name:, docstring:, labels: [])
    registry = Prometheus::Client.registry

    # Check if the metric already exists
    return if registry.exist?(name)

    # Register the metric based on its type
    case type
    when :counter
      registry.counter(name, docstring: docstring, labels: labels)
    when :gauge
      registry.gauge(name, docstring: docstring, labels: labels)
    when :histogram
      registry.histogram(name, docstring: docstring, labels: labels)
    when :summary
      registry.summary(name, docstring: docstring, labels: labels)
    else
      raise ArgumentError, "Unknown metric type: #{type}"
    end
  end
end

# Register http_requests counter with labels :method and :path
PrometheusMetrics.register_metric(:counter, name: :http_requests, docstring: 'A counter of HTTP requests made', labels: [:method, :path])
