import {
	Binding,
	CExp,
	isAppExp,
	isBoolExp,
	isDefineExp,
	isLetExp,
	isLetStarExp,
	isNumExp,
	isPrimOp,
	isProgram,
	isVarDecl,
	isVarRef,
	LetExp,
	makeAppExp,
	makeBinding,
	makeDefineExp,
	makeLetExp,
	makeProgram,
	Parsed
} from "./L3-ast";
import {isError} from "./error";
import {map} from "ramda"

export const rewriteLetStar = (cexp: Parsed | Error): LetExp | Error =>
	isLetStarExp(cexp) ? rewriteLetStarHelper(cexp.body) :
		Error("Unexpected type");

export const rewriteAllLetStar = (cexp: Parsed | Binding | Error): Parsed | Binding | Error =>
	isBoolExp(cexp) ? cexp :
		isNumExp(cexp) ? cexp :
			isPrimOp(cexp) ? cexp :
				isVarRef(cexp) ? cexp :
					isError(cexp) ? cexp :
						isVarDecl(cexp) ? cexp :
							isProgram(cexp) ? makeProgram(map(rewriteAllLetStar, cexp.exps)) :
								isDefineExp(cexp) ? makeDefineExp(cexp.var, <CExp>rewriteAllLetStar(cexp.val)) :
									isLetExp(cexp) ? makeLetExp(map((curr: Binding) => makeBinding(curr.var,
										<CExp>rewriteAllLetStar(curr.val)), cexp.bindings),
										map((currCexp) => rewriteAllLetStar(currCexp), cexp.body)) :
										isLetStarExp(cexp) ? rewriteAllLetStar(rewriteLetStar(cexp)) :
											isAppExp(cexp) ? makeAppExp(<CExp>rewriteAllLetStar(cexp.rator),
												map(rewriteAllLetStar, cexp.rands)) :
												Error("Unexpected expression " + cexp);


const rewriteLetStarHelper = (letExp: LetExp): LetExp =>
	(letExp.bindings.length === 1 ? makeLetExp(letExp.bindings, letExp.body) :
		makeLetExp(letExp.bindings.splice(0, 1), [rewriteLetStarHelper(letExp)]));

// console.log(JSON.stringify(rewriteAllLetStar(parseL3
//     ("(let* ((x (let* ((y 5)) y)) (z 7)) (+ x (let* ((t 12)) t)))")),
//     null, 4));