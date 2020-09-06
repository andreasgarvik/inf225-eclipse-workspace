module ListExpressions

layout Standard = [\t\n\ \r\f]*;

lexical Identifier = [a-z] !<< [a-z]+ !>> [a-z];

lexical Sheep = [bæ+]*;

lexical RegEx = [((xy*x)|(yx*y))?];

lexical List = {Identifier ","}*;

start syntax ListExpr 
	= "(" List ")"
	;