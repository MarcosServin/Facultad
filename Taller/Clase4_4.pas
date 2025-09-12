program Clase4_4;

type
    t_dia = 1..31;
    t_mes = 1..12;

    t_fecha = record
        dia: t_dia;
        mes: t_mes;
    end;

    t_prestamo = record
        isbn: integer;
        num_socio: integer;
        fecha: t_fecha;
        cant: integer;
    end;

    t_arbol1 = ^nodo_arbol1;
    nodo_arbol1 = record
        isbn: integer;
        dato: t_prestamo;
        hi: t_arbol1;
        hd: t_arbol1;
    end;

    l_prestamos = ^nodo_lpres;
    nodo_lpres = record
        dato: t_prestamo;
        sig: l_prestamos;
    end;

    t_arbol2 = ^nodo_arbol2;
    nodo_arbol2 = record
        isbn: integer;
        lista: l_prestamos;
        hi: t_arbol2;
        hd: t_arbol2;
    end;

procedure modulo_arboles(var arbol1: t_arbol1; var arbol2: t_arbol2);
    procedure dev_prestamo(var elem: t_prestamo);
    begin
        elem.isbn := random(5000);
        elem.num_socio := (1000);
        elem.fecha.dia := random(31) + 1;
        elem.fecha.mes := random(12) + 1;
        elem.cant := random(50);
    end;

    procedure dev_arbol1(var arbol: t_arbol1; elem: t_prestamo);
    var
        nue_arb: t_arbol1;
    begin
        if arbol = nil then
        begin
            new(nue_arb);
            nue_arb^.isbn := elem.isbn;
            nue_arb^.dato := elem;
            nue_arb^.hi := nil;
            nue_arb^.hd := nil;
            arbol := nue_arb;
        end
        else if arbol^.isbn > elem.isbn then
        begin
            dev_arbol1(arbol^.hi, elem);
        end
        else
        begin
            dev_arbol1(arbol^.hd, elem);
        end;
    end;

    procedure dev_arbol2(var arbol: t_arbol2; elem: t_prestamo);
    var
        nue_arb: t_arbol2;
        nue_lis: l_prestamos;
        aux: l_prestamos;
    begin
        if arbol = nil then
        begin
            new(nue_arb);
            nue_arb^.isbn := elem.isbn;
            new(nue_lis);
            nue_lis^.dato := elem;
            nue_lis^.sig := nil;
            nue_arb^.lista := nue_lis;
            nue_arb^.hi := nil;
            nue_arb^.hd := nil;
            arbol := nue_arb;
        end
        else
        begin
            if arbol^.isbn = elem.isbn then
            begin
                aux := arbol^.lista;
                while aux^.sig <> nil do
                    aux := aux^.sig;
                new(nue_lis);
                nue_lis^.dato := elem;
                nue_lis^.sig := nil;
                aux^.sig := nue_lis;
            end
            else
            begin
                if arbol^.isbn < elem.isbn then
                    dev_arbol2(arbol^.hd, elem)
                else
                    dev_arbol2(arbol^.hi, elem);
            end;
        end;
    end;

var
    info: t_prestamo;
begin
    dev_prestamo(info);
    while info.isbn <> 0 do
    begin
        dev_arbol1(arbol1, info);
        dev_arbol2(arbol2, info);
        dev_prestamo(info);
    end;
end;

procedure mayor_isbn(arbol:t_arbol);
    begin
    end;


var
    arbol1: t_arbol1;
    arbol2: t_arbol2;
    mayor: integer;
begin
    arbol1 := nil;
    arbol2 := nil;
    modulo_arboles(arbol1, arbol2);
    mayor:=mayor_isbn(arbol1);
    //imp_arbol();

end.
