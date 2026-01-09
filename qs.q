\d .qs
HEADERS:string`vars`state`indicators`enter`signal_exit`stop_loss`take_profit`time_stop`trailing_stop`exit_policy`execution

l:{[p]
  lines:read0 p;
  lines:lines where 0<count each lines;
  header:(-1_'lines)in .qs.HEADERS;  
  if[not all (1_header)=1_not lines like " *";'"(invalid header(s):ars:)"]
  sections:(where header)_lines;
  processSection each sections;:;
 }

processSection:{[x]
    h:-1_first x;
    -1"processing ",h;
    {-1 "\"", x, "\""}each 1_x;
  }
