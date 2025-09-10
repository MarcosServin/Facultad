program Clase3_2;

type

	t_anio=2020..2025;
	t_mes=1..12;
	t_dia=1..31;
	t_cod=0..100;
	t_cant=0..1000;
	t_cant2=integer;

	t_fecha=record
		dia:t_dia;
		mes:t_mes;
		anio:t_anio;
		end;

	venta_1=record
		cod:t_cod;
		fecha:t_fecha;
		cant:t_cant;
		end;

	arbol_1=^nodo_1;

	nodo_1=record
		dato:venta_1;
		hi:arbol_1;
		hd:arbol_1;
		end;

	lista_org=^nodo;
	nodo=record
		dato:venta_1;
		sig:lista_org;
		end;


	venta_2=record
		cod:t_cod;
		cant:t_cant2;
		end;
	arbol_2=^nodo_2;
	nodo_2=record
		dato:venta_2;
		hi:arbol_2;
		hd:arbol_2;
		end;

	dato_3=record
		fecha:t_fecha;
		cant:t_cant2;
		end;
	lista_3=^nodo_lista3;
	nodo_lista3=record
		dato:dato_3;
		sig:lista_3;
		end;

	arbol_3=^nodo_3;
	nodo_3=record
		dato:t_cod;
		lista:lista_3;
		hi:arbol_3;
		hd:arbol_3
		end;

procedure gen_ventas(var punt_list:lista_org);
	procedure tomar_datos(var reg:venta_1);
	begin
		reg.cod:=random(100+1);
		reg.fecha.dia:=random(31)+1;
		reg.fecha.mes:=random(12)+1;
		reg.fecha.anio:=random(5+1)+2020;
		reg.cant:=random(1000)+1;
	end;

var
	reg_ven:venta_1;
	p_lista:lista_org;
begin
	p_lista:=nil;
	tomar_datos(reg_ven);
	while reg_ven.cod<>0 do
		begin
			new(p_lista);
			p_lista^.dato:=reg_ven;
			p_lista^.sig:=punt_list;
			punt_list:=p_lista;
			tomar_datos(reg_ven);
		end;
end;
procedure imp_lista(puntero:lista_org);
begin
	while puntero<>nil do
			begin
				writeln('Codigo: ',puntero^.dato.cod,'	|Fecha: ',puntero^.dato.fecha.dia,'/',puntero^.dato.fecha.mes,'/',puntero^.dato.fecha.anio,'	|Cantidad:',puntero^.dato.cant);
				puntero:=puntero^.sig;
			end;
end;
procedure gen_arboles(lista:lista_org;var p_arbol1:arbol_1;var p_arbol2:arbol_2;var p_arbol3:arbol_3);//
	procedure ins_arbol1(elem:venta_1;var p_arbol1:arbol_1);
	var
		nue:arbol_1;
	begin
		if p_arbol1=nil then
			begin
				new(nue);
				nue^.dato:=elem;
				nue^.hi:=nil;
				nue^.hd:=nil;
				p_arbol1:=nue;
			end
		else if p_arbol1^.dato.cod < elem.cod then
			begin
				ins_arbol1(elem,p_arbol1^.hd);
			end
			else begin
				ins_arbol1(elem,p_arbol1^.hi);
			end;
	end;

	procedure ins_arbol2(elem:venta_1;var p_arbol2:arbol_2);
	var
		nue:arbol_2;
	begin
		if p_arbol2=nil then
			begin
				new(nue);
				nue^.dato.cod:=elem.cod;
				nue^.dato.cant:=elem.cant;
				nue^.hi:=nil;
				nue^.hd:=nil;
				p_arbol2:=nue;
			end
		else if p_arbol2^.dato.cod<elem.cod then
			begin
				ins_arbol2(elem,p_arbol2^.hd);
			end
			else if p_arbol2^.dato.cod>elem.cod then
				begin
					ins_arbol2(elem,p_arbol2^.hi);
				end
				else begin
					p_arbol2^.dato.cant:=p_arbol2^.dato.cant+elem.cant;
				end;
	end;
	procedure ins_arbol3(elem:venta_1;var p_arbol3:arbol_3);
	var
		nue:arbol_3;
		lis_nue:lista_3;
		aux:lista_3;
	begin
		if p_arbol3=nil then
			begin
				new(nue);
				nue^.dato:=elem.cod;
				new(lis_nue);
				lis_nue^.dato.fecha:=elem.fecha;
				lis_nue^.dato.cant:=elem.cant;
				lis_nue^.sig:=nil;
				nue^.lista:=lis_nue;
				nue^.hi:=nil;
				nue^.hd:=nil;
				p_arbol3:=nue;
			end
		else if p_arbol3^.dato<elem.cod then
			begin
				ins_arbol3(elem,p_arbol3^.hd);
			end
			else if p_arbol3^.dato>elem.cod then
				begin
					ins_arbol3(elem,p_arbol3^.hi);
				end
				else begin
					aux:=p_arbol3^.lista;
					while aux^.sig<> nil do begin
						aux:=aux^.sig;
						end;
					new(lis_nue);
					lis_nue^.dato.fecha:=elem.fecha;
					lis_nue^.dato.cant:=elem.cant;
					lis_nue^.sig:=nil;
					aux^.sig:=lis_nue;
				end;
	end;
