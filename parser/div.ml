type options = string list;;
type size = Size of float * string | Free;;
type div = string * size * options * divset and 
divset = Nil | Horiz of div list | Vert of div list;;
