program Clase4_4;
type
    t_arbol=^p_prod;
    p_prod=record
        cod_prod:integer;
        cant_tot:integer;
        monto:int64;
        hi:t_arbol;
        hd:t_arbol;
        end;

    t_venta=record
        cod_vent:integer;
        cod_prod:integer;
        precio:integer;
        end;
// leer venta
// ingresar venta al arbol
// generar arbol
procedure generar_arbol(var arbol:t_arbol);
    procedure leer_venta(var elem:t_venta;var id_ventas:integer);
    begin
        elem.cod_vent:=random(500)-1;
        if elem.cod_vent<>-1 then begin
            elem.cod_prod:=random(100+1);
            elem.precio:=random(5000+1);
            id_ventas:=id_ventas+1;
            end;
    end;
    procedure ing_arbol(var arbol:t_arbol;venta:t_venta);
    var
        nue:t_arbol;
    begin
        if arbol=nil then begin
            new(nue);
            nue^.cod_prod:=venta.cod_prod;
            nue^.cant_tot:=1;
            nue^.monto:=venta.precio;
            nue^.hi:=nil;
            nue^.hd:=nil;
            arbol:=nue;
            end
        else if arbol^.cod_prod=venta.cod_prod then begin
            arbol^.cant_tot:=arbol^.cant_tot+1;
            arbol^.monto:=arbol^.monto+venta.precio;
            end
            else if arbol^.cod_prod<venta.cod_prod then begin
                ing_arbol(arbol^.hd,venta);
                end
                else begin
                ing_arbol(arbol^.hi,venta);
                end;
    end;

var
    venta:t_venta;
    id_ventas:integer;
begin
    id_ventas:=0;
    leer_venta(venta,id_ventas);
    while venta.cod_vent<>-1 do begin
        ing_arbol(arbol,venta);
        leer_venta(venta,id_ventas);
        end;
end;
procedure imp_arbol(arbol:t_arbol);

begin
    if arbol<>nil then begin
        imp_arbol(arbol^.hi);
        writeln('Codigo de producto: ',arbol^.cod_prod,'    Cantidad total: ',arbol^.cant_tot,'  Monto :$',arbol^.monto);
        imp_arbol(arbol^.hd);
        end;
end;

procedure recorrer_arbol(arbol:t_arbol);
    procedure mayor_prod(arbol:t_arbol;var max_cod:integer;var max_cant:integer);
    var
        aux:integer;
    begin
        if arbol<>nil then begin
            if arbol^.cant_tot>=max_cant then begin
                max_cant:=arbol^.cant_tot;
                max_cod:=arbol^.cod_prod;
            end;
            mayor_prod(arbol^.hi,max_cod,max_cant);
            mayor_prod(arbol^.hd,max_cod,max_cant);
        end;
    end;
    procedure cuantos_men(arbol:t_arbol;var cuantos:integer;menor_a:integer);

    begin
        if arbol<>nil then begin
            cuantos_men(arbol^.hi,cuantos,menor_a);
            cuantos_men(arbol^.hd,cuantos,menor_a);
            if arbol^.cod_prod<menor_a then begin
                cuantos:=cuantos+1;
            end;
        end;

    end;


var
    max_cod:integer;
    max_cant:integer;
    cuantos:integer;
    menor_a:integer;
begin
    max_cant:=0;
    cuantos:=0;
    mayor_prod(arbol,max_cod,max_cant);
    writeln('Codigo de producto con mayor cant de ventas: ',max_cod,'   | Cantidad: ',max_cant);
    writeln('Buscar cantidad de productos con codigo menor a: ');
    readln(menor_a);
    cuantos_men(arbol,cuantos,menor_a);
    writeln('Cantidad de productos con codigo menor a ',menor_a,': ',cuantos);
end;
procedure monto_entre(arbol:t_arbol);
    function dev_total(arbol:t_arbol;bajo,alto:integer):int64;
    var
        aux:integer;
    begin
        if arbol=nil then begin 
            dev_total:=0;
        end
        else  begin
            if arbol^.cod_prod>bajo then begin
                if arbol^.cod_prod<alto then begin
                    dev_total:=arbol^.monto+dev_total(arbol^.hi,bajo,alto)+dev_total(arbol^.hd,bajo,alto);
                end
                else begin
                    dev_total:=dev_total(arbol^.hi,bajo,alto);
                end;
            end
            else begin
                dev_total:=dev_total(arbol^.hd,bajo,alto);
            end;
         end;

    end;
var
    monto_total:int64;
    bajo,alto:integer;
begin
    monto_total:=0;
    writeln('Desde :');
    readln(bajo);
    writeln(' Hasta:');
    readln(alto);
    monto_total:=dev_total(arbol,bajo,alto);
    writeln('Monto entre ',bajo,' y ',alto,' :',monto_total);
end;
var
    arbol:t_arbol;
begin
    randomize;
    arbol:=nil;
    generar_arbol(arbol);
    imp_arbol(arbol);
    recorrer_arbol(arbol);
    monto_entre(arbol);
end.