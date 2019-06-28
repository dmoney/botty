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
    @subjects={}
    @current_subject=nil
  end

  def tell!(s)
    @last_said = s
    if @just_asked_name
      @friend.name = s
      @just_got_name = true
      @just_asked_name = false

    elsif (m = s.match /^(?<subject>\w+)\'s (?<property>\w+) is (?<value>.+)/i )
      @current_subject = m[:subject]
      if !@subjects[@current_subject]
        @subjects[@current_subject] = {}
      end
      @subjects[@current_subject][m[:property]] = m[:value]
      @response = "K."

    elsif (m = s.match /^what is (?<subject>\w+)\'s (?<property>\w+)/i )
      @current_subject = m[:subject]
      @response = if !@subjects[m[:subject]]
        "I'm sorry, I don't know what #{m[:subject]} is."
      elsif !@subjects[m[:subject]][m[:property]]
        "I don't know #{@current_subject}'s #{m[:property]}'."
      else
        "#{@current_subject}'s #{m[:property]} is #{@subjects[m[:subject]][m[:property]]}."
      end

    elsif s.match /what are we talking about/i
      if @current_subject
        @response = "We're talking about #{@current_subject}."
      else
        @response = "I don't know."
      end
    end
  end

  def response
    if @new
      @new = false
      "Hello, my name is #{@name}."

    elsif @response
      # This is bad.  It's just here for now.  Maybe.
      output = @response
      @response = nil
      output

    elsif @just_got_name
      @just_got_name = false
      "Hi #{@friend.name}!"

    elsif !@friend.name
      @just_asked_name = true
      "What is your name?"

    else
      "You said '#{@last_said}'.  I don't know what that means."
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
