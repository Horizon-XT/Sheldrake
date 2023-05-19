open Drake

type t

(* Convert to json *)
val to_yojson : t -> Yojson.Safe.t

(* Decode from json *)
val of_yojson : Yojson.Safe.t -> t

(* Mempool length *)
val length : t -> int

(* Add a transaction *)
val add_transaction : t -> Transaction.t -> t

(* Visualization purposes -> get five random transactions *)
val five_transactions : t -> Transaction.t list

(* Verify the transactions in the mempool *)
val is_valid : t -> bool
