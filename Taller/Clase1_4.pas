program libreria;

type
    rango_r=1..6;
    producto= record
        co_prod:integer;
        co_rubr:rango_r
        precio:real;
        end;
    
    lista=^nodo;
    nodo=record
        dato:producto;
        sig:lista;
        end;
    vec_prod=array [rango_r] of lista;

    ran_vei=1..20;
    ran_ext=1..30;
    v_rub=array [ran_vei] of producto:
    v_rub2=array [ran_ext] of producto;

var
    v:vec_prod;
    v_rub:vec_rub;
    v_rub2:vec_ext;
begin
    inicializar_vec(v);
    procesar_info(v);
    imprimir_cod(v);
    generar_vec(v,v_rub,v_rub2);


end;