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
        dno:integer;
        valor:integer;
        end;
    vec_ofi = array[ 1..dimF] of oficina;
    rangoL=1..dimF;

procedure llenar_vector(var v:vec_ofi,dimL:rangL);
var
    ofi:oficina;
begin
    dimL:=0;
    ofi.codigo:=readln('Ingrese Código: ');
    while (ofi.codigo<>-1) and (dimF=>dimL) then do
        begin
            ofi.dni:=readln('Ingrese DNI: ');
            ofi.valor:=readln('Ingrese el valor de las expensas: ');
            dimL:=dimL+1
            v[dimL]:=ofi;
            ofi.codigo:=readln('Ingrese Código: ');
        end;
end;

procedure orden_insercion();
var

begin

end;


var
    v:vec_ofi;
    dimL:rangoL;
begin
    llenar_vector(v,dimL);
    orden_insercion(v,dimL);
    orden_seleccion(v,dimL);
end.