// metodo de ordenacion :seleccion, tiempo n^2
// necesito saber
// dimnsion logica del vector
// posicion donde va el  elemento ordenado
// posicion desde la que vamos a buscar el minimo
// posicion del elementoo minimo

// procedure ordenar_seleccion(var v:tVector;dimL:indice); //busca minimo y guarda en pos la posicion
// var 
//     i,j,pos:indice;
//     item:tipoElem;
// begin
//     for i:1 to dimL-1 do begin
//         pos:=i;
//         for j:=i+1 to dimL do
//             if v[j]<v[pos]then pos:=j;       
//         //intercambia v[i] y v[p]
//         item:=v[pos];
//         v[pos]:=v[i];
//         v[i]:=item;
//     end;
// end;

// metodo de ordenacion:insercion;tiempo n^2
// necesito saber
// dmension logica del arreglo
// posicion que se debe comparar
// cuantos elementos ya estan ordenados

// program ordenar_insercion;

// CONST 
//     dimF=...

// type
//     TipoElem=...
//     Indice=0..dimF
//     Tvector=array[1..dimF]to TipoElem;
// var
//     a:Tvector;
//     dimL:integer;
procedure insercion(vec:vector;dimL:rangoL);
var
    i:integer;
    j:integer;
    indice:integer;
begin
    for i :=2 to dimL-1 do
    begin
        indice:=vec[i];
        j:=i;
        while ((j>1)and (vec[j-1]>indice)) do
            begin
                vec[j]:=vec[j-1];
                j:=j-1;
            end;
        vec[j]:=indice;
    end;
end;


// begin
//     cargarector(a,dimL);
//     insercion(a,dimL);
// end.

program uno;
const
    dimF = 300;
type
    rango = 1..dimF;
    oficina = record
        codigo:integer;
        dni:LongInt;
        valor:integer;
    end;
    vector = array [rango] of oficina;
//
procedure LeerOficina(var off:oficina);
begin
    WriteLn('Codigo: '); ReadLn(off.codigo);
    if (off.codigo <> -1) then
    begin
        WriteLn('Dni: '); ReadLn(off.dni);
        WriteLn('Valor: '); ReadLn(off.valor);
    end;
end;
//
procedure CargarOficinas(var v:vector;var dimL:integer);
var
    off:oficina;
begin
    LeerOficina(off);
    while (off.codigo <> -1) and (dimL<dimF) do
    begin
        dimL:=dimL+1;
        v[dimL]:=off;
        LeerOficina(off);
    end;
end;
//
Procedure seleccion ( var v: vector; dimL: Integer );
var 
    i, j, pos: Integer; 
    actual:oficina;
begin
    for i := 1 to diml-1 do begin 
      pos:= i;
      for j:= i+1 to diml do 
        if (v[j].codigo < v[pos].codigo)then 
            pos:=j ; 
        actual:= v[pos]; 
        v[pos]:= v[i];  
        v[i]:= actual;    
    end;
  end;


procedure ImprimirVector(v:vector;dimL:integer);
var
    i:integer;
begin
    for i:=1 to dimL do
    begin
        WriteLn('Codigo: ',v[i].codigo);
        WriteLn('Dni: ',v[i].dni);
        WriteLn('Valor: ',v[i].valor);
    end;
end;

Procedure insercion ( var v: vector; dimL: Integer );
var 
    i, j, p: Integer; 
    item : Integer;	
    actual:oficina;
begin
    for i:=2 to dimL do 
    begin 
        actual:= v[i];
        j:= i-1; 
        while (j > 0) and (v[j].codigo > actual.codigo) do
        begin
            v[j+1]:= v[j];
            j:=j-1;
        end;  
        v[j+1]:= actual; 
    end;
end;

var
    v:vector;
    dimL:integer;
begin
    dimL:=0;
    CargarOficinas(v,dimL);
    ImprimirVector(v,dimL);
    WriteL('__');
    insercion(v,dimL);
    ImprimirVector(v,dimL);
end.
