package jflexdemo; 
import java.util.ArrayList;
 
%% 
 
%public 
%class Lexer 
%type Void 


%{
	 private ArrayList<String> list= new ArrayList();
%}

 
%init{ 
    yybegin( FIRST ); 
%init}

keyword = "if" | "then" |"else"| "endif" |"while" |"do"| "endwhile" |"print" |"newline"| "read"
operator = "+" | "-" |"*"| "/"| "="| ">" |">="| "<"| "<="| "==" |"++"| "--"
integer = [0-9][0-9]*
word  =  [A-Za-z][A-Za-z]*
string = [\"][A-Za-z0-9][A-Za-z0-9]*[\"]
comment = "//"[A-Za-z0-9][A-Za-z0-9]*
endPunct    =  [\;] 
otherPunct  =  [\(\)] 
space    =  [\ \t]
LineTerminator = \r|\n|\r\n
 
%state FIRST
 
%% 
<FIRST> { 
  
  {operator}	{ 
		System.out.println( "operator\t" + yytext()  ); 
		}
  {keyword}	{ 
		System.out.println( "keyword\t" + yytext()  ); 
		} 
  {word}	{ 
		System.out.println( "identifier\t" + yytext() ); 
		} 
  {endPunct}	{ 
		System.out.println( "endPunct\t" + yytext()  ); 
		}
  {string}	{ 
			System.out.println( "string\t" + yytext()  ); 
		}
  {comment}	{ 
		System.out.println( "comment\t" + yytext()  ); 
		}

  {space}	{ 
  		} 
               
   .	{ 
        System.err.println( "Invalid character \"" + yytext() + "\"" ); 
    }
}