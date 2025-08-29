
//actividad 1
program NumAleatorio;
 var ale: integer;
 begin
     randomize;
     ale := random (100);
     writeln ('El número aleatorio generado es: ', ale);
     readln;
 end.
 //genera un rumero random
 program NumAleatorio;
 function imprimir_random();
 var
    i:integer;
    num:integer;
 begin
    for i:1 to 20 do
        num:=random(100);
        writeln(num);
 end;

 function imp_rango(N:integer;A:integer;B:integer);
 var 
    i:integer;
    num:integer;
 begin
    for i:1 to N;
        num:=random(A,B);
        writeln(num);
 end;

function impr_hasta(a,b,f:integer);
var
    num:integer;
begin
    num:=random(a,b);
    while num<>f then
        writeln(num)
        num:=random(a,b);
    end;
end;
 var ale: integer;
    n:integer;
    a:integer;
    b:integer;
    f:integer;
 begin
     randomize;
     ale := random (100);
     writeln ('El número aleatorio generado es: ', ale);//imprime un numero random
     readln;
     imprimir_random();
     readln(n);
     readln(a);
     readln(b);
     imp_rango(n,a,b);
     readln(a);
     readln(b);
     readln(f);
     impr_hasta(a,b,f);
 end.

//ACTIVIDAD 2
program punto_a;

procedure CargarVector(var vecVacio:vecEnteros;var dimL:integer;Min:integer;Max:integer);//dimF=50
var
    nueVec:vecEnteros;
    num:integer;
    i:integer;
begin
    dimL:=0;
    i:=1;
    num:=random(Min,Max);
    while num<>0 and dimL>=dimF do
        nueVec[i]:=num;
        i:=i+1;
        dimL:=dimL+1;
        end;
    vecVacio:=nueVec;
end;

procedure ImprimirVector(vec:vecEnteros;dimL:integer);
var
    i:integer;
begin
    for i:1 to dimL do
        writeln(vec[i]);
    end;
end;//cambiaria el orden del for y uasria downto
var
min:integer;
max:integer;
dimL:integer;
v:vecEnteros;
begin
readln(min);
readln(max)
CargarVector(v,dimL,min,max);
ImprimirVector(v,dimL);
end.

// ACTIVIDAD 3
type
    lista=^nodo;
    modo=record
        dato:[100..150];
        sig:lista;
        end;
    
procedure CargarLista(var l:lista);
