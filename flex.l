%{
#include "bison.tab.h" 

int indent = 0;
int last_token_was_newline = 0;
int indent_stack[1024];
int indent_stack_index = 0;

void push_indent(int ind) {
    indent_stack[indent_stack_index++] = ind;
}

int pop_indent() {
    if (indent_stack_index > 0) {
        return indent_stack[--indent_stack_index];
    }
    return 0;
}

%}

%option noyywrap

%%

"class"         { last_token_was_newline = 0; printf("CLASS\n"); return CLASS; }
"def"           { last_token_was_newline = 0; printf("DEF\n"); return DEF; }
"if"            { last_token_was_newline = 0; printf("IF\n"); return IF; }
"elif"          { last_token_was_newline = 0; printf("ELIF\n"); return ELIF; }
"else"          { last_token_was_newline = 0; printf("ELSE\n"); return ELSE; }
"while"         {last_token_was_newline = 0; printf("WHILE\n"); return WHILE; }
"for"           { last_token_was_newline = 0; printf("FOR\n"); return FOR; }
"in"            { last_token_was_newline = 0; printf("IN\n"); return IN; }
"print"         { last_token_was_newline = 0; printf("PRINT\n"); return PRINT; }
"return"        { last_token_was_newline = 0; printf("RETURN\n"); return RETURN; }
"True"          { last_token_was_newline = 0; printf("TRUE\n"); return TRUE; }
"False"         { last_token_was_newline = 0; printf("FALSE\n"); return FALSE; }
"range"         { last_token_was_newline = 0; printf("RANGE\n"); return RANGE; }
"+"             { last_token_was_newline = 0; printf("ADD_OP\n"); return ADD_OP; }
"-"             { last_token_was_newline = 0; printf("SUB_OP\n"); return SUB_OP; }
"*"             { last_token_was_newline = 0; printf("MUL_OP\n"); return MUL_OP; }
"/"             { last_token_was_newline = 0; printf("DIV_OP\n"); return DIV_OP; }
"%"             {last_token_was_newline = 0; printf("MOD_OP\n"); return MOD_OP; }
"=="            { last_token_was_newline = 0; printf("EQ\n"); return EQ; }
"!="            { last_token_was_newline = 0; printf("NEQ\n"); return NEQ; }
"<"             { last_token_was_newline = 0; printf("LT\n"); return LT; }
">"             { last_token_was_newline = 0; printf("GT\n"); return GT; }
"<="            { last_token_was_newline = 0; printf("LE\n"); return LE; }
">="            { last_token_was_newline = 0; printf("GE\n"); return GE; }
"and"           { last_token_was_newline = 0; printf("AND\n"); return AND; }
"or"            { last_token_was_newline = 0; printf("OR\n"); return OR; }
"not"           { last_token_was_newline = 0; printf("NOT\n"); return NOT; }
"="             { last_token_was_newline = 0; printf("ASSIGN\n"); return ASSIGN; }
";"             {last_token_was_newline = 0;  printf("SEMICOLON\n"); return SEMICOLON; }
":"             { last_token_was_newline = 0; printf("COLON\n"); return COLON; }
","             { last_token_was_newline = 0; printf("COMMA\n"); return COMMA; }
"("             {last_token_was_newline = 0;  printf("LPAREN\n"); return LPAREN; }
")"             { last_token_was_newline = 0; printf("RPAREN\n"); return RPAREN; }
"["             {last_token_was_newline = 0;  printf("LSQUARE\n"); return LSQUARE; }
"]"             { last_token_was_newline = 0; printf("RSQUARE\n"); return RSQUARE; }
"{"             { last_token_was_newline = 0; printf("LBRACE\n"); return LBRACE; }
"}"             { last_token_was_newline = 0; printf("RBRACE\n"); return RBRACE; }
[0-9]+          { yylval.num = atoi(yytext); last_token_was_newline = 0; printf("NUMBER: %d\n", yylval.num); return NUMBER; }
\"([^\\\"]|\\.)*\" { yylval.str = strdup(yytext); last_token_was_newline = 0; printf("STRING: %s\n", yylval.str); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); last_token_was_newline = 0; printf("IDENTIFIER: %s\n", yylval.str); return IDENTIFIER; }

\n   {
    last_token_was_newline = 1;
    printf("NEWLINE\n");
    return NEWLINE;
}

[ \t]+ {
    if (last_token_was_newline) {
        last_token_was_newline = 0;
        int current_indent = strlen(yytext);
        if (current_indent > indent) {
            push_indent(indent);
            indent = current_indent;
            printf("INDENT\n");
            return INDENT;
        } else {
            while (current_indent < indent) {
                indent = pop_indent();
                printf("DEDENT\n");
                return DEDENT;
            }
        }
    }
}

<<EOF>>         {
    while (indent_stack_index > 0) { 
        pop_indent();
    }
    printf("Success\n");
    exit(0);
}
.               { /* Catch all for single characters */ }

%%