%{
#include <stdio.h>
#include <string.h>

FILE *output;
int token_count = 0;
int lineno = 1;  // En lugar de yylineno

void add_token(const char* type, const char* value) {
    token_count++;
    fprintf(output, "%d\t%s\t(line %d): %s\n", token_count, type, lineno, value);
}
%}

%option noyywrap

%%

"#include"[ \t]+\"[^\"]+\"     { add_token("PREPROCESSOR", yytext); }
"#include"[ \t]+<[^>]+>       { add_token("PREPROCESSOR", yytext); }

"const"                         { add_token("CONSTANTS", yytext); }

"int"|"float"|"double"|"char"|"void"|"if"|"else"|"while"|"for"|"return"|"class"|"public"|"private"|"protected"|"virtual"|"namespace" {
    add_token("KEYWORD", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]*          { add_token("IDENTIFIER", yytext); }

[0-9]+\.[0-9]+                  { add_token("FLOAT", yytext); }
[0-9]+                          { add_token("NUMBER", yytext); }

"=="|"!="|"<="|">="|"="|"+"|"-"|"*"|"/"|"%"|"++"|"--"|"<"|">"|"<<"|">>" {
    add_token("OPERATOR", yytext);
}

"("                             { add_token("LPAREN", yytext); }
")"                             { add_token("RPAREN", yytext); }
"{"                             { add_token("LBRACE", yytext); }
"}"                             { add_token("RBRACE", yytext); }
";"                             { add_token("SEMICOLON", yytext); }
","                             { add_token("COMMA", yytext); }

\"([^\\"]|\\.)*\"               { add_token("STRING", yytext); }
\'([^\\']|\\.)*\'               { add_token("CHAR", yytext); }

"//".*                          { /* Single-line comment - ignore */ }
"/*"[^*]*\*+([^*/][^*]*\*+)*"/" { /* Multi-line comment - ignore */ }

[ \t\r]+                        { /* Ignore whitespace */ }
\n                              { lineno++; }

.                               { add_token("UNKNOWN", yytext); }

%%

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE *input = fopen(argv[1], "r");
    if (!input) {
        perror("Failed to open input file");
        return 1;
    }

    output = fopen("tokens.txt", "w");
    if (!output) {
        perror("Failed to create output file");
        fclose(input);
        return 1;
    }

    yyin = input;
    yylex();

    fclose(input);
    fclose(output);
    return 0;
}
New File at / · A01641937-alf/Lexical-Analyzer
