{Una biblioteca necesita un sistema para procesar la información de los libros. De cada libro se conoce: ISBN, código del autor y código de género (1 a 15).

	a) Implementar un módulo que lea información de los libros y retorne una estructura de datos eficiente para la búsqueda por código de autor que contenga código de autor y 
	una lista de todos sus libros. La lectura finaliza al ingresar el valor 0 para un ISBN. HECHO

	b) Realizar un módulo que reciba la estructura generada en el inciso a), un código de autor y un código de género. 
	El módulo debe retornar una lista con cada código de autor y cantidad de libros del código de género recibido, 
	tal que cada autor cuyo código sea superior al código de autor ingresado.

	c) Realizar un módulo recursivo que reciba la estructura generada en el inciso b) y retorne cantidad y código de autor con mayor cantidad de libros.}
program Biblioteca;
const
	DimF = 15;
type
	Rcod = 1..DimF;
	Tlibro = record
		ISBN : integer;
		codigo_autor : integer;
		codigo_genero : Rcod;
	end;
	Tlista = record
		ISBN : integer;
		codigo_genero : Rcod;
	end;
	ListaLibros = ^nodoL;
		nodoL = record
			dato : Tlista;
			sig : ListaLibros;
		end;
	Tarbol = record
		codigo_autor : integer;
		lista : ListaLibros;
	end;
	arbol = ^nodo;
		nodo = record
			dato : Tarbol;
			HI : arbol;
			HD : arbol;
		end;
	//PARA EL B
	Tgenero = record
		cant_libros : integer;
		codigo_autor : integer;
	end;
	ListaGenero = ^nodoG;
		nodoG = record
			dato : Tgenero;
			sig : ListaGenero;
		end;
			
	procedure LeerLibro (var l : Tlibro);
	begin
		l.ISBN := random(30);
		if(l.ISBN <> 0) then begin
			l.codigo_autor := random(30)+1;
			l.codigo_genero := random(15) + 1;
		end;
	end;
	procedure AgregarAdelante (var l : ListaLibros ; dato : Tlibro);
	var
		nue : ListaLibros;
	begin
		new(nue);
		nue^.dato.ISBN := dato.ISBN;
		nue^.dato.codigo_genero := dato.codigo_genero;
		nue^.sig := l;
		l := nue;
	end;
	procedure InsertarArbol (var a : arbol ; dato : Tlibro);
	var
		nue : arbol;
	begin
		if (a = nil) then begin
			new(nue);
			nue^.dato.codigo_autor := dato.codigo_autor;
			nue^.dato.lista := nil;
			AgregarAdelante(nue^.dato.lista, dato);
			nue^.HI := nil;
			nue^.HD := nil;
			a := nue;
		end
		else if (a^.dato.codigo_autor > dato.codigo_autor) then 
			InsertarArbol(a^.HI, dato)
		else if (a^.dato.codigo_autor < dato.codigo_autor) then 
			InsertarArbol(a^.HD, dato)
		else	
			AgregarAdelante(a^.dato.lista, dato);
	end;
	procedure CargarArbol (var a : arbol);
	var
		l : Tlibro;
	begin
		LeerLibro(l);
		while(l.ISBN <> 0) do begin
			InsertarArbol(a, l);
			LeerLibro(l);
		end;
	end;
	//~ Modulo B  Realizar un módulo que reciba la estructura generada en el inciso a), un código de autor y un código de género. 
	//~ El módulo debe retornar una lista con cada código de autor y cantidad de libros del código de género recibido, 
	//~ tal que cada autor cuyo código sea superior al código de autor ingresado.	
	procedure Agregar (var l : ListaGenero ; autor : integer ; cant : integer);
	var
		nue : ListaGenero;
	begin
		new(nue);
		nue^.dato.codigo_autor := autor;
		nue^.dato.cant_libros := cant;
		nue^.sig := l;
		l := nue;
	end;
	function ContarCantidad (l : ListaLibros ; Genero : Rcod): integer;
	var
		cant : integer;
	begin
		cant := 0;
		while(l <> nil) do begin
			if(l^.dato.codigo_genero = Genero) then 
				cant := cant + 1;
			l := l^.sig;
		end;
		ContarCantidad := cant;
	end;
	procedure ModuloB (a : arbol ; var l : ListaGenero ; codigoA : integer ; CodigoG : Rcod);
	var
		cant : integer;
	begin
		if(a <> nil) then begin
			ModuloB(a^.HI, l, codigoA, CodigoG);
			if(a^.dato.codigo_autor > codigoA) then begin
				cant := ContarCantidad(a^.dato.lista, CodigoG);
				if(cant > 0) then
					Agregar(l, a^.dato.codigo_autor, cant);
			end;
			
			ModuloB(a^.HD, l,  codigoA, CodigoG);
				
		end;
	end;
	procedure ImprimirListaGenero(l : ListaGenero);
	begin
	  while (l <> nil) do begin
		writeln('Autor: ', l^.dato.codigo_autor, '  Cantidad: ', l^.dato.cant_libros);
		l := l^.sig;
	  end;
	end;
	//~ Modulo C Realizar un módulo recursivo que reciba la estructura generada en el inciso b) y retorne cantidad y código de autor con mayor cantidad de libros.
	procedure MaxCantidad (l : ListaGenero ; var MaxCod, MaxCant : integer);
	begin
		if(l <> nil) then begin
			if (l^.dato.cant_libros > MaxCant) then begin
				MaxCant := l^.dato.cant_libros;
				MaxCod := l^.dato.codigo_autor;
			end;
			MaxCantidad(l^.sig, MaxCod, MaxCant);
		end;
	end;
var
	a : arbol ; l : ListaGenero; autor : integer ; genero : Rcod;  MaxCod, MaxCant : integer;
begin
	randomize;
	a := nil;
	l := nil;
	CargarArbol(a);
	writeln('Ingrese un codigo de autor: ');
	readln(autor);
	writeln('Ingrese un codigo de genero: ');
	readln(genero);
	ModuloB(a, l, autor, genero);
	ImprimirListaGenero(l);
	MaxCod := -1;
	MaxCant := -1;
	MaxCantidad(l, MaxCod, MaxCant);
	 if (maxCod <> -1) then
		writeln('El autor con mas libros es ', maxCod, ' con ', maxCant, ' libros.')
	else
		writeln('La lista esta vacia.');
end.
