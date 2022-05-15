%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

%}

NUMEROS [0-9] 

%%



\n {;}/* Reconocimiento de los Simbolos de la Gramatica */
{NUMEROS}+ {printf("%s ",yytext); fputs("Entero\n",yyout);}
{NUMEROS}+"."{NUMEROS}+ {printf("%s ",yytext); fputs("Decimal\n",yyout);}
"+"{0,1} {printf("%s ",yytext); fprintf(yyout,"SUMA\n");}
"-"{0,1} {printf("%s ",yytext); fprintf(yyout,"RESTA\n");}
"*"{0,1} {printf("%s ",yytext); fprintf(yyout,"MULTIPLICACION\n");}
"/"{0,1} {printf("%s ",yytext); fprintf(yyout,"DIVISION\n");}
"("{0,1} {printf("%s ",yytext); fprintf(yyout,"ABREPARENTESIS\n");}
")"{0,1} {printf("%s ",yytext); fprintf(yyout,"CIERRAPARENTESIS\n");}
"%"{0,1} {printf("%s ",yytext); fprintf(yyout,"MODULO\n");}
"^"{0,1} {printf("%s ",yytext); fprintf(yyout,"POTENCIA\n");}
. {;}

%%

/* Bloque Principal */

/* Se realizan las verificaciones para los 5 posibles errores*/

/* 1: Programa sin parametros */
/* 2: Programa con 1 parametro faltante */
/* 3: Programa con mas de 2 parametros */
/* 4: Programa con Archivo de entrada no existente*/
/* 5: Programa con Archivo de salida existente*/

/* El Funcionamiento correcto del programa ocurre cuando se usa:*/
/* Uso : archivo.exe entrada.txt salida.txt*/


int main(int argc,char *argv[]){

    if(argc == 1){
        fprintf(stderr, "Error: Faltan Parámetros\n");
        fprintf(stderr, "Uso : archivo.exe entrada.txt salida.txt\n");
        return 1;
    }
    if(argc == 2){
        fprintf(stderr, "Error: Falta Parámetro\n");
        fprintf(stderr, "Uso : archivo.exe entrada.txt salida.txt\n");
        return 4;
    }
    else if(argc > 3){
        fprintf(stderr, "Error: Demasiados Parámetros\n");
        fprintf(stderr, "Uso : archivo.exe entrada.txt salida.txt\n");
        return 5;
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Error : El archivo de entrada no existe: %s\n", argv[1]);
        return 2;
    }

    if (yyout = fopen(argv[2], "r")) {
        fclose(yyout);
        fprintf(stderr, "Error : El archivo de salida ya existe: %s\n", argv[2]);
        return 3;
    }
    if(yyin!=NULL){
        yyout = fopen(argv[2],"w");
        yylex();
        fclose(yyin);
        fclose(yyout);
    }
    return 0;

}