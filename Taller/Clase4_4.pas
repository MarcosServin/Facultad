program Clase4_4;

type
    t_dia=1..31;
    t_mes=1..12;

    t_fecha=record
        dia:t_dia;
        mes:t_mes;
    end;

    t_prestamo=record
        isbn:integer;
        num_socio:integer;
        fecha:t_fecha;
        cant:integer;
    end;

    t_arbol1=^nodo_arbol1;
    nodo_arbol1=record
        isbn:integer;
        dato:t_prestamo;
        hi:t_arbol1;
        hd:t_arbol1;
    end;

    l_prestamos=^nodo_lpres;
    nodo_lpres=record
        dato:t_prestamo;
        sig:l_prestamos;
    end;

    t_arbol2=^nodo_arbol2;
    nodo_arbol2=record
        isbn:integer;
        lista:l_prestamos;
        hi:t_arbol2;
        hd:t_arbol2;
    end;

    t_nuearbol=^nodo_nuearbol;
    nodo_nuearbol=record
        isbn:integer;
        cantidad:integer;
        hi:t_nuearbol;
        hd:t_nuearbol;
        end;


procedure modulo_arboles(var arbol1:t_arbol1;var arbol2:t_arbol2);
    procedure dev_prestamo(var elem:t_prestamo);
    begin
        elem.isbn:=random(50);
        elem.num_socio:=random(100)+1;
        elem.fecha.dia:=random(31)+1;
        elem.fecha.mes:=random(12)+1;
        elem.cant:=random(50);
    end;

    procedure dev_arbol1(var arbol:t_arbol1;elem:t_prestamo);
    var
        nue_arb:t_arbol1;
    begin
        if arbol=nil then begin
            new(nue_arb);
            nue_arb^.isbn:=elem.isbn;
            nue_arb^.dato:=elem;
            nue_arb^.hi:=nil;
            nue_arb^.hd:=nil;
            arbol:=nue_arb;
        end
        else if arbol^.isbn>elem.isbn then begin
            dev_arbol1(arbol^.hi,elem);
        end
        else begin
            dev_arbol1(arbol^.hd,elem);
        end;
    end;

    procedure dev_arbol2(var arbol:t_arbol2;elem:t_prestamo);
    var
        nue_arb:t_arbol2;
        nue_lis:l_prestamos;
        aux:l_prestamos;
    begin
        if arbol = nil then begin
            new(nue_arb);
            nue_arb^.isbn:=elem.isbn;
            new(nue_lis);
            nue_lis^.dato:=elem;
            nue_lis^.sig:=nil;
            nue_arb^.lista:=nue_lis;
            nue_arb^.hi:=nil;
            nue_arb^.hd:=nil;
            arbol:=nue_arb;
        end
        else begin
            if arbol^.isbn=elem.isbn then begin
                aux:=arbol^.lista;
                while aux^.sig<>nil do
                    aux:=aux^.sig;
                new(nue_lis);
                nue_lis^.dato:=elem;
                nue_lis^.sig:=nil;
                aux^.sig:=nue_lis;
            end
            else if arbol^.isbn<elem.isbn then begin
                    dev_arbol2(arbol^.hd,elem);
                end
                else begin
                    dev_arbol2(arbol^.hi,elem);
                end;
            end;
    end;

var
    info: t_prestamo;
begin
    dev_prestamo(info);
    while info.isbn <> 0 do
    begin
        dev_arbol1(arbol1,info);
        dev_arbol2(arbol2,info);
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

procedure imp_arbol2(arbol:t_arbol2);

begin
	if arbol<>nil then begin
		imp_arbol2(arbol^.hi);
        writeln(arbol^.isbn);
		imp_arbol2(arbol^.hd);
	end;
end;

function    cant_prestamos_socio(arbol:t_arbol1;socio:integer):integer;
begin
    if arbol=nil then begin
        cant_prestamos_socio:=0;
    end
    else begin
        if arbol^.dato.num_socio=socio then begin
            cant_prestamos_socio:=1+cant_prestamos_socio(arbol^.hi,socio)+cant_prestamos_socio(arbol^.hd,socio);
        end
        else begin
            cant_prestamos_socio:=0+cant_prestamos_socio(arbol^.hi,socio)+cant_prestamos_socio(arbol^.hd,socio);
        end;
    end;
end;

function cant_prestamos_socios_lista(arbol:t_arbol2;socio:integer):integer;
var
    cantidad:integer;
    aux:l_prestamos;
begin
    if arbol=nil then begin
        cant_prestamos_socios_lista:=0;
    end
    else begin
        cantidad:=0;
        aux:=arbol^.lista;
        while aux<>nil do begin
            if aux^.dato.num_socio = socio then begin
                cantidad:=cantidad+1;
            end;
            aux:=aux^.sig;
        end;
        cant_prestamos_socios_lista:=cantidad+cant_prestamos_socios_lista(arbol^.hi,socio)+cant_prestamos_socios_lista(arbol^.hd,socio);
    end;
end;
 
