import {LetExp, LetStarExp, makeLetExp} from "./L3-ast";
import {isError} from "./error";

const rewriteLetStar=(letStarExp: LetStarExp | Error): LetExp | Error=>
    !isError(letStarExp)? rewriteLetStarHelper(letStarExp.body):
        letStarExp;


const rewriteLetStarHelper=(letExp: LetExp) : LetExp =>
    (letExp.bindings.length === 1 ? makeLetExp(letExp.bindings, letExp.body) :
            makeLetExp(letExp.bindings.splice(0, 1), [rewriteLetStarHelper(letExp)]));