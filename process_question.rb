require 'io/console'

def ProcessQuestion
  # result determines who loses a life when the score is processed.
  @result = "everybody"
  @correct_answer = nil
  
  def create_question
    puts "#{@current_player.name} create an equation that you can answer."
    print "> "
    @question = $stdin.gets.chomp
    puts "\n"
    if !@question.match(/[a-zA-Z]/)
      @correct_answer = eval(@question)
    else
      puts "Your equation contained invalid characters, try again."
      create_question
    end
  end

  def verify_question
    puts "To ensure fairness, correctly answer your own question, or lose a life.\n(input hidden)"
    puts @question
    print "> "
    answer = $stdin.noecho(&:gets).chomp.to_i

    if answer != @correct_answer
      puts "wrong answer, you have lost a life.\n\n"
      @current_player.remove_life
      @result = "other_player"
    else
      puts "correct answer.\n\n"
    end
  end

  def answer_question
    puts "#{@other_player.name} answer the question correctly, or lose a life."
    print "> "
    answer = $stdin.gets.chomp.to_i
    if answer != @correct_answer
      puts "wrong answer, you have lost a life.\n\n"
      @other_player.remove_life
      if @result != "other_player"
        @result = "current_player"
      else
        @result = "nobody"
      end
    else
      puts "correct answer.\n\n"
    end
  end

  create_question
  verify_question
  answer_question

  puts "the winner of this round is... #{instance_variable_get("@#{@result}")&.name || "#{@result}!"}"
  puts "lives: player_1: #{@player_1.lives} | player_2: #{@player_2.lives}.\n\n"

  return @result
end