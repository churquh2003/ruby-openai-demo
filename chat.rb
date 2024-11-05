
# chat.rb
require "openai"
require "dotenv/load"

# Initialize OpenAI client
client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Start conversation history
message_history = [
  { "role" => "system", "content" => "You are a helpful assistant." }
]

puts "Hello! How can I help you today?"
puts "-" * 50

loop do
  print "You: "
  user_input = gets.chomp
  break if user_input.downcase == "bye"

  # Add user input to message history
  message_history << { "role" => "user", "content" => user_input }

  # Send API request
  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_history
    }
  )

  # Display assistant's response
  assistant_message = response.dig("choices", 0, "message", "content")
  puts "Assistant: #{assistant_message}"
  puts "-" * 50

  # Add assistant's response to history
  message_history << { "role" => "assistant", "content" => assistant_message }
end
