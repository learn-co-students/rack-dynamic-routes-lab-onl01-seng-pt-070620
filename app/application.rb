require 'rack'
require_relative 'item'
class Application
  @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/item/)
      item_input = req.path.split('/').last
      if @@items.any?{|obj| obj.name == item_input}
        resp.write("#{@@items.detect{|obj| obj.name == item_input}.price}") if @@items.detect{|obj| obj.name == item_input}
      else
        resp.write("Item not found")
        resp.status = 400
      end
    else
      resp.write("Route not found")
      resp.status = 404
    end
    resp.finish
  end

end