procedure dev_nue_arbol(arb_viejo:t_arbol1;var arb_nuevo:t_nuearbol);
    procedure recorrer_nuevo(viejo:t_arbol1;var nuevo:t_nuearbol);

    begin
        if nuevo=nil then begin
            new(nuevo);
            nuevo^.cantidad:=1;
            nuevo^.isbn:=viejo^.isbn;
            nuevo^.hi:=nil;
            nuevo^.hd:=nil;
        end
        else if nuevo^.isbn=viejo^.isbn then begin
            nuevo^.cantidad:=nuevo^.cantidad+1;
            end
            else if viejo^.isbn<nuevo^.isbn then begin
                recorrer_nuevo(viejo,nuevo^.hi);
                end
                else begin
                    recorrer_nuevo(viejo,nuevo^.hd);
                end;
            
    end;

begin
    //recibe arbol1 (si nodos tienen el mismo codigo ,se añade como hijo derecho)y devuelve arbol2 (cada nodo tiene el codigo y la cantidad de veces que se agrego en el arbol 1)
    if arb_viejo<>nil then begin
        recorrer_nuevo(arb_viejo,arb_nuevo);

        dev_nue_arbol(arb_viejo^.hi,arb_nuevo);

        dev_nue_arbol(arb_viejo^.hd,arb_nuevo);

    end

end;

procedure imp_nuevoArbol(arbol:t_nuearbol);

begin
    if arbol<>nil then begin
        imp_nuevoArbol(arbol^.hi);
        writeln();
        write('ISBN: ',arbol^.isbn); 
        if arbol^.isbn<=9 then begin
            write('  | Cantidad de prestamos: ',arbol^.cantidad);
            end
        else begin
            write(' | Cantidad de prestamos: ',arbol^.cantidad);
            end;
        writeln();
        imp_nuevoArbol(arbol^.hd);
    end;    
end;

procedure dev_nue_arbol2(viejo:t_arbol2;var nuevo:t_nuearbol);
    procedure insa_arb_nue(viejo:t_arbol2;var nuevo:t_nuearbol);
    var
        aux:l_prestamos;
    begin
        if nuevo=nil then begin
            new(nuevo);
            nuevo^.isbn:=viejo^.isbn;
            nuevo^.cantidad:=1;
            nuevo^.hi:=nil;
            nuevo^.hd:=nil;
        end
        else begin
            if nuevo^.isbn=viejo^.isbn then begin
                aux:=viejo^.lista ;
                while aux <> nil do begin
                    nuevo^.cantidad:=nuevo^.cantidad+1;
                    aux:=aux^.sig;
                end;
            end
            else begin
                if nuevo^.isbn>viejo^.isbn then begin
                    insa_arb_nue(viejo,nuevo^.hi);
                end
                else begin
                    insa_arb_nue(viejo,nuevo^.hd);
                end;
            end;
        end;
    end;

begin
    if viejo<>nil then begin
        insa_arb_nue(viejo,nuevo);
        dev_nue_arbol2(viejo^.hi,nuevo);
        dev_nue_arbol2(viejo^.hd,nuevo);
    end;

end;
function recu_prest_entre(bajo,alto:integer;arbol:t_nuearbol):integer;
var 
    cuantos:integer;
begin
    if arbol=nil then begin
        recu_prest_entre:=0;
    end
    else begin
        if arbol^.isbn>=bajo then begin
            recu_prest_entre:=arbol^.cantidad+recu_prest_entre(bajo,alto,arbol^.hd);
        end
        else if arbol^.isbn<=alto then begin
            recu_prest_entre:=arbol^.cantidad+recu_prest_entre(bajo,alto,arbol^.hi);
        end
    end;
end;

var
    arbol1:t_arbol1;
    arbol2:t_arbol2;
    num_impr:integer;
    nro_socio:integer;
    nue_arbol:t_nuearbol;
    nue_arbol2:t_nuearbol;
    bajo:integer;
    alto:integer;

begin
	Randomize;
    arbol1:=nil;
    arbol2:=nil;
    modulo_arboles(arbol1,arbol2);
    writeln('Arbol nro 1:');
    imp_arbol(arbol1);
    writeln('Arbol nro 2:');
    imp_arbol2(arbol2);
    num_impr:= mayor_isbn(arbol1);
    writeln('Mayor ISBN en arbol nro 1: ',num_impr);
    num_impr:=menor_isbn(arbol2);
    writeln('Menor ISBN en arbol nro 2: ',num_impr);
    writeln('Ingrese numero de socio: ');
    readln(nro_socio);
    num_impr:=cant_prestamos_socio(arbol1,nro_socio);
    writeln(num_impr);
    num_impr:=cant_prestamos_socios_lista(arbol2,nro_socio);
    writeln(num_impr);
    nue_arbol:=nil;
    dev_nue_arbol(arbol1,nue_arbol);
    imp_nuevoArbol(nue_arbol);
    nue_arbol2:=nil;
    dev_nue_arbol2(arbol2,nue_arbol2);
    imp_nuevoArbol(nue_arbol2);
    writeln('Buscar prestamos desde ISBM : ');
    readln(bajo);
    writeln('Hasta: ');
    readln(alto);
    num_impr:=recu_prest_entre(bajo,alto,nue_arbol2);
    writeln('Desde ISBM ',bajo,' hasta ',alto,' hubo ',num_impr,' prestamos.');

end.