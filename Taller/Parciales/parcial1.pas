program MarcoServin;
{supermercado GranVariedad}
const
    dimF=10;
type
    r_numSucursal=1..dimF;
    t_venta=record
        dni_cliente:integer;
        cod_factura:integer;
        num_sucursal:r_numSucursal;
        monto:real;
    end;

    t_datoLista=record
        cod_factura:integer;
        monto:real;
        end;

    l_ventas=^nodo_lista;
    nodo_lista=record
        dato:t_datoLista;
        sig:l_ventas;
        end;

    t_arbol=^nodo_arbol;
    nodo_arbol=record
        dni_cliente:integer;
        lista:l_ventas;
        izq:t_arbol;
        der:t_arbol;
        end;

    v_ventasSucursal=array[r_numSucursal] of integer;

//modulo que lea ventas
// 1 retorne un arbol ordenado por dni ,cada dni tiene una lista con todas las compras;registro nuevo -> monto & cod factura
// 2 una estructura que tenga la cantidad de ventas de cada sucursal;Vector?

procedure armar_estructuras(var arbol:t_arbol;var vector:v_ventasSucursal);
    procedure leer_venta(var venta:t_venta);
    begin
        writeln('Ingrese DNI: ');
        //readln(venta.dni_cliente);
        venta.dni_cliente:=random(500);
        if venta.dni_cliente <> 0 then begin 
            //writeln(venta.dni_cliente);
            //writeln('Ingrese el Codigo de Factura: ');
            //readln(venta.cod_factura);
            venta.cod_factura:=random(1000)+1;
            //writeln(venta.cod_factura);
            //writeln('Ingrese el Numero de la sucursal: ');
            //readln(venta.num_sucursal);
            venta.num_sucursal:=random(dimF)+1;
            //writeln(venta.num_sucursal);
            //writeln('Ingrese el monto: ');
            //readln(venta.monto);
            venta.monto:=random(100000)+random;
            //writeln(venta.monto);
            end;
    end;

    procedure insertar_arbol(var arbol:t_arbol;venta:t_venta);
    var
        nue:t_arbol;
        nue_lis:l_ventas;
        l_aux:l_ventas;
    begin
        if arbol=nil then begin
            new(nue);
            nue^.dni_cliente:=venta.dni_cliente;
            new(nue_lis);
            nue_lis^.dato.cod_factura:=venta.cod_factura;
            nue_lis^.dato.monto:=venta.monto;
            nue_lis^.sig:=nil;
            nue^.lista:=nue_lis;
            nue^.izq:=nil;
            nue^.der :=nil;
            arbol:=nue;
            end
        else begin
            if arbol^.dni_cliente=venta.dni_cliente then begin
                l_aux:=arbol^.lista;
                while l_aux^.sig<>nil do begin
                    l_aux:=l_aux^.sig;
                    end;
                new(nue_lis);
                nue_lis^.dato.cod_factura:=venta.cod_factura;
                nue_lis^.dato.monto:=venta.monto;
                nue_lis^.sig:=nil;
                l_aux^.sig:=nue_lis;
            end
            else begin
                if arbol^.dni_cliente > venta.dni_cliente then begin
                    insertar_arbol(arbol^.izq,venta);
                end
                else begin
                    insertar_arbol(arbol^.der,venta);
                end;
            end;
        end;
    end;
    procedure inicializar_vector(var vector:v_ventasSucursal);
    var
        i:integer;
    begin
        for i:=1 to dimF do begin
            vector[i]:=0;
        end;
    end;
    procedure insertar_vector(var vector:v_ventasSucursal;venta:t_venta);
    begin
        vector[venta.num_sucursal]:=vector[venta.num_sucursal]+1;
    end;
var 
    venta:t_venta;
begin
    arbol:=nil;
    inicializar_vector(vector);
    leer_venta(venta);
    while venta.dni_cliente<>0 do begin
        insertar_arbol(arbol,venta);
        insertar_vector(vector,venta);
        leer_venta(venta);
    end;
end;
function cant_facturas(arbol:t_arbol;cliente:integer;piso:real):integer;
var
    cant:integer;
    aux:l_ventas;
begin
    if arbol<>nil then begin
        if arbol^.dni_cliente=cliente then begin
            cant:=0;
            aux:=arbol^.lista;
            while aux<>nil do begin
                if aux^.dato.monto>piso then begin
                    cant:=cant+1;
                end;
                aux:=aux^.sig;
            end;
            cant_facturas:=cant;
        end
        else  begin
            if arbol^.dni_cliente<cliente then begin
                cant_facturas:=cant_facturas(arbol^.der,cliente,piso);
            end
            else begin
                cant_facturas:=cant_facturas(arbol^.izq,cliente,piso);
            end;
        end
    end
    else begin
        cant_facturas:=0;
    end;
end;
procedure imprimir_arbol(arbol:t_arbol);
var
    aux:l_ventas;
begin
    if arbol<>nil then begin
        imprimir_arbol(arbol^.izq);
        aux:=arbol^.lista;
        writeln();
        write('Dni del Cliente : ',arbol^.dni_cliente);
        writeln();
        while aux<>nil do begin
            write('     | Codigo : ',aux^.dato.cod_factura,'    | Monto : ',aux^.dato.monto:10:2,'----');
            writeln();
            aux:=aux^.sig;
        end;
        imprimir_arbol(arbol^.der);
    end;

end;
function cant_ventas(vector:v_ventasSucursal;i:integer):integer;
var
    vector_max:r_numSucursal;
begin
    if i=1 then begin //caso base
        cant_ventas:=i;
    end
    else begin
        if i>1 then begin //i = 0 no entra
            vector_max:=cant_ventas(vector,i-1);
            if vector[i]>=vector[vector_max] then begin
                cant_ventas:=i;
            end
            else begin
                cant_ventas:=vector_max;
            end
        end
    end;
end;





procedure imprimir_vector(vector:v_ventasSucursal);
var
    i:integer;
begin
    for i:=1 to dimF do  begin
        writeln('Numero de sucursal : ',i,' Cantidad de ventas : ',vector[i]);
    end;
end;
var
    estr_arbol:t_arbol;
    estr_vector:v_ventasSucursal;
    cliente:integer;
    piso:real;
    cantidad_mayor:integer;
    i:integer;
    sucursal_mayor:integer;
begin
    Randomize;
    armar_estructuras(estr_arbol,estr_vector);
    imprimir_arbol(estr_arbol);
    //modulo que reciva el arbol un dni y un monto y devuelva la cantidad de de ventas con ese dni que superan el monto
    writeln('Ingrese el monto minimo: ');readln(piso);
    writeln('Ingrese el dni del cliente: ');readln(cliente);
    cantidad_mayor:=cant_facturas(estr_arbol,cliente,piso);
    writeln(cantidad_mayor);
    i:=dimF;
    sucursal_mayor:=cant_ventas(estr_vector,i);
    imprimir_vector(estr_vector);
    writeln('Numero de sucursal con la mayor cantidad de ventas: ',sucursal_mayor);

end.