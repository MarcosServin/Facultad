
program Clase2_2;

type 
    rangoInt=100..200;
    lista=^nodo;
    nodo=record
        dato:rangoInt;
        sig:lista;
        end;


//modulo recursivo que genere una lista int random 100-200;termina con 100

procedure genLis_rec(var l:lista);
var
    nue:lista;
begin
    new(nue);
    nue^.sig:=nil;
    nue^.dato:=random(100)+100;
    if l<>nil then
        begin
            l^.sig:=nue;
        end
    else 
        begin
            l:=nue;
        end;
    if nue^.dato<>100 then
        begin
            genLis_rec(nue);
        end;
end;


//modulo recursivo que imprime los eneteros de la lista en el orden original
procedure impLis_rec(l:lista);
begin
    if l<>nil then
        begin
            writeln(l^.dato);
            impLis_rec(l^.sig);
        end;
end;

//modulo recursivo que imprime los eneteros de la lista en el orden inverso
procedure impLisInv_rec(l:lista);
begin
    if l<>nil then
        begin
            impLisInv_rec(l^.sig);
            writeln(l^.dato);
        end;
end;


//modulo que devuelve el minimo en la lista
function minList_rec(l:lista;var min:integer):rangoInt;
begin
    if l<> nil then
        begin
            if l^.dato<min then
                begin
                    min:=l^.dato;
                end;
            min:=minList_rec(l.^.sig,min);
        end;
    minList_rec:=min;
end;

//modulo que devuelve bool si un valor se encuentra en la lista
function boolList_rec(l:lista;valor:rangoInt):boolean;
begin
    if l=nil then
        begin
            boolList_rec:=False;//No lo encuentra
        end
    else if l^.dato=valor then
        begin
            boolList_rec:=True;//Lo encuentra
        end
    else
        begin
            boolList_rec:=boolList_rec(l^.sig,valor);
        end;
end;


var
    l:lista;
    min:rangoInt;
    minimo:rangoInt;
    num:integer;
begin
    Randomize;
    l:=nil;
    genLis_rec(l);
    impLis_rec(l);
    impLisInv_rec(l);
    min:=200;
    minimo:=minList_rec(l,min);
    readln(num);
    esta:=boolList_rec(l,num)

end.