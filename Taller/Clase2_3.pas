program Clase2_3;

const
    dimF=20;

type
    rangoVec=1..20;
    rangoInt=300..1550;
    vector=array [rangoVec] of rangoInt;
    indice=-1..20;

// modulo que guarde un vector de 20 enteros random del 300 hasta 1550
procedure genVec_rec(var v:vector;var dimL:indice);
begin
    if dimL<=dimF-1 then
        begin
            dimL:=dimL+1;
            v[dimL]:=random(1550-300)+300;
            genVec_rec(v,diml);
        end
end;

//[1,5,6,3,2]

// modulo que ordene el vector
procedure ordVec(var v:vector;dimL:indice);
var
i,j:integer;
item:integer;
begin
    for i:=2 to dimL do 
        begin
        item:=v[i];
        j:=i;
        while (j>1) and (v[j-1] > item) do
            begin
            v[j]:=v[j-1];
            j:=j-1;
            end;
        v[j]:=item;
        end;
end;


procedure busquedaDicotomica(v:vector;ini,fin:indice;dato:integer;var posi:indice);
var
    centro:indice;
begin
    posi:=-1;
    while (ini<=fin) and (posi=-1) do 
        begin
            centro:=((ini+fin) div 2);
            if dato = v[centro] then
                begin
                    posi:=centro;
                end
            else if v[centro]<dato then
                begin
                    ini:=centro+1;//le resto 1 porque ya se aclara arriba que igual no es
                end
            else
                begin
                    fin:=centro-1;// idem
                end;
        end;

end;

procedure impVec_rec(v: vector; dimL:  indice);
begin    
     {-- Completar --}
    if dimL<>0 then
      begin 
        //writeln(v[dimL]);// Impríme desde DimL a 1
        impVec_rec(v,dimL-1);
        writeln('Posiscion: ',dimL,' ',v[dimL]);//
      end;
end; 

var
    v:vector;
    dimL:indice;
    posi:indice;
    ini,fin:indice;
    dato:integer;
begin
    Randomize;
    dimL:=0;
    genVec_rec(v,dimL);
    impVec_rec(v,dimL);
    writeln('Enter para ordenar el vector. ');
    readln();
    ordVec(v,dimL);
    impVec_rec(v,dimL);
    writeln('Ingrese el Entero a buscar: ');
    read(dato);
    ini:=1;
    fin:=dimL;
    busquedaDicotomica(v,ini,fin,dato,posi);
    if posi <>-1 then
        begin
            writeln(DATO,' se encuentra en la posicion: ',posi);
        end
    else 
        begin
            writeln('No se encontró el número.');
        end;
end.