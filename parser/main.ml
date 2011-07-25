(* file: main.ml *)
(* Assumes the parser file is "mondrian.mly" and the lexer file is "lexer.mll". *)

open Div

let main () =
	try
		let lexbuf = Lexing.from_channel stdin in
      try
        match Mondrian.input Lexer.token lexbuf with
          | Nil -> print_endline "empty file!"
          | Horiz(lst) -> print_divset lst
          | Vert(lst) -> print_divset lst
      with Parsing.Parse_error -> print_endline "parse error!"; flush stdout; exit 1
	with End_of_file -> exit 0
      
let _ = Printexc.print main ()
let parse_error s = (* Called by the parser function on error *)
  print_endline s;
  flush stdout
