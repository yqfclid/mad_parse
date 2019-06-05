%%%-------------------------------------------------------------------
%%% @author Yqfclid 
%%% @copyright  Yqfclid (yqf@blackbird)
%%% @doc
%%%
%%% @end
%%% Created :  2019-06-05 16:09:37
%%%-------------------------------------------------------------------
-module(mad_parse).
-author("yqfclid").

-export([parse_transform/2]).

%%%===================================================================
%%% API
%%%===================================================================
parse_transform(AST, _Options) ->
    parse_ast(AST, []).

parse_ast([], Acc) ->
    lists:reverse(Acc);
parse_ast([{function, Line, Name, Arity, Clauses}|T], Acc) ->
    NClauses = parse_clauses(Clauses, []),
    parse_ast(T, [{function, Line, Name, Arity, NClauses}|Acc]);
parse_ast([H|T], Acc) ->
    parse_ast(T, [H|Acc]).



parse_clauses([], Acc) ->
    lists:reverse(Acc);
parse_clauses([{clause, Line, Arguments, Guards, Body}|T], Acc) ->
    NBody = parse_body(Body, []),
    parse_clauses(T, [{clause, Line, Arguments, Guards, NBody}|Acc]).

parse_body([], Acc) ->
    lists:reverse(Acc);
parse_body([H|T], Acc) ->
    parse_body(T, [do_transform(H)|Acc]).


do_transform({call, Line, {remote, _Line1, {atom, _Line2, os},
                                           {atom, _Line3, timestamp}}, _Arguments0}) ->
    {atom, Line, 0};
do_transform(Stmt) when is_tuple(Stmt) ->
    list_to_tuple(do_transform(tuple_to_list(Stmt)));
do_transform(Stmt) when is_list(Stmt) ->
    [do_transform(S) || S <- Stmt];
do_transform(Stmt) ->
    Stmt.
%%%===================================================================
%%% Internal functions
%%%===================================================================