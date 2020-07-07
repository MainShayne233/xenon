-module(xenon_bridge).
-export([scan_xml_string/1]).

scan_xml_string(S) ->
  try
    Text = binary_to_list(S),
    {Doc, _} = xmerl_scan:string(Text),
    {ok, Doc}
  catch
    Error:Reason -> {error, {Error, Reason}}
  end.
