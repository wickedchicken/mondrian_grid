(* file: main.ml *)
(* Assumes the parser file is "mondrian.mly" and the lexer file is "lexer.mll". *)

open Div
open Printf


type outputmodes = Dump | Xhtml

let usage = sprintf "usage: %s [options] < input > output" (Filename.basename Sys.argv.(0))
let outputmode = ref Dump
let args = ref []

let speclist = [
  ("-m", Arg.String (fun (txt) -> match txt with
    | "dump" -> outputmode := Dump
    | "xhtml" -> begin
      print_endline "xhtml output is not supported yet!";
      exit 1
    end
    | _ -> begin
      raise (Arg.Bad (sprintf "%s is not a supported output format" txt))
    end
  ), ": set output mode (currently only 'dump' is supported");
  ("--", Arg.Rest (fun arg -> args := !args @ [arg]), ": stop interpreting options")
]


let main () =
  let collect arg = args := !args @ [arg] in
  let _ = Arg.parse speclist collect usage in
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
