-module(marvin_pdu_hello_tests).

-include_lib("eunit/include/eunit.hrl").
-include("marvin_discord.hrl").
-include("marvin_pdu.hrl").



t01_can_get_new_test() ->
    marvin_pdu_hello:new(100, [<<"trace_part">>]).


t02_can_get_fields_from_opaque_test() ->
    PDU0 = marvin_pdu_hello:new(100, [<<"trace_part">>]),
    ?assertEqual(100, marvin_pdu_hello:heartbeat_interval(PDU0)),
    ?assertEqual([<<"trace_part">>], marvin_pdu_hello:trace(PDU0)).


t03_can_set_fields_to_opaque_test() ->
    PDU0 = marvin_pdu_hello:new(100, [<<"trace_part">>]),
    PDU1 = marvin_pdu_hello:heartbeat_interval(200, PDU0),
    PDU2 = marvin_pdu_hello:trace([<<"another_trace_part">>], PDU1),
    ?assertEqual(200, marvin_pdu_hello:heartbeat_interval(PDU2)),
    ?assertEqual([<<"another_trace_part">>], marvin_pdu_hello:trace(PDU2)).


t04_can_render_valid_opaque_test() ->
    PDU0 = marvin_pdu_hello:new(100, [<<"trace_part">>]),
    ?assertMatch({ok, _Message}, marvin_pdu:render(PDU0)).


t05_can_get_error_on_negative_heatbeat_interval_test() ->
    PDU0 = marvin_pdu_hello:new(-100, [<<"trace_part">>]),
    ?assertMatch(
        {error, {validation_errors, [{_, _, [_, ?discord_key_hello_heartbeat_interval]}]}},
        marvin_pdu:render(PDU0)
    ).


t06_can_get_error_on_nonstring_trace_part_test() ->
    PDU0 = marvin_pdu_hello:new(100, ["trace_part"]),
    ?assertMatch(
        {error, {validation_errors, [{_, _, [_, ?discord_key_hello__trace]}]}},
        marvin_pdu:render(PDU0)
    ).


t99_can_get_valid_parsed_test() ->
    {ok, JSONBin} = file:read_file(
        code:priv_dir(marvin_pdu) ++ "/marvin_pdu_hello_test.json"),
    ?assertMatch({ok, ?marvin_pdu_hello(_)}, marvin_pdu:parse(JSONBin)).
