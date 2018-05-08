import {
	CExp,
	DefineExp,
	isAppExp,
	isBoolExp,
	isDefineExp,
	isError,
	isNumExp,
	isPrimOp,
	isProgram,
	isVarDecl,
	isVarRef,
	Program
} from "./L1-ast";
import {map, reduce} from "ramda";

const unparse = (x: Program | DefineExp | CExp): string | Error =>
	isProgram(x) ? reduce((curr, acc) => curr + acc + " ", "", map(unparse, x.exps)) :
		isDefineExp(x) ? "(define " + x.var.var + " " + unparse(x.val) + ")" :
			isNumExp(x) ? x.val + " " :
				isBoolExp(x) ? (x.val ? "#t" : "#f") + " " :
					isPrimOp(x) ? x.op + " " :
						isVarRef(x) ? x.var + " " :
							isVarDecl(x) ? x.var + " " :
								isAppExp(x) ? "(" + unparse(x.rator) + " " + reduce((curr, acc) => curr + acc + " ", "", map(unparse, x.rands)) + ")" :
									isError(x) ? x : "";

//console.log(unparse(parseL1("(L1 (define x 5) (+ x 5) (+ (+ (- x y) 3) 4) (and #t x))")));