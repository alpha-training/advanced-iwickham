\d .qs
HEADERS:string`vars`state`indicators`enter`signal_exit`stop_loss`take_profit`time_stop`trailing_stop`exit_policy`execution



func.add:{x+y}

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
  lines:ssr[;"(";"["]each lines;
  lines:ssr[;")";"]"]each lines;
  lines:ssr[;",";";"]each lines;
  lines:ssr[;" [[]";"["]each lines;
  lines:{[line;fn] ssr[line;" ",fn,"[[]";"func.",fn,"["]}/[;1_string key func]each lines;
  lines:(ssr[;"\t";""]each lines)except'" ";
  lines:{x[x?"="]:":";x}each lines;
  argchecker each lines;
  lines }





  split:"="vs'lines;
  {@[{(`$x 0)set get x 1};x;errtrp[;x]]}each split 




errtrp:{[err;line]
  prefix:$[err~"rank";"'Too many arguments provided: ";"'Badly formed expression: "];
  -1 prefix,line[0]," = ",ssr[line 1;"func.";""];}



/ l: "r4:func.add[5;6]+func.add3[50;100;30]"

argchecker:{[line]
  starts:line ss"func.";
  d:starts cut line;
  ends:d ss'"]";
  fns:(ends+1)#'d;
  fnsplit:"["vs'fns;
  cntarg:count each(get each get each `$fnsplit[;0])[;1];
  parsearg:1+sum each fns in'";";
  if[any z:not cntarg=parsearg;'"Too many arguments provided: ",ssr[raze fns where z;"func.";""]]
 }




goodexpression:{
    s:sums(x="(")-x=")";
    if[not(all s>= 0)and 0=last s;'"Badly formed expression: ",l]