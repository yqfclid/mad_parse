%%%-------------------------------------------------------------------
%%% @author Yqfclid 
%%% @copyright  Yqfclid (yqf@blackbird)
%%% @doc
%%%
%%% @end
%%% Created :  2019-06-05 16:19:14
%%%-------------------------------------------------------------------
-module(mad_parse_test).
-author("yqfclid").

-include_lib("eunit/include/eunit.hrl").
-compile([{parse_transform, mad_parse}]).

mad_parse_test_() ->
    Time = os:timestamp(),
    ?_assertEqual(0, Time).