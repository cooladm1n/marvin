-module(marvin_pdu_object_user_tests).

-include_lib("eunit/include/eunit.hrl").
-include("marvin_discord.hrl").
-include("marvin_pdu.hrl").
-include_lib("marvin_helper/include/marvin_specs_tests.hrl").


-spec ?test_spec(test).

%% automatically generated by eunit


-spec ?test_spec(t01_can_get_new_test).

t01_can_get_new_test() ->
    marvin_pdu_object_user:new(
        100, <<"user">>, <<"1337">>, <<"some-long-hash">>,
        false, true, true, <<"nobody@nowhere.com">>
    ).

-spec ?test_spec(t02_can_get_fields_from_opaque_test).

t02_can_get_fields_from_opaque_test() ->
    Object0 = marvin_pdu_object_user:new(
        100, <<"user">>, <<"1337">>, <<"some-long-hash">>,
        false, true, true, <<"nobody@nowhere.com">>
    ),
    ?assertEqual(100, marvin_pdu_object_user:id(Object0)),
    ?assertEqual(<<"user">>, marvin_pdu_object_user:username(Object0)),
    ?assertEqual(<<"1337">>, marvin_pdu_object_user:discriminator(Object0)),
    ?assertEqual(<<"some-long-hash">>, marvin_pdu_object_user:avatar(Object0)),
    ?assertEqual(false, marvin_pdu_object_user:bot(Object0)),
    ?assertEqual(true, marvin_pdu_object_user:mfa_enabled(Object0)),
    ?assertEqual(true, marvin_pdu_object_user:verified(Object0)),
    ?assertEqual(<<"nobody@nowhere.com">>, marvin_pdu_object_user:email(Object0)).

-spec ?test_spec(t04_can_export_object_test).

t04_can_export_object_test() ->
    Object0 = marvin_pdu_object_user:new(
        100, <<"user">>, <<"1337">>, <<"some-long-hash">>,
        false, true, true, <<"nobody@nowhere.com">>
    ),
    ?assertMatch({ok, _Message}, marvin_pdu_object_user:export(Object0)).

-spec ?test_spec(t99_can_get_valid_parsed_test).

t99_can_get_valid_parsed_test() ->
    {ok, JSONBin} = file:read_file(
        code:priv_dir(marvin_pdu) ++ "/marvin_pdu_object_user_test.json"),
    Data = jiffy:decode(JSONBin, [return_maps]),
    Map = marvin_pdu_object_user:data_map(),
    ?assertMatch({[], _Result}, jiffy_vm:validate(Map, Data)).
