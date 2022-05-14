%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

%}

ENTEROS [0-9]+

%%

\n {;}
{ENTEROS} {printf("%s ",yytext); fputs("Entero\n",yyout);}
"+"{0,2} {printf("%s ",yytext); fprintf(yyout,"SUMA\n");}
. {;}

%%

int main(int argc,char *argv[]){

    yyin = fopen("entrada.txt","r");
    if(yyin!=NULL){
        yyout = fopen("salida.txt","w");
        yylex();
        fclose(yyin);
        fclose(yyout);
    }
    return 0;

}