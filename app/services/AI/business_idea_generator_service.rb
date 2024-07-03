module AI
  class BusinessIdeaGeneratorService
    include HTTParty
    base_uri 'https://api.openai.com/v1'

    def self.generate(business_idea)
      new(business_idea).generate
    end

    def initialize(business_idea)
      @business_idea = business_idea
      @api_key = ENV['OPENAI_API_KEY']
    end

    def generate
      options = {
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@api_key}"
        },
        body: {
          model: 'gpt-4',
          messages: [
            { role: 'system', content: 'You are a helpful assistant.' },
            { role: 'user', content: AI::BusinessIdeaGeneratorService.generate_prompt(@business_idea) }
          ]
        }.to_json
      }

      response = self.class.post('/chat/completions', options)
      parse_response(response)
    end

    private

    def self.generate_prompt(business_idea)
      skills = business_idea.skills_list

      <<~PROMPT
      Generate 1 unique business idea that is in line with the following details:
      - Business Category: #{business_idea.category.name}
      - Skills: #{skills}
      - Location: #{business_idea.user.country}
      - User Information:
          - First Name: #{business_idea.user.first_name}
          - Last Name: #{business_idea.user.last_name}
          - Username: #{business_idea.user.username}
      Each idea should have:
      1. Name
      2. Description (250 words)
      3. Specific problems to be solved
      4. How to solve these problems
      5. Likely products/services
      6. Market information related to #{business_idea.user.country}
      7. Requirements to run such a business (considering the African market)
      **Additionally, ensure the idea is:**
      - Feasible and realistic within the African context.
      - Addresses a specific need or gap in the chosen market.
      - Leverages the user's skills and experience.
      **Avoid generating ideas that are:**
      - Too broad or generic.
      - Already saturated in the market.
      - Unrealistic or require excessive resources.
      PROMPT
    end

    def skills_list
      skills = [@business_idea['skill1'], @business_idea['skill2'], @business_idea['skill3'], @business_idea['skill4']].compact
      skills.map { |skill| skill['name'] }.join(', ')
    end

    def parse_response(response)
      ideas = []
      if response.success?
        results = JSON.parse(response.body)
        content = results.dig('choices', 0, 'message', 'content')
        ideas = extract_ideas(content)
      end
      ideas
    end

    def extract_ideas(content)
      # This method will extract individual business ideas from the response content.
      # Implement parsing logic here.
      # For simplicity, assuming response is well formatted and ideas are separated by double newlines.
      content.split("\n\n").map do |idea_text|
        lines = idea_text.split("\n")
        {
          name: lines[0],
          description: lines[1],
          problems: lines[2..].select { |line| line.start_with?("Specific problems to be solved:") }.join(", "),
          solutions: lines[2..].select { |line| line.start_with?("How to solve these problems:") }.join(", "),
          products_services: lines[2..].select { |line| line.start_with?("Likely products/services:") }.join(", "),
          market_info: lines[2..].select { |line| line.start_with?("Market information:") }.join(", "),
          requirements: lines[2..].select { |line| line.start_with?("Requirements to run such business:") }.join(", ")
        }
      end
    end
  end
end

