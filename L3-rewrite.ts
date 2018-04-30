import {isLetStarExp, LetExp, LetStarExp, makeLetExp} from "./L3-ast";

const rewriteLetStar=(letStarExp: LetStarExp | Error): LetExp | Error=>
    isLetStarExp(letStarExp)? rewriteLetStarHelper(letStarExp.body): Error("Unexpected type");


const rewriteLetStarHelper=(letExp: LetExp) : LetExp =>
    (letExp.bindings.length === 1 ? makeLetExp(letExp.bindings, letExp.body) :
            makeLetExp(letExp.bindings.splice(0, 1), [rewriteLetStarHelper(letExp)]));