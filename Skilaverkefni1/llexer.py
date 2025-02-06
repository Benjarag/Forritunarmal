import sys
from ltoken import LToken

class LLexer:
    def __init__(self):
        self.index = 0
        self.inp = sys.stdin.read()
        # print(f"DEBUG: Input read -> {repr(self.inp)}")

    def get_next_char(self):
        if self.index >= len(self.inp):
            return None
        char = self.inp[self.index]
        self.index += 1
        return char

    def peek_next_char(self):
        if self.index >= len(self.inp):
            return None
        return self.inp[self.index]

    def get_next_token(self):
        char = self.get_next_char()

        while char is not None and char.isspace():
            char = self.get_next_char()

        if char is None:
            return LToken("", LToken.ERROR)

        if char == ";":
            return LToken(";", LToken.SEMICOL)
        if char == "=":
            return LToken("=", LToken.ASSIGN)
        if char == "+":
            return LToken("+", LToken.PLUS)
        if char == "-":
            return LToken("-", LToken.MINUS)
        if char == "*":
            return LToken("*", LToken.MULT)
        if char == "(":
            return LToken("(", LToken.LPAREN)
        if char == ")":
            return LToken(")", LToken.RPAREN)

        if char.isalpha():
            lexeme = char
            while True:
                next_char = self.peek_next_char()
                if next_char is None or not next_char.isalpha():
                    break
                lexeme += self.get_next_char()

            if lexeme.lower() == "end":
                return LToken(lexeme, LToken.END)
            if lexeme.lower() == "print":
                return LToken(lexeme, LToken.PRINT)
            return LToken(lexeme, LToken.ID)

        if char.isdigit():
            lexeme = char
            while True:
                next_char = self.peek_next_char()
                if next_char is None or not next_char.isdigit():
                    break
                lexeme += self.get_next_char()
            return LToken(lexeme, LToken.INT)

        return LToken(char, LToken.ERROR)

if __name__ == "__main__":
    lexer = LLexer()
    while True:
        token = lexer.get_next_token()
        if token.token_code == LToken.END:
            print(token)
            break
        if token.token_code == LToken.ERROR:
            print(LToken(token.lexeme, token.token_code))
            break
        print(token)
