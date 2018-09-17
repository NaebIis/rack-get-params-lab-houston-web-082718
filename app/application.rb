class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Pears, Apples"]
  @@add = ["Figs"]


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if @@cart == []
      resp.write "Your cart is empty"

    elsif req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif @@cart == []
        resp.write "Your cart is empty"
  
     elsif req.path.match(/cart/)
        @@cart.each do |item|
          resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      elsif 
        resp.write "We don't have that item!"
      end
      #need to look at the @@items to see if the item_to_add is in it.


    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
