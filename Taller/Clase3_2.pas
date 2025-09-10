program Clase3_2;

type

	t_anio=2020..2025;
	t_mes=1..12;
	t_dia=1..31;
	t_cod=0..100;
	t_cant=0..1000;

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
		cant:t_cant;
		end;
	arbol_2=^nodo_2;
	nodo_2=record
		dato:venta_2;
		hi:arbol_2;
		hd:arbol_2;
		end;



procedure gen_ventas(var punt_list:lista_org);
	procedure tomar_datos(var reg:venta_1);
	begin
		reg.cod:=random(100+1);
		reg.fecha.dia:=random(31)+1;
		reg.fecha.mes:=random(12)+1;
		reg.fecha.anio:=random(5+1)+2020;
		reg.cant:=random(1000+1);
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
procedure gen_arboles(lista:lista_org;var p_arbol1:arbol_1;var p_arbol2:arbol_2);//;var p_arbol3:arbol_3
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
					ins_arbol2(elem,p_arbol2^.hd);
				end
				else begin
					p_arbol2^.dato.cant:=p_arbol2^.dato.cant+elem.cant
				end;
	end;
begin
	p_arbol1:=nil;
	while lista<>nil do
		begin
			ins_arbol1(lista^.dato,p_arbol1);
			ins_arbol2(lista^.dato,p_arbol2);
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
procedure recorrer_arb2(p_arbol2:arbol_2);
var 
	max_cod:t_cod;
	max_cant:t_cant;
begin

end;

var
	l_ventas:lista_org;
	p_arbol1:arbol_1;
	p_arbol2:arbol_2;
	//p_arbol3:arbol_3;

begin
	randomize;
	l_ventas:=nil;
	gen_ventas(l_ventas);
	imp_lista(l_ventas);
	gen_arboles(l_ventas,p_arbol1,p_arbol2);
	writeln('Arbol n°1:');
	imp_arbol1(p_arbol1);
	writeln('Arbol n°2:');
	imp_arbol2(p_arbol2);
	
end.