import sys

class SInterpreter:
    def __init__(self):
        self.stack = []
        self.variables = {}

    def _resolve_value(self, value):
        """Resolve a value to an integer, handling variable references recursively."""
        while isinstance(value, str):
            value = self.variables.get(value, 0)
        return value if isinstance(value, int) else 0

    def cycle(self):
        ''' Implements "fetch-decode-execute cycle" '''
        for line in sys.stdin:
            line = line.strip()
            if not line:
                continue  # Skip empty lines

            operator = line.split()
            if not operator:
                continue  # Skip lines with no tokens

            op = operator[0].upper()

            if op == "PUSH":
                if len(operator) != 2:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                operand = operator[1]
                try:
                    num = int(operand)
                    self.stack.append(num)
                except ValueError:
                    if operand.isalpha():
                        self.stack.append(operand)
                    else:
                        print(f"Error for operator: {operator[0]}")
                        quit()

            elif op == "ASSIGN":
                if len(operator) != 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                if len(self.stack) < 2:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                value = self.stack.pop()
                variable_name = self.stack.pop()
                if not isinstance(variable_name, str):
                    print(f"Error for operator: {operator[0]}")
                    quit()
                # Resolve the value to an integer BEFORE assigning it to the variable
                resolved_value = self._resolve_value(value)
                self.variables[variable_name] = resolved_value  # Store the resolved integer

            elif op == "ADD":
                if len(operator) != 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                if len(self.stack) < 2:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                value2 = self.stack.pop()
                value1 = self.stack.pop()
                # Resolve values to integers (handles nested variables)
                value1 = self._resolve_value(value1)
                value2 = self._resolve_value(value2)
                total = value1 + value2
                self.stack.append(total)

            elif op == "MULT":
                if len(operator) != 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                if len(self.stack) < 2:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                value2 = self.stack.pop()
                value1 = self.stack.pop()
                value1 = self._resolve_value(value1)
                value2 = self._resolve_value(value2)
                total = value1 * value2
                self.stack.append(total)

            elif op == "UMINUS":
                if len(operator) != 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                if len(self.stack) < 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                value = self.stack.pop()
                value = self._resolve_value(value)
                minus_value = -value
                self.stack.append(minus_value)

            elif op == "PRINT":
                if len(operator) != 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                if len(self.stack) < 1:
                    print(f"Error for operator: {operator[0]}")
                    quit()
                print_val = self.stack.pop()
                print_val = self._resolve_value(print_val)
                print(print_val)

            else:
                print(f"Error for operator: {operator[0]}")
                quit()

if __name__ == "__main__":
    interpreter = SInterpreter()
    interpreter.cycle()