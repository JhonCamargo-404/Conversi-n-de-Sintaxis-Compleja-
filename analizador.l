%{
#include <stdio.h>
#include <string.h>

FILE *archivo_salida;
%}

%%

"+"                { fprintf(archivo_salida, "sumar"); }
"-"                { fprintf(archivo_salida, "restar"); }
"*"                { fprintf(archivo_salida, "multiplicar"); }
"/"                { fprintf(archivo_salida, "dividir"); }

"if"               { fprintf(archivo_salida, "condicional_si "); }
"for"              { fprintf(archivo_salida, "ciclo_para "); }

"print"            { fprintf(archivo_salida, "imprimir"); }
"input"            { fprintf(archivo_salida, "leer"); }

"("                { fputc('(', archivo_salida); }
")"                { fputc(')', archivo_salida); }
"{"                { fputc('{', archivo_salida); }
"}"                { fputc('}', archivo_salida); }

"=="               { fprintf(archivo_salida, "igual"); }
">"                { fprintf(archivo_salida, "mayor"); }
"<"                { fprintf(archivo_salida, "menor"); }
"&&"               { fprintf(archivo_salida, "y"); }
"||"               { fprintf(archivo_salida, "o"); }
"!"                { fprintf(archivo_salida, "no"); }

"="                { fprintf(archivo_salida, "igual"); }  
";"                { fputc(';', archivo_salida); } 

[0-9]+             { fprintf(archivo_salida, "%s", yytext); }  
[a-zA-Z_][a-zA-Z0-9_]*  { fprintf(archivo_salida, "%s", yytext); }  

\"[^\"\\]*\"       { fprintf(archivo_salida, "\"%s\"", yytext); }  

[ \t]+             { fputc(' ', archivo_salida); } 

\n                 { fputc('\n', archivo_salida); }  

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s archivo_entrada\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (archivo == NULL) {
        perror("No se pudo abrir el archivo");
        return 1;
    }

    archivo_salida = fopen("salida_compleja.txt", "w");
    if (archivo_salida == NULL) {
        perror("No se pudo abrir el archivo de salida");
        return 1;
    }

    yyin = archivo;
    yylex();  
    fclose(archivo);
    fclose(archivo_salida);

    return 0;
}
