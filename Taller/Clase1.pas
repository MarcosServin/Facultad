// a)vector sin orden con al menos 300 oficinas.
// de cada oficina:codigo , dni ,valor .
// finaliza con un codigo = -1.
// b)ordenado por codigo;insercion.
// c)ordenado por seleccion.

program punto_2;
CONST
    dimF=300;
type
    oficina=record
        codigo:integer;
        dni:integer;
        valor:integer;
        end;
    vec_ofi = array[ 1..dimF] of oficina;
    rangoL=0..dimF;


procedure llenar_vector(var v:vec_ofi;var dimL:rangoL);
    procedure leer_ofi(var elem:oficina);
    begin
        WriteLn('Ingrese el Código de la oficina: ');
        ReadLn(elem.codigo);
        if elem.codigo<>-1 then
        begin
            WriteLn('Ingrese el DNI del propietario: ');
            ReadLn(elem.dni);
            WriteLn('Ingrese el Valor de las expensas: ');
            ReadLn(elem.valor);
        end;
    end;
var
    ofi:oficina;
begin
    leer_ofi(ofi);
    while ((ofi.codigo<>-1) and (dimL<=dimF)) do
    begin
        dimL:=dimL+1;
        v[dimL]:=ofi;
        leer_ofi(ofi);
    end;
end;

procedure orden_insercion(var vec:vec_ofi;dimL:rangoL);
var
    i,j:integer;
    elem:oficina;
begin
    for i:=2 to dimL do
    begin
        elem:=vec[i];
        j:=i;
        while (j>1)and(vec[j-1].codigo>elem.codigo) do
        begin
            vec[j]:=vec[j-1];
            j:=j-1;
        end;
        vec[j]:=elem;
    end;
end;

procedure orden_seleccion(var vec: vec_ofi; dimL: rangoL);
var
    i, j, pos: integer;
    elem: oficina;
begin
    for i := 1 to dimL-1 do
    begin
        pos := i;
        { buscar la posición del mínimo en la parte no ordenada }
        for j := i+1 to dimL do
        begin
            if vec[j].codigo < vec[pos].codigo then
                pos := j;
        end;

        { intercambiar una sola vez }
        elem := vec[pos];
        vec[pos] := vec[i];
        vec[i] := elem;
    end;
end;



procedure ImprimirVector(vec:vec_ofi;dimL:rangoL);
var
    i:integer;
begin
    writeln();
    Write('Codigo de la Oficina:  ');
    for i:=1 to dimL do
    begin
        write(vec[i].codigo,'  |  ');
    end;
    writeln();
    Write('DNI del propietario:   ');
    for i:=1 to dimL do
    begin
        write(vec[i].dni,'   |   ');
    end;
    writeln();
    Write('Valor de las expensas: ');
    for i:=1 to dimL do
    begin
        write(vec[i].valor,'  |  ');
    end;
    writeln();
end;

var
    v:vec_ofi;
    dimL:rangoL;
begin
    dimL:=0;
    llenar_vector(v,dimL);
    writeln();
    writeln('Vector Original:');
    ImprimirVector(v,dimL);
    orden_insercion(v,dimL);
    writeln();
    writeln('Vector por insercion:');
    ImprimirVector(v,dimL);
    orden_seleccion(v,dimL);
    writeln();
    writeln('Vector por seleccion:');
    ImprimirVector(v,dimL);
end.