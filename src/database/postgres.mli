open Drake

(* Migrate the database *)
val migrate : unit -> unit

(* READ the all the nodes registered *)
val get_network : unit -> Node.t list Lwt.t

(* UPDATE the network with a new node | INSERT a new node in the network --> which is better?*)
val update_network : Node.t -> unit Lwt.t

(* INSERT a validated transaction in Mempool *)
val insert_transaction : Transaction.t -> unit Lwt.t

(* READ all the transactions in the Mempool *)
val get_mempool : unit -> Transaction.t list Lwt.t

(* INSERT a new validated block in the chain *)
val insert_block : Block.t -> unit Lwt.t

(* READ all the blocks in the chain *)
val get_chain : unit -> Block.t list Lwt.t
