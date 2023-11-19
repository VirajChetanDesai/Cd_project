/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_BISON_TAB_H_INCLUDED
# define YY_YY_BISON_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    CONST_STRING = 259,            /* CONST_STRING  */
    NUMBER = 260,                  /* NUMBER  */
    CONST_BOOL = 261,              /* CONST_BOOL  */
    INDENT = 262,                  /* INDENT  */
    DEDENT = 263,                  /* DEDENT  */
    NEWLINE = 264,                 /* NEWLINE  */
    IF = 265,                      /* IF  */
    ELIF = 266,                    /* ELIF  */
    ELSE = 267,                    /* ELSE  */
    WHILE = 268,                   /* WHILE  */
    FOR = 269,                     /* FOR  */
    PRINT = 270,                   /* PRINT  */
    CLASS = 271,                   /* CLASS  */
    DEF = 272,                     /* DEF  */
    RETURN = 273,                  /* RETURN  */
    ADD_OP = 274,                  /* ADD_OP  */
    MUL_OP = 275,                  /* MUL_OP  */
    UNARY_OP = 276,                /* UNARY_OP  */
    REL_OP = 277,                  /* REL_OP  */
    LOGIC_OP = 278,                /* LOGIC_OP  */
    NOT = 279,                     /* NOT  */
    IN = 280                       /* IN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 9 "bison.y"

    int ival;
    char *sval;

#line 94 "bison.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_BISON_TAB_H_INCLUDED  */
