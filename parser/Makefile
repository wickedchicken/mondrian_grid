mondrian: mondrian.cmo lexer.cmo main.cmo div.cmo
	ocamlc -o mondrian str.cma mondrian.cmo lexer.cmo div.cmo main.cmo

mondrian.cmo: mondrian.mly div.cmo
	ocamlyacc mondrian.mly
	rm mondrian.mli 
	ocamlc -i mondrian.ml > mondrian.mli
	ocamlc -c mondrian.mli
	ocamlc -c mondrian.ml

lexer.cmo: lexer.mll mondrian.cmo
	ocamllex lexer.mll
	ocamlc -c lexer.ml

main.cmo: main.ml mondrian.cmo lexer.cmo div.cmo
	ocamlc -c main.ml

div.cmo: div.ml
	ocamlc -c div.ml

clean:
	-rm mondrian lexer.cmi lexer.cmo lexer.ml main.cmi main.cmo mondrian.cmi mondrian.cmo mondrian.ml mondrian.mli div.cmi div.cmo
