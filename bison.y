%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int num;          
    char *str;         
}

%token <str> IDENTIFIER STRING
%token <num> NUMBER
%token CLASS DEF IF ELIF ELSE WHILE FOR IN PRINT RETURN TRUE FALSE
%token ADD_OP SUB_OP MUL_OP DIV_OP MOD_OP ASSIGN SEMICOLON COLON COMMA LPAREN RPAREN LBRACE RBRACE NEWLINE INDENT DEDENT LSQUARE RSQUARE RANGE
%token <str> EQ NEQ LT GT LE GE AND OR NOT
%start program

%left OR
%left AND
%left EQ NEQ
%left LT GT LE GE
%left ADD_OP SUB_OP
%left MUL_OP DIV_OP MOD_OP
%right NOT

%%
program
    : stmt_list { printf("Parsed successfully.\n");exit(0); }
    ;

stmt_list
    :stmtp
    ;
stmtp
    : stmt stmtp
    | /*epsilon*/
    ;

stmt
    : simple_stmt
    | compound_stmt
    ;

simple_stmt
    : assign_stmt NEWLINE
    | print_stmt NEWLINE
    | return_stmt NEWLINE
    | expr_stmt NEWLINE
    ;

compound_stmt
    : if_stmt
    | while_stmt
    | for_stmt
    | class_def
    | func_def
    ;

assign_stmt
    : IDENTIFIER ASSIGN expr
    ;

print_stmt
    : PRINT LPAREN expr_list RPAREN
    ;

return_stmt
    : RETURN expr
    ;

expr_stmt
    : expr
    ;

if_stmt
    : IF expr COLON block if_stmt_tail
    ;

if_stmt_tail
    : ELIF expr COLON block if_stmt_tail
    | ELSE COLON block
    | /* empty */
    ;

while_stmt
    : WHILE expr COLON block
    ;

for_stmt
    : FOR IDENTIFIER IN range_expr COLON block
    ;

block
    : NEWLINE INDENT stmt_list DEDENT
    ;

range_expr
    : RANGE LPAREN expr RPAREN
    | RANGE LPAREN expr COMMA expr RPAREN
    | RANGE LPAREN expr COMMA expr COMMA expr RPAREN
    ;

opt_expr_list
    : /* empty */
    | expr_list
    ;
expr_list
    : expr
    | expr_list COMMA expr
    ;

class_def
    : CLASS IDENTIFIER inheritance COLON block
    ;

inheritance
    : /* empty */
    | LPAREN IDENTIFIER inheritance_tail RPAREN
    ;

inheritance_tail
    : /* empty */
    | COMMA IDENTIFIER inheritance_tail
    ;

func_def
    : DEF IDENTIFIER LPAREN param_list RPAREN COLON block
    ;

param_list
    : /* empty */
    | param_list_tail
    ;

param_list_tail
    : IDENTIFIER
    | IDENTIFIER COMMA param_list_tail
    ;

expr
    : STRING
    | NUMBER
    | TRUE
    | FALSE
    | IDENTIFIER
    | IDENTIFIER '.' IDENTIFIER // To handle attribute access, like obj.method()
    | LPAREN expr RPAREN
    | expr EQ expr
    | expr NEQ expr
    | expr LT expr
    | expr GT expr
    | expr LE expr
    | expr GE expr
    | expr ADD_OP expr
    | expr SUB_OP expr
    | expr MUL_OP expr
    | expr DIV_OP expr
    | expr MOD_OP expr
    | expr AND expr
    | expr OR expr
    | NOT expr
    | call_expr
    | list_comprehension
    | dict_comprehension
    ;

call_expr
    : IDENTIFIER LPAREN opt_expr_list RPAREN
    ;

list_comprehension
    : LSQUARE expr FOR IDENTIFIER IN expr RSQUARE
    ;

dict_comprehension
    : LBRACE expr COLON expr FOR IDENTIFIER IN expr RBRACE
    ;

%%

extern FILE *yyin;
extern int yyparse(void);

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror(argv[1]);
        return 1;
    }

    yyin = file;
    yyparse();
    fclose(file);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s \n", s);
}
