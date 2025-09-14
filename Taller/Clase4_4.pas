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
        elem.isbn := random(100);
        elem.num_socio := random(1000);
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

function mayor_isbn(arbol:t_arbol1):integer;
var
    max_hd:integer;
begin

    if arbol=nil then begin
        mayor_isbn:=0;
        end
    else begin
        max_hd:=mayor_isbn(arbol^.hd);
        if arbol^.isbn<max_hd then begin
            mayor_isbn:=max_hd;
        end
        else begin
            mayor_isbn:=arbol^.isbn;
        end
    end;
end;

function menor_isbn(arbol:t_arbol2):integer;
var
    min_hi:integer;
begin

    if arbol=nil then begin
        menor_isbn:=5000;
        end
    else begin
        min_hi:=menor_isbn(arbol^.hi);
        if arbol^.isbn>min_hi then begin
            menor_isbn:=min_hi;
        end
        else begin
            menor_isbn:=arbol^.isbn;
        end
    end;
end;

procedure imp_arbol(arbol:t_arbol1);

begin
	if arbol<>nil then begin
		imp_arbol(arbol^.hi);
		if arbol^.isbn >9 then begin
			writeln('ISBN: ',arbol^.isbn,'	|Nro de Socio:',arbol^.dato.num_socio,'	|Fecha: ',arbol^.dato.fecha.dia,'/',arbol^.dato.fecha.mes,'	|Cantidad: ',arbol^.dato.cant);
			end
		else	begin
			writeln('ISBN: ',arbol^.isbn,'		|Nro de Socio:',arbol^.dato.num_socio,'	|Fecha: ',arbol^.dato.fecha.dia,'/',arbol^.dato.fecha.mes,'	|Cantidad: ',arbol^.dato.cant);
		
			end;
		imp_arbol(arbol^.hd);
	
	end;
end;
var
    arbol1: t_arbol1;
    arbol2: t_arbol2;
    num_impr: integer;
begin
	Randomize;
    arbol1 := nil;
    arbol2 := nil;
    modulo_arboles(arbol1, arbol2);
    imp_arbol(arbol1);
    num_impr:= mayor_isbn(arbol1);
    writeln('Mayor ISBN: ',num_impr);
    num_impr:=menor_isbn(arbol2);
    writeln('Menor ISBN: ',num_impr);


end.