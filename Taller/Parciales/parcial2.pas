program MarcosServin;

const
    dimF=10;

type
    t_cod=1..dimF;

    t_venta = record
        dni_cliente:integer;
        cod_sucursal:t_cod;
        num_factura:integer;
        monto:real;
    end;

    reg_comp=record
        num_factura:integer;
        monto:real;
        end;

    lis_vent=^nodo_lis;
    nodo_lis=record
        dato:reg_comp;
        sig:lis_vent;
        end;

    arb_dni=^nodo_arb;
    nodo_arb=record
        dni_cliente:integer;
        lista:lis_vent;
        hi:arb_dni;
        hd:arb_dni;
        end;

    vec_suc=array[t_cod]of integer;



procedure armar_estructuras(var arbol:arb_dni;var vector:vec_suc);
    procedure armar_venta(var venta:t_venta;var cont_facturas:integer);

    begin
        venta.dni_cliente:=random(100);
        if venta.dni_cliente<>0 then begin
            cont_facturas:=cont_facturas+1;
            venta.cod_sucursal:=random(dimF)+1;
            venta.num_factura:=cont_facturas;
            venta.monto:=random(10000)+random();
        end;
    end;

    procedure armar_arbol(var arbol:arb_dni;venta:t_venta);
    var
        nue:arb_dni;
        nue_lis:lis_vent;
        aux:lis_vent;
    begin
        if arbol=nil then begin
            writeln('Nuevo nodo en el arbol.');
            new(nue);
            nue^.dni_cliente:=venta.dni_cliente;
            new(nue_lis);
            nue_lis^.dato.num_factura:=venta.num_factura;
            nue_lis^.dato.monto:=venta.monto;
            nue_lis^.sig:=nil;
            nue^.lista:=nue_lis;
            nue^.hi:=nil;
            nue^.hd:=nil;
            arbol:=nue;
        end
        else begin
            if arbol^.dni_cliente=venta.dni_cliente then begin
                aux:=arbol^.lista; //Tdodo nodo inicializado tiene por lo menos una lista
                while aux^.sig<>nil do begin
                    aux:=aux^.sig;
                end;
                new(nue_lis);
                nue_lis^.dato.num_factura:=venta.num_factura;
                nue_lis^.dato.monto:=venta.monto;
                nue_lis^.sig:=nil;
                aux^.sig:=nue_lis;
            end
            else begin
                if arbol^.dni_cliente<venta.dni_cliente then begin
                    armar_arbol(arbol^.hd,venta);
                end
                else begin
                    armar_arbol(arbol^.hi,venta);
                end
            end
        end
    end;
    procedure inicializar_vector(var vector:vec_suc);
    var
        i:integer;
    begin
        for i:=1 to dimF do begin
            vector[i]:=0;
        end;
    end;

    procedure armar_vector(var vector:vec_suc;venta:t_venta);
    begin
        vector[venta.cod_sucursal]:=vector[venta.cod_sucursal]+1;
    end;

var
    venta:t_venta;
    cont_facturas:integer;
begin
    cont_facturas:=0;
    armar_venta(venta,cont_facturas);
    arbol:=nil;
    inicializar_vector(vector);
    while venta.dni_cliente<>0 do begin
        armar_arbol(arbol,venta);//a)i)
        armar_vector(vector,venta);//a)ii)
        armar_venta(venta,cont_facturas);
    end;
end;

procedure imprimir_arbol(arbol:arb_dni);
var
    aux:lis_vent;
begin
    if arbol<>nil then begin
        imprimir_arbol(arbol^.hi);
        writeln('DNI : ',arbol^.dni_cliente);
        aux:=arbol^.lista;
        while aux<>nil do begin
            writeln('   | Codigo de factura: ',aux^.dato.num_factura,' | Monto:',aux^.dato.monto:10:2);
            aux:=aux^.sig;
        end;
        imprimir_arbol(arbol^.hd);
    end;
end;
function facturas_menores(arbol:arb_dni;techo:integer;cliente:integer):integer;
var
    aux:lis_vent;
    cant_menor:integer;
begin
    if arbol<>nil then begin
        if arbol^.dni_cliente=cliente then begin
            aux:=arbol^.lista;
            cant_menor:=0;
            while aux<>nil do begin
                if aux^.dato.monto < techo then begin
                    cant_menor:=cant_menor+1;
                end;
                aux:=aux^.sig;
            end;
            facturas_menores:=cant_menor;
        end
        else begin
            if arbol^.dni_cliente < cliente then begin
                facturas_menores:=0+facturas_menores(arbol^.hd,techo,cliente);
            end
            else begin
                facturas_menores:=0+facturas_menores(arbol^.hi,techo,cliente);

            end
        end;
    end
    else begin
        facturas_menores:=0;
    end;
end;
function existe_sucursal(vector:vec_suc;cantidad:integer;dimL:integer):boolean;

begin
    if diml>1 then begin
        if vector[dimL]=cantidad then begin
            existe_sucursal:=True;
        end
        else 
            existe_sucursal:=existe_sucursal(vector,cantidad,dimL-1);
    end
    else begin
        if dimL=1 then begin
            if vector[dimL]=cantidad then begin
                existe_sucursal:=True;
            end
            else begin
                existe_sucursal:=False;
            end
        end
    end;
    


end;
var
    estr_arb:arb_dni;
    estr_vec:vec_suc;
    techo:integer;
    cliente:integer;
    indice:integer;
    cantidad_menores:integer;
    existe:boolean;
    numero_ventas:integer;
    dimL:integer;
begin
    armar_estructuras(estr_arb,estr_vec);//inciso a).
    imprimir_arbol(estr_arb);
    writeln('Ingrese monto maximo y el dni del cliente: ');
    readln(techo);
    readln(cliente);
    cantidad_menores:=facturas_menores(estr_arb,techo,cliente);
    writeln(cantidad_menores);
    writeln('Ingrese num de ventas: ');
    readln(numero_ventas);
    diml:=dimF;
    existe:=existe_sucursal(estr_vec,numero_ventas,dimL);
    writeln(existe);

end.