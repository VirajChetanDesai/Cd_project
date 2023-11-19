%{
#include "y.tab.h" // Include Bison header, which might be differently named depending on your setup.

int indent = 0;
int dedent = 0;
char *last_char = NULL;

int check_indentation(char *text);
%}

%%
\n        { check_indentation(yytext); BEGIN(INITIAL); }
[ ]+      { /* Ignore spaces outside of indentation context. */ }
\t+       { /* You can choose how to handle tabs. */ }

"if"      { return IF; }
"elif"    { return ELIF; }
"else"    { return ELSE; }
"while"   { return WHILE; }
"for"     { return FOR; }
"print"   { return PRINT; }
"class"   { return CLASS; }
"def"     { return DEF; }
"return"  { return RETURN; }
"True"    { return CONST_BOOL; }
"False"   { return CONST_BOOL; }
"and"     { return LOGIC_OP; }
"or"      { return LOGIC_OP; }
"not"     { return NOT; }
"in"      { return IN; }

"+"       { return ADD_OP; }
"-"       { return ADD_OP; }
"*"       { return MUL_OP; }
"/"       { return MUL_OP; }
"%"       { return MUL_OP; }

">"       { return REL_OP; }
"<"       { return REL_OP; }
"=="      { return REL_OP; }
"!="      { return REL_OP; }
">="      { return REL_OP; }
"<="      { return REL_OP; }

"="       { return '='; }
":"       { return ':'; }
","       { return ','; }
"."       { return '.'; }
"("       { return '('; }
")"       { return ')'; }
"["       { return '['; }
"]"       { return ']'; }
"{"       { return '{'; }
"}"       { return '}'; }

\"(\\.|[^"])*\" { yylval.sval = strdup(yytext); return CONST_STRING; }
[a-zA-Z_][a-zA-Z_0-9]* { yylval.sval = strdup(yytext); return IDENTIFIER; }
[0-9]+    { yylval.ival = atoi(yytext); return NUMBER; }

%%

int check_indentation(char *text) {
    int current_indent = 0;
    while (*text == ' ') {
        current_indent++;
        text++;
    }

    if (current_indent > indent) {
        yylval.ival = current_indent - indent; // The value of the indent
        indent = current_indent;
        last_char = text; // Reset last_char to the last non-space character
        return INDENT;
    } else if (current_indent < indent) {
        yylval.ival = indent - current_indent; // The value of the dedent
        dedent = current_indent;
        last_char = text; // Reset last_char to the last non-space character
        return DEDENT;
    }
}

int yywrap(void) {
    return 1;
}
