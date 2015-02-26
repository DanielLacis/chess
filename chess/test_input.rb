require 'io/console'

loop do
  input = IO.console.getch
  if input == "e"
    break
  end
  puts input
end
