-module(marvin_pdu2_heartbeat).
-compile({parse_transform, cloak_transform}).

-export([export/1]).

-record(?MODULE, {
    last_seq :: marvin_pdu2:pdu_seq()
}).

-type t() :: #?MODULE{}.
-export_type([t/0]).


cloak_validate(last_seq, Value) when Value > 0 ->
    {ok, Value};

cloak_validate(_, _) ->
    {error, invalid}.


export(#?MODULE{last_seq = LastSeq}) ->
    % This PDU is quite inconsistent: data structure is the one integer
    LastSeq.
