# app/services/external_ai_service.rb
class ExternalAIService
  def self.generate_business_ideas(params)
    # Call to an AI API (e.g., OpenAI, GPT-3)
    response = RestClient.post(
      "https://api.openai.com/v1/engines/davinci/completions",
      {
        prompt: build_prompt(params),
        max_tokens: 1500
      }.to_json,
      {
        Authorization: "Bearer YOUR_OPENAI_API_KEY",
        content_type: :json,
        accept: :json
      }
    )
    JSON.parse(response.body)
  end

  def self.build_prompt(params)
    <<~PROMPT
      Generate 5 unique business ideas for a user with the following information:
      Name: #{params[:first_name]} #{params[:last_name]}
      Username: #{params[:username]}
      Location: #{params[:location]}
      Business Category: #{params[:category]}
      Skills: #{params[:skills].join(', ')}

      Each business idea should include:
      1. Name
      2. Description (500 words)
      3. Specific problems to be solved
      4. How to solve these problems
      5. Likely products/services
      6. Market information (related to the location)
      7. Requirements to run such a business (considering the African market)
    PROMPT
  end
end