begin
	p_arbol1:=nil;
	p_arbol2:=nil;
	p_arbol3:=nil;
	while lista<>nil do
		begin
			writeln('Insertando ',lista^.dato.cod, ' en el Arbol 1.');
			ins_arbol1(lista^.dato,p_arbol1);
			writeln('Insertando ',lista^.dato.cod, ' en el Arbol 2.');
			ins_arbol2(lista^.dato,p_arbol2);
			writeln('Insertando ',lista^.dato.cod, ' en el Arbol 3.');
			ins_arbol3(lista^.dato,p_arbol3);
			lista:=lista^.sig;
		end;
end;
procedure imp_arbol1(p_arbol1:arbol_1);
begin
	if p_arbol1<>nil then
		begin
			imp_arbol1(p_arbol1^.hi);
			writeln(p_arbol1^.dato.cod,'	|',p_arbol1^.dato.cant);
			imp_arbol1(p_arbol1^.hd);
		end;
end;
procedure imp_arbol2(p_arbol2:arbol_2);
begin
	if p_arbol2<>nil then
		begin
			imp_arbol2(p_arbol2^.hi);
			writeln(p_arbol2^.dato.cod,'	|',p_arbol2^.dato.cant);
			imp_arbol2(p_arbol2^.hd);
		end;
end;
procedure imp_arbol3(p_arbol3:arbol_3);
var
	aux:lista_3;
begin
	aux:=nil;
	if p_arbol3<>nil then
		begin
			imp_arbol3(p_arbol3^.hi);
			aux:=p_arbol3^.lista;
			writeln('Codigo: ',p_arbol3^.dato);
			writeln();
			while aux<> nil do begin
				writeln('	Cantidad: ',aux^.dato.cant,' | Fecha: ',aux^.dato.fecha.dia,'/',aux^.dato.fecha.mes,'/',aux^.dato.fecha.anio);
				aux:=aux^.sig;
				end;
			imp_arbol3(p_arbol3^.hd);
		end;
end;
procedure maximo_arb2(p_arbol2:arbol_2);
	procedure recorrer_arb2(var max_cod:t_cod;var max_cant:t_cant2;p_arbol2:arbol_2);
	begin
		if p_arbol2<>nil then
			begin
				if p_arbol2^.dato.cant>=max_cant then
					begin
						max_cod:=p_arbol2^.dato.cod;
						max_cant:=p_arbol2^.dato.cant;
					end;
				recorrer_arb2(max_cod,max_cant,p_arbol2^.hi);
				recorrer_arb2(max_cod,max_cant,p_arbol2^.hd);
			end;

	end;
var 
	max_cod:t_cod;
	max_cant:t_cant;
begin
	max_cant:=0;
	max_cod:=0;
	recorrer_arb2(max_cod,max_cant,p_arbol2);
	writeln('Cod:',max_cod,'	|Cantidad:',max_cant);
end;

var
	l_ventas:lista_org;
	p_arbol1:arbol_1;
	p_arbol2:arbol_2;
	p_arbol3:arbol_3;

begin
	randomize;
	l_ventas:=nil;
	gen_ventas(l_ventas);
	imp_lista(l_ventas);
	writeln('Generar Arboles:');
	gen_arboles(l_ventas,p_arbol1,p_arbol2,p_arbol3);
	writeln('Arbol Nro 1:');
	imp_arbol1(p_arbol1);
	writeln('Arbol Nro 2:');
	imp_arbol2(p_arbol2);
	maximo_arb2(p_arbol2);
	writeln('Arbol nro 3');
	imp_arbol3(p_arbol3);
	
end.