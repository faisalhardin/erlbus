-module(chat_erlbus_handler).
-import(string,[to_lower/1]). 

%% API
-export([handle_msg/2]).
-define(KEY, "Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not. It's not a story the Jedi would tell you. It's a Sith legend. Darth Plagueis was a Dark Lord of the Sith, so powerful and so wise he could use the Force to influence the midichlorians to create life… He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. The dark side of the Force is a pathway to many abilities some consider to be unnatural. He became so powerful… the only thing he was afraid of was losing his power, which eventually, of course, he did. Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. Ironic. He could save others from death, but not himself.").


handle_msg(Msg, Context) ->
  erlang:display(Msg),
  erlang:display(binary:bin_to_list(element(2,Msg))),
  erlang:display(binary:list_to_bin(encrypt_message(binary:bin_to_list(element(2,Msg))))),
  Context ! {message_published, {element(1,Msg),binary:list_to_bin(encrypt_message(binary:bin_to_list(element(2,Msg))))}}.

encrypt_message(Msg) ->
  encrypt_message([], Msg, ?KEY).
encrypt_message(Acc, [], _) ->
  %erlang:display(Acc),
  Acc;
encrypt_message(Acc, [Hm|Tm], [Hk|Tk] ) ->
  encrypt_message(Acc ++ [(Hm bxor Hk)],Tm, Tk ++ [Hk]).


  
