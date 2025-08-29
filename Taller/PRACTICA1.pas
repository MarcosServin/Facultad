// metodo de ordenacion :seleccion, tiempo n^2
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