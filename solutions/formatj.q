formatj:{[str]
    p:ssr[str;",";",\n"];
    p:ssr[p;"{";"{\n"];
    p:ssr[p;"}";"\n}"];
    p:ssr[p;":";": "];
    lines:"\n" vs p;
    diffs:(sum each lines="{")-sum each lines="}";
    depths:-1_sums[0,diffs];
    indents:(4*depths)#'" ";
    o:indents,'lines;
    @[o;where "}" in 'o;4_]
    }