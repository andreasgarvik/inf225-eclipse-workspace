module Simpl

import IO;
import ParseTree;
import List;

layout MyLayout = [\t\n\ \r\f]*;

start syntax Program = Expr;

syntax Expr
	= ID                  // variables
	| NUM                 // integers
	| left (Expr "*" Expr | Expr "/" Expr)
	> left (Expr "+" Expr | Expr "-" Expr)
	| ID "(" Expr ")"     // function call
	| "(" Expr ")"        // parentheses
	;
	
// identifiers
//    y !<< x means 'x' must not be preceded by  'y'
//    x !>> y means 'x' must not by followed by 'y'
// so, this means that an identifier is a sequence of one
// or more letters or underscores, with no additional
// letters or underscores before or after
lexical ID = [a-zA-Z_] !<< [a-zA-Z_]+ !>> [a-zA-Z_];

// numbers
lexical NUM = [0-9] !<< [0-9]+ !>> [0-9];

public str pretty(Program p) {
	if(Program p := p)
		return pretty(p);
	else
		return "[unknown program: \"<p>\"]";
}

public default str pretty(Expr e) {
	return "[unknown expr: \"<e>\"]";
}


public str pretty((Expr)`<ID i>`) {
	return "<i>";
}

public str pretty((Expr)`<NUM n>`) {
	return "<n>";
}

public str pretty((Expr)`<Expr e1>+<Expr e2>`) {
	return "(<pretty(e1)>+<pretty(e2)>)";
}

public str pretty((Expr)`<Expr e1>*<Expr e2>`) {
	return "(<pretty(e1)>*<pretty(e2)>)";
}

public str pretty((Expr)`<Expr e1>-<Expr e2>`) {
	return "(<pretty(e1)>-<pretty(e2)>)";
}

public str pretty((Expr)`<Expr e1>/<Expr e2>`) {
	return "(<pretty(e1)>/<pretty(e2)>)";
}

public str pretty((Expr)`(<Expr e>)`) {
	return "(<pretty(e)>)";
}

public str pretty((Expr)`<ID f>(<Expr e>)`) {
	return "<f>(<pretty(e)>)";
}

void printAmb(Tree t) {
    visit(t) {
    case amb(alts): {
            println("ambiguity: <intercalate(" | ", [unparse(parens(e)) | Expr e <- alts])>");
        }
    }
}

Expr parens(Expr expr) {
    return bottom-up visit(expr) {
        case (Expr)`((<Expr e>))` => e    // drop extra parens
        case e:(Expr)`(<Expr _>)` => e    // don't touch if we already have
        case Expr e => (Expr)`(<Expr e>)` // add around all other expressions
    }
}


