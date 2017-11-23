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
integer = \d+
identifier  =  [A-Za-z][A-Za-z0-9]*
string = \"[^\"\n]*\"
comment = "//"[^n]*
commentmanylines =  "/*"~"*/"
semicolon    =  \;
bracket  =  [\(\)] 
space    =  \ 
LineTerminator = \r|\n|\r\n

%state FIRST
 
%% 
<FIRST> 
{ 
  {operator}	
    { 
	System.out.println( "Operator :\t" + yytext()  ); 
    }
  {semicolon} | {bracket}	
    { 
        if(yytext().equals(";"))
        {
            System.out.println( "Semicolon :\t" + yytext()  ); 
        }
        else if(yytext().equals("("))
        {
            System.out.println( "Open Bracket :\t" + yytext()  ); 
        }
        else
        {
            System.out.println( "Close Bracket :\t" + yytext()  ); 
        }
    }
  {keyword}	
    { 
	System.out.println( "Keyword :\t" + yytext()  ); 
    } 
  {integer}	
    { 
	System.out.println( "Integer :\t" + yytext()  ); 
    } 
  {identifier}	
    { 
       	if(list.contains(yytext()))
        {
            System.out.println( "Identifier "+yytext() +" already in symbol table");
        }
        else
        {
            System.out.println( "New Identifier :\t" + yytext() );
            list.add(yytext());
        }
    }
  {string}	
    { 
        System.out.println( "String :\t" + yytext()  ); 
    }
  {comment}|{commentmanylines}	
    { 
        
    }
  {space} | {LineTerminator}	
    { 
    }            
    .	
    { 
        System.err.println( "Invalid character \"" + yytext() + "\"" ); 
        return null;
    }
}