open Util;;
let (key, value) = Program.get_input() in
let block = split_spaces value in
let num_trans = int_of_string (List.hd x) and trans = List.tl xs in

let rec format_block (t : string list) trans incnt outcnt acc 
	: (string * (int * int)) list = 
	match t with
	| a::b::xs -> 
		begin 
		let key = int_of_string key in
		if incnt > 0 then (*Formatting incoins*)
			format_block (b::xs) trans (incnt-1) outcnt ((a, (0, key))::acc)
		else if outcnt > 0 then (*Formatting outcoins*)
			format_block xs trans 0 (outcnt-1) ((a,(int_of_string b, key))::acc)
		else if trans > 0 then failwith "More transactions than stated"
		else (*End of one transaction, start of another*)
			match t with
			| incnt::outcnt::xs -> 
				format_block xs (trans-1) (int_of_string incnt) (int_of_string outcnt) acc
			| [_] -> failwith "Misalignment issue"
			| [] -> acc
		end
	| [_] -> failwith "Misalignment issue"
	| [] -> acc (*Completely done with block*)
in
Program.set_output (format_block trans num_trans 0 0 [])