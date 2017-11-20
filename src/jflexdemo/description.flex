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
LineTerminator = \r|\n|\r\n
comment = "//"[A-Za-z0-9][A-Za-z0-9]*|"/*"+comment[LineTerminator]*+"*/"
endPunct    =  [\;] 
otherPunct  =  [\(\)] 
space    =  [\ \t\r\n]

%state FIRST
 
%% 
<FIRST> { 
  
  {operator}	{ 
		System.out.println( "Operator :\t" + yytext()  ); 
		}
  {keyword}	{ 
		System.out.println( "Keyword :\t" + yytext()  ); 
		} 
  {word}	{ 
  		String x = yytext();
            	boolean FoundInList = false;
            	for(int i=0;i<list.size();i++) {
            		if(list.get(i).equals(x)) {
            			FoundInList = true;
            			break;
            		}
            	}
            	if(FoundInList){
            		System.out.println( "Identifier :\t" + x );
            	}
            	else{
            		System.out.println( "New Identifier :\t" + x ); 
            	}
            	list.add(x);
		} 
  {endPunct}	{ 
		System.out.println( "EndPunct :\t" + yytext()  ); 
		}
  {string}	{ 
			System.out.println( "String :\t" + yytext()  ); 
		}
  {comment}	{ 
		System.out.println( "Comment :\t" + yytext()  ); 
		}

  {space}	{ } 
               
   .	{ 
        System.err.println( "Invalid character \"" + yytext() + "\"" ); 
    }
}