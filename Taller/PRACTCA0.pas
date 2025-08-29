// metodode ordenacion seleccion tiempo n^2
// necesito saber
// dimnsion logica del arreglo
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

// program ordenar;

// CONST 
//     dimF=...

// type
//     TipoElem=...
//     Indice=0..dimF
//     Tvector=array[1..dimF]to TipoElem;
// var
//     a:Tvector;
//     dimL:integer;

// begin
//     cargarector(a,dimL);
//     insercion(a,dimL);
// end.

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
end;