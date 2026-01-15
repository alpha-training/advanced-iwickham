\d .qs

func.add:{x+y}
func.add3:{x+y+z}

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
  lines 
  }

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