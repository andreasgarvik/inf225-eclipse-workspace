module CStatements

lexical NUM = [0-9]+ !>> [0-9];
lexical ID = [a-z]+ !>> [a-z];
layout MyLayout = [\ \n]* !>> [\ \n];

syntax CExpr = NUM | ID;

syntax CStatement
	= "if" "(" CExpr ")" CStatement
	| "if" "(" CExpr ")" CStatement "else" CStatement
	| CExpr ";"
	| ";"
	;
