open Printf

type options = string list;;
type size = Size of float * string | Free;;
type div = string * size * options * divset and 
divset = Nil | Horiz of div list | Vert of div list;;

let spaceout depth = for i=0 to depth do print_string " " done;;

let rec
  print_div d = print_div_rec 0 d
and
  print_div_rec depth d = 
    spaceout depth;
    match d with (id,sze,opts,ds) -> begin
        let sizestr = match sze with
          | Free -> "free"
          | Size(amt,unt) -> sprintf "%f %s" amt unt
        in
        let optstr = String.concat ":" opts in

        printf "div \"%s\": %s [%s]\n" id sizestr optstr;
        match ds with
          | Nil -> ()
          | Horiz(dl) -> begin
            spaceout depth;
            printf "horiz divlist:\n";
            print_divset_rec (depth + 1) dl
          end
          | Vert(dl) -> begin
            spaceout depth;
            printf "vert divlist:\n";
            print_divset_rec (depth + 1) dl
          end
    end;
and
  print_divset s = print_divset_rec 0 s
and
  print_divset_rec depth s =
    List.iter (print_div_rec depth) s
;;
