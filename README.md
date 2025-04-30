# Lexical Analyzer in C using Flex (`lexerC.l`)

This project implements a **lexical analyzer (scanner)** in C using **Flex**. It scans a C/C++ source file and generates a list of recognized *tokens*, such as keywords, operators, identifiers, literals, etc.

## Files

- `lexerC.l`: Main lexer file containing the token recognition rules.
- `tokens.txt`: Output file where the recognized tokens are stored.
- `example.c`: Example C source file to test the lexer.

## Requirements

- Flex
- GCC (C compiler)
- Unix/Linux-based system (tested on a CentOS virtual machine)

## How to Compile and Run

1. Open a terminal in the project directory.

2. Generate the C source file from the lexer file using Flex:

   ```bash
   lex lexerC.l
   ```

3. Compile the generated C file with GCC:

   ```bash
   gcc lex.yy.c -o lexerC
   ```

4. Run the lexer on a C source file (e.g., `example.c`):

   ```bash
   ./lexerC example.c
   ```

5. View the generated tokens in the output file:

   ```bash
   cat tokens.txt
   ```

## Output Format

Each line in the `tokens.txt` file has the following format:

```
<token_id>    <token_type>    (line <line_number>): <token_value>
```

Example:

```
1	KEYWORD	(line 1): int
2	IDENTIFIER	(line 1): main
3	LPAREN	(line 1): (
...
```

## Recognized Tokens

- **PREPROCESSOR**: directives like `#include <stdio.h>`
- **KEYWORD**: reserved words like `int`, `return`, `class`, etc.
- **IDENTIFIER**: names of variables, functions, classes, etc.
- **NUMBER**, **FLOAT**: numeric literals
- **OPERATOR**: operators like `+`, `==`, `>>`, etc.
- **STRING**, **CHAR**: string and character literals
- **LPAREN**, **RPAREN**, **LBRACE**, **RBRACE**, **SEMICOLON**, **COMMA**: grouping and punctuation symbols
- **CONSTANTS**: the `const` keyword
- **UNKNOWN**: any unrecognized symbol

