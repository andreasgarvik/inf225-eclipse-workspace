module LogicExpressions

import ParseTree;

layout Standard = [\t\n\ \r\f]*;

lexical Identifier = [a-z] !<< [a-z]+ !>> [a-z];

start syntax LogicExpr
	= Identifier
	| left LogicExpr "AND" LogicExpr
	> left LogicExpr "OR" LogicExpr
	| "(" LogicExpr ")" 
	;
	 

/* syntax AndExpr = Identifier
	| left AndExpr Keywords Identifier
	;	 	


syntax OrExpr = AndExpr
	| left OrExpr Keywords OrExpr
	;
*/

bool grammarTest(str s) {
	pt = parse(#Expr, s)?;
	return pt;
}

Expr addParens(Expr expr) {
    return bottom-up visit(expr) {
        case (Expr)`((<Expr e>))` => e    // drop extra parens
        case e:(Expr)`(<Expr _>)` => e    // don't touch if we already have
        case Expr e => (Expr)`(<Expr e>)` // add around all other expressions
    }
}
