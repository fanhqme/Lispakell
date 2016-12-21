U.hs
=============

U.hs is a LISP syntax [Unlambda](https://en.wikipedia.org/wiki/Unlambda) implementation written in Haskell. Started initially as a programming homework. Now development still in progress.
The language takes the idea from Unlambda:

* Everything is a function. Functions are things that map functions to functions (and hence have no type at all).

However, important language sugars and modifications are added:

1. Lambda is introduced back, for the sake of any sane soul. A Lisp-style syntax is used. So I = ((S K) K).
2. Pure functional design, with referential transparency, lazy evaluation and CPS IO operation. There is no [strictness](https://wiki.haskell.org/Performance/Strictness) nor [delayed](http://www.madore.org/~david/programs/unlambda/#delay) application.
3. Module system, standard library and syntax sugar for CPS.

Getting Started
----------------

U.hs uses file extension .u. Example of helloworld.u:
```
(import io)
(def main (run
	(_ (io.putStrLn "hello world"))
	(exit 0)
	)
)
```
The "run" statement is syntax sugar for chaining callbacks: (run (a b) (c d) e) = (b (\\a (d (\\c e)))). All io functions use callback to get the return value. Exit takes no callback (and hence stops execution).

To interpretively run the program call urun
```
$ghc urun.hs
$./urun helloworld.u
hello world
```

A basic repl calculator is also included.
```
$runghc urepl.hs
; type :q to quit, :? for help
>(+ 3 1)
4
>(putChar 'a' (\_ (putChar '\n' exit)))
a
>:q
```

Language Specification
----------------

TODO
