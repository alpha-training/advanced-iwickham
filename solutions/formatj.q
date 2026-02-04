formatj:{[str]
    p:ssr[str;",";",\n"];
    p:ssr[p;"{";"{\n"];
    p:ssr[p;"}";"\n}"];
    p:ssr[p;":";": "];
    p:ssr[p;"[[]";"[\n"];
    p:ssr[p;"[]]";"\n]"];
    lines:"\n" vs p;
    a:indent["{";"}";"\n" vs p];
    indent["[";"]";a]
    }
indent:{[x;y;z]
    diffs:(sum each z=x)-sum each z=y;
    depths:-1_sums[0,diffs];
    indents:(4*depths)#'" ";
    o:indents,'z;
    @[o;where y in 'o;4_]
    }