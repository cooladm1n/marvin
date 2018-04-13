-module(marvin_guild_helper_channel_category).

-include("marvin_guild_state.hrl").

-export([handle_call_do_provision_chain/1]).



%% Interface



-spec handle_call_do_provision_chain({Struct :: marvin_pdu2_dispatch_guild_create:t(), S0 :: state()}) ->
    marvin_helper_type:ok_return(OkRet :: {
        Struct :: marvin_pdu2_dispatch_guild_create:t(),
        S1 :: state()
    }).

handle_call_do_provision_chain({Struct, S0}) ->
    Channels = [
        Channel || Channel <- marvin_pdu2_dispatch_guild_create:channels(Struct),
        marvin_pdu2_object_channel:channel_type_guild_category() == marvin_pdu2_object_channel:type(Channel)
    ],
    marvin_log:info("Guild '~s' categories: ~p total", [S0#state.guild_id, length(Channels)]),
    S1 = lists:foldl(fun set_channel_category/2, S0, Channels),
    {ok, {Struct, S1}}.



%% Internals



-spec set_channel_category(ChannelStruct :: marvin_pdu2_object_channel:t(), S0 :: state()) ->
    Ret :: state().

set_channel_category(ChannelStruct, #state{
    channel_category_state = ChannelStateEts,
    guild_id = GuildId
} = S0) ->
    ChannelId = marvin_pdu2_object_channel:id(ChannelStruct),
    marvin_channel_registry:register(GuildId, ChannelId),
    ets:insert(ChannelStateEts, #channel{channel_id = ChannelId, channel = ChannelStruct}),
    S0.