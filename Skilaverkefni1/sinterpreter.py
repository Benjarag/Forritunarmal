import sys

class SInterpreter:
    def __init__(self):
        self.stack = []
        self.variables = {}


    def cycle(self):
        ''' Implements "fetch-decode-execute cycle" '''
        for line in sys.stdin:

            if not line:
                continue
            
            operator = line.split()

            if not operator:
                continue

            if operator[0] == "PUSH":
                operand = operator[1]
                if operand.isdigit(): # operand is a number
                    self.stack.append(int(operand))
                elif operand.isalnum(): # operand is a variable
                    self.stack.append(operand)  # just push the variable name, not its value
                else:
                    print(f"Error: Invalid operand '{operand}'")
                    continue

            elif operator[0] == "ASSIGN":
                if len(self.stack) < 2:
                    print("Error: Not enough operands for ASSIGN.") 
                    continue
                value = self.stack.pop()
                variable_name = self.stack.pop()
                self.variables[variable_name] = value

            elif operator[0] == "ADD":
                if len(self.stack) < 2:
                    print("Error: Not enough operands for ADD.") 
                    continue # change
                value2 = self.stack.pop()
                value1 = self.stack.pop()
                # checking if the values are variables or numbers
                if isinstance(value1, str) and value1 in self.variables:
                    value1 = self.variables[value1]  # get the variable's value
                elif not isinstance(value1, int):
                    print(f"Error: Invalid operand '{value1}' for ADD.")
                    continue

                if isinstance(value2, str) and value2 in self.variables:
                    value2 = self.variables[value2]  # get the variable's value
                elif not isinstance(value2, int):
                    print(f"Error: Invalid operand '{value2}' for ADD.")
                    continue

                # now we can safely add the values
                total = value1 + value2
                self.stack.append(total)
                
            elif operator[0] == "MULT":
                if len(self.stack) < 2:
                    print("Error: Not enough operands for MULT.") 
                    continue
                value2 = self.stack.pop()
                value1 = self.stack.pop()
                # checking if the values are variables or numbers
                if isinstance(value1, str) and value1 in self.variables:
                    value1 = self.variables[value1]  # get the variable's value
                elif not isinstance(value1, int):
                    print(f"Error: Invalid operand '{value1}' for ADD.")
                    continue

                if isinstance(value2, str) and value2 in self.variables:
                    value2 = self.variables[value2]  # get the variable's value
                elif not isinstance(value2, int):
                    print(f"Error: Invalid operand '{value2}' for ADD.")
                    continue
                
                total = value1 * value2
                self.stack.append(total)
            
            elif operator[0] == "UMINUS":
                if len(self.stack) < 1:
                    print("Error: Not enough operands for UMINUS.") 
                    continue
                value = self.stack.pop()
                # get the variables value if it's a variable
                if isinstance(value, str) and value in self.variables:
                    value = self.variables[value]  # get the variable's value
                elif not isinstance(value, int):
                    print(f"Error: Invalid operand '{value}' for UMINUS.")
                    continue

                minus_value = -value
                self.stack.append(minus_value)

            elif operator[0] == "PRINT":
                if len(self.stack) < 1:
                    print("Error: Not enough operands for PRINT.") 
                    continue
                print_val = self.stack.pop()
                if isinstance(print_val, str) and print_val in self.variables:
                    print_val = self.variables[print_val]  # get the variable's value
                if isinstance(print_val, str):
                    print(0)
                else:
                    print(print_val)                
                    
            else:
                print(f"Error for operator: {operator[0]}")



if __name__ == "__main__":
    interpreter = SInterpreter()
    interpreter.cycle()