/* file: mondrian.mly */

%{
open Printf
open Div
%}

%token <string> SIZE
%token <string> ID
%token <string> STRING
%token NEWLINE EOF
%token OBRACE CBRACE OBRACKET CBRACKET

%start input
%type <Div.divset> input

%% /* Grammar rules and actions follow */

input:    /* empty */		{ Nil }
        | chompnl divs { Vert(List.rev $2)} 
;

terminator:   NEWLINE  { }
            | EOF { }
;

chompnl:   { }
         | NEWLINE { }
         | chompnl NEWLINE { }
;

divs:   adiv { [$1] }
      | divs adiv { $2 :: $1 }
      | divs NEWLINE  { $1 }
;

enclosedseq:    { Nil }
              | OBRACE chompnl divs CBRACE { Vert($3) }
              | OBRACKET chompnl divs CBRACKET { Horiz($3) }
;

size: { Free }
       | SIZE {
        let mylist = List.map (function
          | Str.Delim c -> c
          | Str.Text c -> c
        ) 
        (Str.full_split (Str.regexp "ex\\|em\\|px\\|%\\|in\\|cm\\|mm\\|pt\\|pc") $1) in
        Size((float_of_string (List.nth mylist 0)),(List.nth mylist 1))
         }
;

optionlist: { [] }
            | ID { [$1] }
            | STRING { [$1] }
            | SIZE { [$1] }
            | optionlist ID { $2 :: $1 }
            | optionlist STRING { $2 :: $1 }
            | optionlist SIZE { $2 :: $1 }
;

adiv : ID size optionlist enclosedseq terminator { ($1,$2,List.rev $3,$4) }
;

%%
