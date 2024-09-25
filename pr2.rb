# визначення пріоритету операторів
def priority(op)
  if op == '+' || op == '-'
    return 1 
  elsif op == '*' || op == '/'
    return 2  
  else
    return 0  
  end
end

# перевірка чи є символ оператором
def operator?(c)
  c == '+' || c == '-' || c == '*' || c == '/'
end

# обробка токенів
def process_tokens(tokens, rpn_output, operator_stack)
  tokens.each do |token|
    if token.match?(/^\d+$/)  # якщо токен — число
      rpn_output.push(token)  
    elsif operator?(token)  
      while !operator_stack.empty? && priority(operator_stack.last) >= priority(token)
        rpn_output.push(operator_stack.pop)  
      end
      operator_stack.push(token)  
    elsif token == '('  
      operator_stack.push(token)  
    elsif token == ')'  
      until operator_stack.empty? || operator_stack.last == '('
        rpn_output.push(operator_stack.pop)  
      end
      operator_stack.pop  
    end
  end
end

def rpn(expression)
  rpn_output = []  
  operator_stack = []   
  formatted_expression = expression.gsub(/([\+\-\*\/\(\)])/,' \1 ')
  tokens = formatted_expression.split  

  process_tokens(tokens, rpn_output, operator_stack)  

  until operator_stack.empty?
    rpn_output.push(operator_stack.pop)  
  end

  rpn_output.join(' ')  
end

puts "Введіть вираз для конвертації в RPN:"
expression = gets.chomp  

rpn_result = rpn(expression)
puts "Вхідний вираз: #{expression}"
puts "Вихід у RPN: #{rpn_result}"
