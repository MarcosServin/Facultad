program Clase3_3;

type
    t_dia=[1..31] of 1..31;
    t_mes=[1..12] of 1..12;
    t_fecha=record
        dia:t_dia;
        mes:t_mes;
        end;
    final=record 
        legajo:integer;
        codigo:integer;
        fecha:string;
        nota:real;
        end;

    l_finales=^nodo;
    nodo=record;
        dato:final;
        sig:l_finales;
        end;

    arbol_f:=^alumno;
    alumno=record
        legajo:integer;
        finales:l_finales;
        hi:arbol_f;
        hd:arbol_f;
        end;

procedure arbol_legajos(var alumnos:arbol_f);
    procedure datos_examen(var examen:final );
    begin
        examen.legajo:=random(100);
        examen.codigo:=random(1000);
        examen.fecha.dia:=random(31)+1;
        examen.fecha.mes:=random(12)+1;
        examen.nota:=random(10.00+1);
        end;
    procedure gen_arbol1(examen:final;var alumnos:arbol_f);
    var 
        nue:arbol_f

    begin
        if arbol_f=nil then begin
            a
        end;
    end;

var
    alumnos:arbol_f;
    examen:final;
begin
    alumnos:=nil;
    datos_examen(examen)//a)
    if examen.nota<>0.00 then begin
        gen_arbol1(examen,alumnos);
        end;



end.