require "pstore"

STORE_NAME = "tendable.pstore"
@store = PStore.new(STORE_NAME)

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

def start_survey
  puts "Welcome to the coding skills survey!"
  total_rating = 0.0
  total_surveys = 0

  # Prompt user to start the survey
  print "Do you want to start the survey? (Yes/No): "
  response = gets.chomp.downcase
  return unless response.start_with?('y')

  loop do
    total_surveys += 1
    puts "Starting Survey #{total_surveys}:"
    survey_rating = run_survey
    total_rating += survey_rating

    average_rating = total_rating / total_surveys
    puts "Average rating for all surveys: #{average_rating.round(2)}%"
    
    break unless start_again?
  end
  
  overall_average_rating = total_surveys == 0 ? 0 : total_rating / total_surveys
  puts "Overall average rating across all surveys: #{overall_average_rating.round(2)}%"
end

def run_survey
  answers = {}

  QUESTIONS.each do |question_key, question|
    print "#{question} (Yes/No): "
    answer = gets.chomp.downcase
    until ['yes', 'no'].include?(answer)
      print "Please answer with Yes or No: "
      answer = gets.chomp.downcase
    end
    answers[question_key] = answer == 'yes'
  end

  store_survey(answers)
  calculate_rating(answers)
end

def store_survey(answers)
  @store.transaction do
    @store[:runs] ||= []
    @store[:runs] << answers
  end
end

def calculate_rating(answers)
  total_questions = QUESTIONS.size
  correct_answers = answers.count { |_, answer| answer }
  rating = (correct_answers.to_f / total_questions) * 100
  rating.round(2)
end

def start_again?
  print "Do you want to start another survey? (Yes/No): "
  response = gets.chomp.downcase
  response.start_with?('y')
end

start_survey
