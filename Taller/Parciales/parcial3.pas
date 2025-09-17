program MarcosServin;

type

    t_dia=1..31;
    t_mes=1..12;

    t_compra=record
        cod_producto:integer;
        cod_cliente:integer;
        dia:t_dia;
        mes:t_mes;
        end;

    dato_compra=record
        cod_cliente:integer;
        dia:t_dia;
        end;

    lista_compra=^nodo_lista;
    nodo_lista=record
        dato:dato_compra;
        sig:lista_compra;
        end;

    arbol_prod=^nodo_arbol;
    nodo_arbol=record
        cod_producto:integer;
        lista:lista_compra;
        izq:arbol_prod;
        der:arbol_prod;    
        end;    
    vector_meses=array [1..12] of arbol_prod;


procedure armar_estructuras(var vector:vector_meses);
    procedure inicializar_vector(var vector:vector_meses);
    var
        i:integer;
    begin
        for i:=1 to 12 do begin
            vector[i]:=nil;
        end;
    end;

    procedure leer_compra(var compra:t_compra);

    begin
        compra.cod_cliente:=random(2000);
        if compra.cod_cliente <>0 then begin
            compra.cod_producto:=random(100);
            compra.mes:=random(12)+1;
            if (compra.mes = 1) or (compra.mes =  3)or (compra.mes =5 )or (compra.mes =7 )or (compra.mes =8) or (compra.mes =10)
                 or (compra.mes =12 ) then begin
                compra.dia:=random(31)+1;
            end
            else begin
                if (compra.mes = 4)  or (compra.mes =6) or (compra.mes =9) or (compra.mes =11 ) then begin
                    compra.dia:=random(31)+1;
                end
                else
                    compra.dia:=random(28)+1;
            end;
        end;
    end;

    procedure insertar_arbol(var arbol:arbol_prod;compra:t_compra);
    var
        nue:arbol_prod;
        nue_lista:lista_compra;
        aux:lista_compra;
    begin
        if arbol=nil then begin
            new(nue);
            new(nue_lista);

            nue^.cod_producto:=compra.cod_producto;
            nue^.izq:=nil;
            nue^.der:=nil;

            nue_lista^.dato.dia:=compra.dia;
            nue_lista^.dato.cod_cliente:=compra.cod_cliente;
            nue_lista^.sig:=nil;
            nue^.lista:=nue_lista;
            arbol:=nue;
        end
        else begin
            if arbol^.cod_producto=compra.cod_producto then begin
                aux:=arbol^.lista;
                while aux^.sig<>nil do begin
                    aux:=aux^.sig;
                end;
                new(nue_lista);
                nue_lista^.dato.dia:=compra.dia;
                nue_lista^.dato.cod_cliente:=compra.cod_cliente;
                nue_lista^.sig:=nil;
                aux^.sig:=nue_lista;
            end
            else begin
                if arbol^.cod_producto<compra.cod_producto then begin
                    insertar_arbol(arbol^.der,compra);
                end
                else begin
                    insertar_arbol(arbol^.izq,compra);
                end
            end
        end;
    end;
    

var
    compra:t_compra;
begin
    inicializar_vector(vector);
    leer_compra(compra);
    while compra.cod_cliente<>0 do begin
        insertar_arbol(vector[compra.mes],compra);
    end;
end;

var
    estr_vector:vector_meses;
begin
    armar_estructuras(estr_vector);
end.