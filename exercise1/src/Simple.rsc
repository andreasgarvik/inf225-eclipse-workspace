module Simple

lexical Whitespace = [\ \n];

layout Standard = Whitespace*;

start syntax Expr =
	Int: NUM num     
	| left Plus: Expr e1 "+" Expr e2    
	;  

lexical NUM = [0-9]+;
