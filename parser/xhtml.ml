open Div

let divhdr id style = "<div id=\"" ^ id ^ "\" style=\"" ^ style ^ "\">"
let sizetostr size = match size with
  | Free -> ""
  | Size(fl,str) -> "width:" ^ (Printf.sprintf "%f" fl) ^ str ^ ";"

let style sz = "position:relative;float:left;" ^ (sizetostr sz)

let bgcolor =
  fun _ -> let randcolor = (Random.int (256 * 256 * 256)) in
  let hexcolor = Printf.sprintf "#%06x" randcolor in
  "background-color:" ^ hexcolor ^ ";"

let rec xhtml_string_div styleoptz func div = match div with (id,sz,_,ds) -> begin
    let divhdr = divhdr id ((style sz) ^ styleoptz ^ (func 1)) in
    let body = "<p>" ^ id ^ "</p>" in
    let morechunx = xhtml_string_divset ds in
    let tail = "</div>\n" in
    divhdr ^ body ^ morechunx ^ tail
  end
and xhtml_string_divset ds = match ds with
  | Nil -> ""
  | Vert(divs) -> String.concat "" (List.map (xhtml_string_div "clear:left;" bgcolor) divs)
  | Horiz(divs) -> String.concat "" (List.map (xhtml_string_div "" bgcolor) divs)

let xhtml_hdr = 
  "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
  <html xmlns=\"http://www.w3.org/1999/xhtml\">
  <head>
  <title>title</title>
  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
  <link rel=\"stylesheet\" type=\"text/css\" href=\"splash.css\" media=\"screen\" />
  </head>
  <body>"

let xhtml_ftr =
  "</body></html>"
