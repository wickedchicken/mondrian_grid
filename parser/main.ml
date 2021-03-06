(* file: main.ml *)
(* Assumes the parser file is "mondrian.mly" and the lexer file is "lexer.mll". *)

open Div
open Printf
open Xhtml


type outputmodes = Dump | Xhtml

let usage = sprintf "usage: %s [options] < input > output" (Filename.basename Sys.argv.(0))
let outputmode = ref Xhtml
let args = ref []

let speclist = [
  ("-m", Arg.String (fun (txt) -> match txt with
    | "dump" -> outputmode := Dump
    | "xhtml" -> outputmode := Xhtml
    | _ -> begin
      raise (Arg.Bad (sprintf "%s is not a supported output format" txt))
    end
  ), ": set output mode (currently only 'dump' is supported");
  ("--", Arg.Rest (fun arg -> args := !args @ [arg]), ": stop interpreting options")
]

let print_lst lst = match !outputmode with
  | Dump -> begin
        match lst with
          | Nil -> print_endline "empty file!"
          | Horiz(lst) -> print_divset lst
          | Vert(lst) -> print_divset lst
  end
  | Xhtml -> begin
        match lst with
          | Nil -> print_endline "empty file!"
          | _ -> begin
            print_endline xhtml_hdr;
            print_endline (xhtml_string_divset lst);
            print_endline xhtml_ftr
          end
  end

let main () =
  let collect arg = args := !args @ [arg] in
  let _ = Arg.parse speclist collect usage in
	try
		let lexbuf = Lexing.from_channel stdin in
      try
        print_lst (Mondrian.input Lexer.token lexbuf)
      with Parsing.Parse_error -> print_endline "parse error!"; flush stdout; exit 1
	with End_of_file -> exit 0
      
let _ = Printexc.print main ()
let parse_error s = (* Called by the parser function on error *)
  print_endline s;
  flush stdout
