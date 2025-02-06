from ltoken import LToken
import sys

class LParser:
    def __init__(self, lexer):
        self.lexer = lexer
        self.ltoken = LToken

    def parse(self):
        self.next_token()
        self.statements()
        print("")
    
    def factor(self):
        if self.curr_token.token_code == LToken.INT:
            print(f"PUSH {self.curr_token.lexeme}")
            self.next_token()

        elif self.curr_token.token_code == LToken.ID:
            print(f"PUSH {self.curr_token.lexeme}")
            self.next_token()

        elif self.curr_token.token_code == LToken.MINUS:
            self.next_token() # consume minus
            self.factor()
            print("UMINUS")

        elif self.curr_token.token_code == LToken.LPAREN:
            self.next_token() # consume LPAREN
            self.expr() # call expr
            if self.curr_token.token_code == LToken.RPAREN:
                self.next_token() # consume RPAREN
            else:
                self.error()
        else:
            self.error()

    def term(self):
        self.factor()
        while self.curr_token.token_code == LToken.MULT:
            self.next_token()
            self.factor()
            print("MULT")

    def expr(self):
        self.term()
        while self.curr_token.token_code == LToken.PLUS:
            self.next_token() # consuming the plus
            self.term() # expr after the plus
            print("ADD")

    def statement(self):
        ''' Handles individual statements '''
        if self.curr_token.token_code == LToken.ID:
            print(f"PUSH {self.curr_token.lexeme}")
            self.next_token() 
            if self.curr_token.token_code == LToken.ASSIGN:
                self.next_token() # consume "="
                self.expr() # parse the expression on the right side of the "="
                print("ASSIGN")
            else:
                self.error()
        elif self.curr_token.token_code == LToken.PRINT:
            self.next_token()
            if self.curr_token.token_code == LToken.ID:
                print(f"PUSH {self.curr_token.lexeme}")
                self.next_token()
                print("PRINT")
            else:
                self.error()
        else:
            self.error()

    def statements(self):
        if self.curr_token.token_code == LToken.END:
            return
        
        self.statement()
        
        if self.curr_token.token_code == LToken.END:
            return
        elif self.curr_token.token_code == LToken.SEMICOL:
            self.next_token()
        else:
            self.error()

        self.statements()
        

    def next_token(self):
        self.curr_token = self.lexer.get_next_token()
        if self.curr_token.token_code == LToken.ERROR:
            self.error()

    def error(self):
        print("Syntax error")
        sys.exit(1)
