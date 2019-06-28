class Botty
  def initialize(name="Botty")
    @last_said = ''
    @new = true
    @name=name
  end

  def tell!(s)
    @last_said = s
  end

  def response
    if @new
      @new = false
      "Hello, my name is #{@name}."
    else
      "you said #{@last_said}"
    end
  end
end

botty = Botty.new

puts "\n#{botty.response}\n\n"

while true
  print ">>> "
  $stdout.flush

  botty.tell! gets.strip
  puts "\n#{botty.response}\n\n"
end
