require_relative 'questionnaire'

RSpec.describe 'Questionnaire' do
  describe '#calculate_rating' do
    it 'calculates the rating correctly' do
      answers = {
        "q1" => true,
        "q2" => true,
        "q3" => false,
        "q4" => false,
        "q5" => true
      }

      rating = calculate_rating(answers)
      expect(rating).to eq(60.0)
    end
  end

  # Add more examples for other methods if needed
end
