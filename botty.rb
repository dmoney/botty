class Friend
  attr_accessor :name
  def initialize
    @name=nil
  end
end

class Botty
  def initialize(name="Botty")
    @last_said = ''
    @new = true
    @name=name
    @friend=Friend.new
    @just_asked_name=false
    @just_got_name=false
  end

  def tell!(s)
    @last_said = s
    if @just_asked_name
      @friend.name = s
      @just_got_name = true
      @just_asked_name = false
    end
  end

  def response
    if @new
      @new = false
      "Hello, my name is #{@name}."

    elsif @just_got_name
      @just_got_name = false
      "Hi #{@friend.name}!"

    elsif !@friend.name
      @just_asked_name = true
      "What is your name?"

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
