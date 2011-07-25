(* file: lexer.mll *)
{
  open Mondrian (* Assumes the parser file is "rpcalc.mly". *)
  open Printf
}
let digit = ['0'-'9']
let nonnumeric = ['a'-'z' 'A'-'Z']
let extn = "ex" | "em" | "px" | "%"
let fp = digit | (digit "." digit)
rule token = parse
  | [' ' '\t']	{ token lexbuf }
  | '\n'
  | "\r\n"
  | "\r" { NEWLINE }
  | nonnumeric (digit | nonnumeric)+ as id { ID(id) }
  | fp extn as txt { SIZE(txt) }
  | (nonnumeric | digit)+ as txt { STRING(txt) }
  | '{' { OBRACE }
  | '}' { CBRACE }
  | '[' { OBRACKET }
  | ']' { CBRACKET }
  | "//" [^ '\n']* { token lexbuf } (* comment *)
  (* | _		{ token lexbuf } *)
  | eof		{ EOF }
