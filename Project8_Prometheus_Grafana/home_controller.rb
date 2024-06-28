# Then in any controller
class HomeController < ApplicationController
    def index
      http_requests_counter = Prometheus::Client.registry.get(:http_requests)
      http_requests_counter.increment(labels: { method: request.request_method, path: request.path })
        render 'index'
    end
  end
