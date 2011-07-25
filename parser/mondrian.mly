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
        | divs { Vert(List.rev $1)} 
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
        (Str.full_split (Str.regexp "ex\\|em\\|px\\|%") $1) in
        Size((float_of_string (List.nth mylist 0)),(List.nth mylist 1))
         }
;

optionlist: { [] }
            | ID { [$1] }
            | optionlist ID { $2 :: $1 }
;

adiv : ID size optionlist enclosedseq terminator { printf "nabbed a div!\n"; flush stdout; ($1,$2,List.rev $3,$4) }
;

%%
