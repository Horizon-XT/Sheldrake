type t = { hostname : string; address : string } [@@deriving yojson]

type query = { id : int; query_hostname : string; query_address : string }
[@@deriving yojson]

let init hostname address = { hostname; address }

let ( = ) host_1 host_2 =
  let name =
    if String.compare host_1.hostname host_2.hostname = 0 then true else false
  in
  let address =
    if String.compare host_1.address host_2.address = 0 then true else false
  in
  if name && address then true else false

let query_to_t { id = _; query_hostname = hostname; query_address = address } =
  { hostname; address }

let t_to_query id { hostname; address } =
  { id; query_hostname = hostname; query_address = address }

let extract_list network = network
let unpack_the_node node = (node.hostname, node.address)
let length network = List.length network

external get_global_addr : unit -> string = "stub_get_global_addr"

let of_yojson_list json =
  match [%of_yojson: t list] json with
  | Ok network -> network
  | Error err -> err |> fun _ -> raise Parsing.Parse_error

let to_yojson_list network = [%to_yojson: t list] network
let add_node node network = node :: network

let retrieve_host_entries =
  let host_name = Unix.gethostname () in
  let host_addr = get_global_addr () in
  { hostname = host_name; address = host_addr }

let addr current_node = current_node.address
let name current_node = current_node.hostname

let check_current_node_on_network node network =
  let rec aux = function
    | [] -> false
    | hd :: tl -> if hd = node then true else aux tl
  in
  aux network
