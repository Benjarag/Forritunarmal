import sys

from ltoken import LToken

class LLexer:
    def __init__(self):
        self.index = 0
        self.inp = sys.stdin.read()
        print(f"DEBUG: Input read -> {repr(self.inp)}")  # ✅ Check input

    def get_next_char(self):
        if (self.index >= len(self.inp)):
            return None # reached the end of the input buffer
        char = self.inp[self.index]
        self.index += 1
        return char

    def get_next_token(self):
        char = self.get_next_char()
        if char is None:
            return LToken("", LToken.END)
        
        while (char is not None and char.isspace()):
            char = self.get_next_char()
        if char is None:
            return LToken("", LToken.END)

        if (char == ";"):
            return LToken(";", LToken.SEMICOL)
        if (char == "="):
            return LToken("=", LToken.ASSIGN)
        if (char == "+"):
            return LToken("+", LToken.PLUS)
        if char == '-':
            return LToken("-", LToken.MINUS)
        if char == '*':
            return LToken("*", LToken.MULT)
        if char == '(':
            return LToken("(", LToken.LPAREN)
        if char == ')':
            return LToken(")", LToken.RPAREN)

        if (char.isalpha()):
            lexeme = char
            while True:
                next_char = self.get_next_char()
                if next_char is None or not next_char.isalnum():
                    break
                lexeme += next_char

            if (lexeme == "end"):
                return LToken(lexeme, LToken.END)
            if (lexeme == "print"):
                return LToken(lexeme, LToken.PRINT)
            else:
                return LToken(lexeme, LToken.ID)
            

        if (char.isdigit()):
            lexeme = char
            while True:
                next_char = self.get_next_char()
                if next_char is None or not next_char.isdigit():
                    break
                lexeme += next_char
            return LToken(lexeme, LToken.INT)
        
        return LToken(char, LToken.ERROR)
            

