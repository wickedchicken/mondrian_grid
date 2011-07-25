(* file: lexer.mll *)
{
  open Mondrian (* Assumes the parser file is "rpcalc.mly". *)
  open Printf
}
let digit = ['0'-'9']
let nonnumeric = ['a'-'z' 'A'-'Z']
let extn = "ex" | "em" | "px" | "%" | "in" | "cm" | "mm" | "pt" | "pc"
let fp = digit+ | (digit+ "." digit+)
rule token = parse
  | [' ' '\t']	{ token lexbuf }
  | '\n'
  | "\r\n"
  | "\r" { NEWLINE }
  | nonnumeric (digit | nonnumeric)+ as id {
    (* print_endline "recognized ID!" ; flush stdout;  *)
    ID(id) }
  | fp extn as txt {
    (* print_endline "recognized size!" ; flush stdout; *)
    SIZE(txt) }
  | (nonnumeric | digit)+ as txt {
    (* print_endline "recognized string!" ; flush stdout; *)
    STRING(txt) }
  | '{' { OBRACE }
  | '}' { CBRACE }
  | '[' { OBRACKET }
  | ']' { CBRACKET }
  | "//" [^ '\n']* { token lexbuf } (* comment *)
  (* | _ as c    { print_char c; token lexbuf } *)
  | eof		{ EOF }
