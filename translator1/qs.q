\d .qs
HEADERS:string`vars`state`indicators`enter`signal_exit`stop_loss`take_profit`time_stop`trailing_stop`exit_policy`execution

func.add:{x+y}
func.add3:{x+y+z}

l:{[p]
  lines:read0 p;
  lines:lines where 0<count each lines;
  header:(-1_'lines)in .qs.HEADERS;
  if[not all (1_header)=1_not lines like" *";'"(invalid header(s):"," " sv .qs.HEADERS where not (1_header)=1_not lines like" *",":)"]
  sections:(where header)_lines;
  processSection each sections;:;
 }

processSection:{[x]
    h:-1_first x;
    -1"processing ",h;
    {-1 "\"", x, "\""}each 1_x;
  }

parsef:{[file]
  lines:read0 file;
  lines:lines where 0<count each lines;
  goodexpression each lines;
  changes:(("(";"[");(")";"]");(",";";");(" [[]";"["));
  lines:{ssr[x;y 0;y 1]}/[;changes]each lines;
  lines:{[line;fn] ssr[line;" ",fn,"[[]";"func.",fn,"["]}/[;1_string key func]each lines;
  lines:(ssr[;"\t";""]each lines)except'" ";
  lines:{x[x?"="]:":";x}each lines;
  argchecker each lines;
  lines }

argchecker:{[line]
  starts:line ss"func.";
  d:starts cut line;
  ends:d ss'"]";
  fns:(ends+1)#'d;
  fnsq:".qs.",/:fns;
  cntarg:count each(get each get each(`$("[" vs'fnsq)[;0]))[;1];
  parsearg:1+sum each fns in'";";
  if[any z:not cntarg=parsearg;'"Too many arguments provided: ",ssr[raze fns where z;"func.";""]]
 }

goodexpression:{
    s:sums(x="(")-x=")";
    if[not(all s>= 0)and 0=last s;'"Badly formed expression: ",x]
 }

\d .