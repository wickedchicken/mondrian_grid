open Div

let divhdr id style = "<div id=\"" ^ id ^ "\" style=\"" ^ style ^ "\">"
let sizetostr size = match size with
  | Free -> ""
  | Size(fl,str) -> "size:" ^ (string_of_float fl) ^ str ^ ";"

let style sz = "position:relative;float:left;" ^ (sizetostr sz)

let rec xhtml_string_div styleoptz div = match div with (id,sz,_,ds) -> begin
    let divhdr = divhdr id ((style sz) ^ styleoptz) in
    let body = "<p>" ^ id ^ "</p>" in
    let morechunx = xhtml_string_divset ds in
    let tail = "</div>\n" in
    divhdr ^ body ^ morechunx ^ tail
  end
and xhtml_string_divset ds = match ds with
  | Nil -> ""
  | Vert(divs) -> String.concat "" (List.map (xhtml_string_div "clear:left;") divs)
  | Horiz(divs) -> String.concat "" (List.map (xhtml_string_div "") divs)
