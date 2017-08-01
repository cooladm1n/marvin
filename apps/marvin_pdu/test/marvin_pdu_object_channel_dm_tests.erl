-module(marvin_pdu_object_channel_dm_tests).

-include_lib("eunit/include/eunit.hrl").
-include("marvin_discord.hrl").
-include("marvin_pdu.hrl").
-include_lib("marvin_helper/include/marvin_specs_tests.hrl").


-spec ?test_spec(test).

%% automatically generated by eunit


-spec ?test_spec(t01_can_get_new_test).

t01_can_get_new_test() ->
    User = marvin_pdu_object_user:new(
        100, <<"user">>, <<"1337">>, <<"some-long-hash">>,
        false, true, true, <<"nobody@nowhere.com">>
    ),
    marvin_pdu_object_channel_dm:new(
        100, 1, 200, [User]
    ).

-spec ?test_spec(t02_can_get_fields_from_opaque_test).

t02_can_get_fields_from_opaque_test() ->
    User = marvin_pdu_object_user:new(
        100, <<"user">>, <<"1337">>, <<"some-long-hash">>,
        false, true, true, <<"nobody@nowhere.com">>
    ),
    Object0 = marvin_pdu_object_channel_dm:new(
        100, 1, 200, [User]
    ),
    ?assertEqual(100, marvin_pdu_object_channel_dm:id(Object0)),
    ?assertEqual(1, marvin_pdu_object_channel_dm:type(Object0)),
    ?assertEqual(200, marvin_pdu_object_channel_dm:last_message_id(Object0)),
    ?assertEqual([User], marvin_pdu_object_channel_dm:recipients(Object0)).

-spec ?test_spec(t04_can_export_object_test).

t04_can_export_object_test() ->
    User = marvin_pdu_object_user:new(
        100, <<"user">>, <<"1337">>, <<"some-long-hash">>,
        false, true, true, <<"nobody@nowhere.com">>
    ),
    Object0 = marvin_pdu_object_channel_dm:new(
        100, 1, 200, [User]
    ),
    ?assertMatch({ok, _Message}, marvin_pdu_object_channel_dm:export(Object0)).

-spec ?test_spec(t99_can_get_valid_parsed_test).

t99_can_get_valid_parsed_test() ->
    {ok, JSONBin} = file:read_file(
        code:priv_dir(marvin_pdu) ++ "/marvin_pdu_object_channel_dm_test.json"),
    Data = jiffy:decode(JSONBin, [return_maps]),
    Map = marvin_pdu_object_channel_dm:data_map(),
    ?assertMatch({[], _Result}, jiffy_vm:validate(Map, Data)).
