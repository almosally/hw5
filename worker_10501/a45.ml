open Util;;
let (key, value) = Program.get_input() in
match split_spaces value with
x::xs -> let num_trans = x and trans = xs in

let format_block (t : string list) trans incnt outcnt acc = 
	match t with
	| a::b::xs -> 
		let key = int_of_string key in
		if incnt > 0 then (*Formatting incoins*)
			format_block (b::xs) trans (incnt-1) outcnt (a, (0, key))::acc
		else if outcnt > 0 then (*Formatting outcoins*)
			format_block xs trans 0 (outcnt-1) (a,(int_of_string b, key))::acc
		else if trans > 0 then failwith "More transactions than stated"
		else (*End of one transaction, start of another*)
			match t with
			| incnt::outcnt::xs -> format_block (trans-1) xs incnt outcnt acc
	| [] -> acc (*Completely done with block*)
in
Program.set_output(format_block trans num_trans 0 0 [])