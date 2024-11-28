%{
#include <stdio.h>
#include <string.h>
%}

%%

"+"                { printf("sumar"); }
"-"                { printf("restar"); }
"*"                { printf("multiplicar"); }
"/"                { printf("dividir"); }

"if"               { printf("condicional_si"); }
"for"              { printf("ciclo_para"); }

"print"            { printf("imprimir"); }
"input"            { printf("leer"); }

"("                { putchar('('); }
")"                { putchar(')'); }
"{"                { putchar('{'); }
"}"                { putchar('}'); }

[0-9]+             { printf("%s", yytext); }  // Números
[a-zA-Z_][a-zA-Z0-9_]*  { printf("%s", yytext); }  // Identificadores

[ \t\n]+           { /* Ignorar espacios y saltos de línea */ }

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

    yyin = archivo;
    yylex();  // Ejecuta el analizador léxico
    fclose(archivo);
    return 0;
}
