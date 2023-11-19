%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    void yyerror(const char *s);
    int yylex(void);
%}

%union {
    int ival;
    char *sval;
}

%token <sval> IDENTIFIER CONST_STRING
%token <ival> NUMBER
%token CONST_BOOL
%token INDENT DEDENT NEWLINE
%token IF ELIF ELSE WHILE FOR PRINT CLASS DEF RETURN
%token ADD_OP MUL_OP UNARY_OP REL_OP LOGIC_OP NOT IN

%%

program
    : stmt_list
    ;

stmt_list
    : /* empty */
    | stmt_list stmt
    ;

stmt
    : simple_stmt NEWLINE
    | compound_stmt
    ;

simple_stmt
    : assign_stmt
    | print_stmt
    | return_stmt
    ;

assign_stmt
    : IDENTIFIER '=' expr
    ;

print_stmt
    : PRINT '(' expr_list ')'
    ;

return_stmt
    : RETURN expr
    ;

compound_stmt
    : if_stmt
    | while_stmt
    | for_stmt
    | class_def
    | func_def
    ;

if_stmt
    : IF '(' cond ')' ':' INDENT stmt_list DEDENT if_stmt_tail
    ;

if_stmt_tail
    : elif_stmt if_stmt_tail
    | else_stmt
    | /* empty */
    ;

elif_stmt
    : ELIF '(' cond ')' ':' INDENT stmt_list DEDENT
    ;

else_stmt
    : ELSE ':' INDENT stmt_list DEDENT
    ;

while_stmt
    : WHILE '(' cond ')' ':' INDENT stmt_list DEDENT
    ;

for_stmt
    : FOR IDENTIFIER IN expr ':' INDENT stmt_list DEDENT
    ;

class_def
    : CLASS IDENTIFIER ':' inheritance INDENT stmt_list DEDENT
    ;

inheritance
    : /* empty */
    | IDENTIFIER inheritance_tail
    ;

inheritance_tail
    : /* empty */
    | ',' IDENTIFIER inheritance_tail
    ;

func_def
    : DEF IDENTIFIER '(' param_list ')' ':' INDENT stmt_list DEDENT
    ;

param_list
    : /* empty */
    | IDENTIFIER param_list_tail
    ;

param_list_tail
    : /* empty */
    | ',' IDENTIFIER param_list_tail
    ;

cond
    : expr REL_OP expr
    | expr LOGIC_OP expr
    | NOT expr
    ;

expr
    : term expr_tail
    | CONST_STRING
    | CONST_BOOL
    | IDENTIFIER '.' IDENTIFIER
    | call_expr /* call_expr is now only reduced here to avoid ambiguity */
    ;

expr_tail
    : ADD_OP term expr_tail
    | /* empty */
    ;

term
    : factor term_tail
    ;

term_tail
    : MUL_OP factor term_tail
    | /* empty */
    ;

factor
    : '(' expr ')'
    | IDENTIFIER /* IDENTIFIER reduced to factor to avoid ambiguity */
    | NUMBER
    | UNARY_OP factor
    /* call_expr has been removed from factor */
    ;

call_expr
    : IDENTIFIER '(' expr_list ')'
    ;

expr_list
    : /* empty */
    | expr expr_list_tail
    ;

expr_list_tail
    : /* empty */
    | ',' expr expr_list_tail
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}