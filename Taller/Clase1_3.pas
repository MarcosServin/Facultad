program netflix;
type
    rangoG=1..8;
    pelicula=record
        codigo:integer;
        genero:rangoG;
        puntaje:real;
        end;
    lista=^nodo;
    nodo=record
        dato:pelicula;
        sig:lista;
        end;

    vec_lis=array[rangoG] of lista;
    vec_dato=array[rangoG] of pelicula;

procedure llenar_vector(var vec_p:vec_lis);
    procedure inicializar_vec(var vec:vec_lis);
    var
        nue:lista;
        i:integer;
    begin
        nue:=nil;
        for i:=1 to 8 do
        begin
            vec[i]:=nue;
        end;
    end;
    procedure leer_datos(var elem:pelicula);
    begin
        WriteLn('Ingrese el codigo:');
        ReadLn(elem.codigo);
        if elem.codigo <> -1 then
        begin
            WriteLn('Ingrese el genero:');
            ReadLn(elem.genero);
            WriteLn('Ingrese el puntaje:');
            ReadLn(elem.puntaje);
        end;
    end;
    procedure agregar_atras(elem:pelicula;var puntero:lista);
    var
        nue:lista;
        ult:lista;
    begin
        new(nue);
        nue^.dato:=elem;
        nue^.sig:=nil;
        ult:=puntero;
        if ult<>nil then
        begin
            while ult^.sig<>nil do
            begin
                ult:=ult^.sig;
            end;
            ult^.sig:=nue;
        end
        else
        begin
            puntero:=nue;
        end;
    end;
var
    info_p:pelicula;
begin
    inicializar_vec(vec_p);
    leer_datos(info_p);
    while (info_p.codigo<>-1) do
    begin
        agregar_atras(info_p,vec_p[info_p.genero]);
        leer_datos(info_p);
    end;
end;
procedure simple_vec(vec_p:vec_lis;var v_pelis:vec_dato);//vector con el mayor puntaje en cada genero
var
    i:integer;
    max:lista;
    act:lista;
    nulo:pelicula;
begin
    for i:=1 to 8 do
    begin
        act:=vec_p[i];
        if act<>nil then
        begin
            max:=act;
            act:=act^.sig;
            while act<>nil do
            begin
                if (act^.dato.puntaje>max^.dato.puntaje) then
                begin
                    max:=act;
                end;
                act:=act^.sig;
            end;
        v_pelis[i]:=max^.dato;
        end
        else 
        begin
            nulo.codigo:=-1;
            nulo.genero:=i;
            nulo.puntaje:=-1;
            v_pelis[i]:=nulo;
        end;
    end;
end;

procedure ordenar_vec(var vec:vec_dato);
var
    i,j:integer;
    elem:pelicula;
begin
    for i:=2 to 8 do
    begin
        elem:=vec[i];
        j:=i;
        while ((j>1)and(vec[j-1].puntaje>elem.puntaje)) do
        begin
            vec[j]:=vec[j-1];
            j:=j-1;
        end;
        vec[j]:=elem;
    end;
end;

procedure vec_max_min(vec:vec_dato);
var
    max:pelicula;
    min:pelicula;
    i:integer;
    pri:integer;
begin
    i:=1;
    while vec[i].codigo=-1 do
    begin
        i:=i+1;
    end;
    pri:=i;
    max:=vec[pri];
    min:=vec[pri];
    for i:=pri to 8 do 
    begin
        if vec[i].codigo<>-1 then
        begin
            if vec[i].puntaje>max.puntaje then
            begin
                max:=vec[i];
            end;
            if vec[i].puntaje<min.puntaje then
            begin
                min:=vec[i];
            end;
        end;
    end;
    writeLn('Codigo de la pelicula con mayor puntaje: ',max.codigo);

    writeLn('Codigo de la pelicula con menor puntaje: ',min.codigo);
end;

var
v_lista:vec_lis;
v_pelis:vec_dato;
begin
    llenar_vector(v_lista);//A
    simple_vec(v_lista,v_pelis);//B
    ordenar_vec(v_pelis);//C
    vec_max_min(v_pelis);//D

end.