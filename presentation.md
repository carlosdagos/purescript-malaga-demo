class: center, middle

# Strongly-typed, Functional programming for the Frontend

_You may not know it, but you may be suffering from [JavaScript Fatigue](https://medium.com/@ericclemmons/javascript-fatigue-48d4011b6fc4#.rfc8iui55)_

#### Frontend Málaga Meetup
#### Málaga, December 20th 2016
##### [Carlos D.](https://github.com/charlydagos)

---

# Agenda

- What is Functional Programming? Why should we care?
- What is a strongly-typed language? Again, why should we care?
- Practical PureScript
    - Intro
    - Your basic toolset
    - Intro to the language
    - Looking at the produced output
    - Interop-_ing_
    - Demo of a working application

#### Code samples

```bash
$ git clone https://github.com/charlydagos/purescript-malaga-demo.git
```

#### My purpose

To get _at least some of you_ interested in developing apps with PureScript.

---

## Introduction

.left-column[
#### About me
]

.right-column[
I'm Carlos.

I've been paid to write Java, Scala and PHP.

I've been kindly asked to write Ruby, Python, Clojure, Objective-C, others...

I currently write Haskell.
]

---

# Functional Programming

#### What is it?

It's a programming paradigm where we treat functions as _first class citizens_.red.bold[¹].

It means that...

- We can "talk" about a function without any special notation.
- We can "store" functions in variables.
- Functions can take other functions as arguments (_higher order functions_).

Is JavaScript a _functional programming language_?


.footnote[.red.bold[¹] Evaluation order and avoidance of state and mutability
is also part of the paradigm.]

---

# Functional Programming

#### Why is it important?

*First and foremost*: It's as important as learning any other paradigm.

##### Most importantly

It allows for types of abstractions that may otherwise not be found in languages
that don't support functional programming.

```javascript
var scream = function(name) {
    return name.toUpperCase() + "!!!";
}

var screamedNames = ["Alice", "Bob"].map(scream) // What is `scream`?
                                                 // What is `map`?

console.log(screamedNames) // What is the output?
```

What is the _imperative_ (i.e. non-functional) code that would produce
the same output?

---

# Functional Programming

#### Why is it important?

##### Abstraction, Abstraction, Abstraction

- What makes functions so different from other _citizens_?
- What can we do with functions when they're first-class citizens?
- Why is this important?

---

# Strongly-typed languages

#### What is it?

```javascript
var scream = function(name) {
    return name.toUpperCase() + "!!!"
}

var screamNames = function(names) {
    return names.map(scream)
}

var names = ["Alice", "Bob"]

console.log(screamNames(names))
```

- Where are the bugs?
- How can we spot them?
- How many of them are there?
- How could we guarantee that our code is _safe_?


---

# Strongly-typed languages

#### What is it?

Compare to

```haskell
scream :: String -> String
scream name = name ++ "!!!"

screamNames :: [String] -> [String]
screamNames names = map scream names

names :: [String]
names = ["Alice", "Bob"]

main = log (show $ screamNames names)
```

- What are the differences?
- Where are the bugs now?
- What _really_ changed?
- Where's the benefit?

---

# Strongly-typed languages

#### Why is it important?

It's important to learn the difference between

- Languages
- Compilers
- Runtimes

A strongly-typed _language_ allows a _compiler_ implementation to make use
of all the information supplied by the language in order to perform a
_static analysis_ of our program.

Some compilers may or may not include a _runtime_.

---

# Strongly-typed languages

#### Why is it important?

What happens if we now say

```haskell
scream :: String -> String
scream name = name <> "!!!"

screamNames :: [String] -> String
screamNames names = map scream names

names :: [String]
names = ["Alice", "Bob"]

main = log (show $ screamNames names)
```

- See the difference? (I made this bug as I wrote this presentation)
- What's the effect? (We'll see an example later!)

---

# Practical PureScript

#### Intro

##### What is PureScript?

From http://www.purescript.org

_PureScript is a small **strongly typed** programming language that **compiles**
to JavaScript._

Looking at this sentence we can tell what we're getting.

---

# Practical PureScript

#### Intro

Let's revisit our previous code

```haskell
module Main where

import Prelude
import Control.Monad.Eff.Console (log)

scream :: String -> String
scream name = name <> "!!!"

screamNames :: Array String -> Array String
screamNames names = map scream names

names :: Array String
names = ["Alice", "Bob"]

main = log (show $ screamNames names)
```

Same output we were looking for before, but this time we can _make claims
about our program_. Namely, that it _compiles_.

---

# Practical PureScript

#### Intro

##### Let's install it!

- Mac

`brew install purescript`

- Unix-like systems

`npm install -g purescript`

- Windows

I recommend using a package manager like https://chocolatey.org/

And then

`choco install purescript`

---

# Practical PureScript

#### Intro

##### We have now two tools

- `psc`: Our compiler
- `psci`: Our interactive Read-Evaluate-Print-Loop (REPL)

This is great! But not enough. We'll see more soon!

##### Where can we write PureScript?

I use nvim, another option is Atom editor with the plugins recommended here

https://github.com/purescript/purescript/wiki/Editor-and-tool-support

---

# Practical PureScript

#### A basic toolset

Pulp! It's our most basic build tool.

```bash
$ mkdir example-app          # Makes a dir to work on
$ cd example-app             # Switch to that dir
$ npm init .                 # Starts a new project (creates package.json)
$ npm install --save pulp    # Install pulp as a dependency
$ pulp init                  # Creates a project skeleton
$ pulp psci                  # Launches us into a console
```

This gets us ready to start writing :)

##### Personal recommendation

`npm install -g pscid`

Run [`pscid`](https://github.com/kRITZCREEK/pscid) in a shell next to your
code to get an immediate update on errors and warnings.

---

# Practical PureScript

#### Intro to the language

##### Basic syntax

The type system should tell us _everything_ we need to know about a function, and
for this we use the `::` symbol, which can be translated as `is of type`

```haskell
f :: Int
f = 2
```

##### Modules

All the code in PureScript is separated into `modules`, in other
words:

```haskell
module Main where

f :: MyType
f = ...

g :: SomeType -> AnotherType
g = ...
```

---

# Practical PureScript

#### Intro to the language

##### The type system

Strongly typed. What would be _weakly_ typed?

##### Functions

```haskell
-- What is f?
f :: Int -> Int -> Int
f x y = x + y

-- What is g?
g :: Int
g = 2

-- What is h?
h :: (Int -> Int) -> [Int] -> Int
h f ints = sum (map f ints)
```

---

# Practical PureScript

#### Intro to the language

##### Data types

```haskell
-- Type
data Hand = Rock | Paper | Scissors -- Values

-- Type
data Maybe a = Nothing | Just a     -- Values

-- Type Alias
type NameRecord t = { name :: String
                    , lastName :: String
                    | t
                    }

fullName :: forall t. NameRecord t -> String
fullName record = record.name <> " " <> record.lastName

fullName' :: forall t. { name :: String, lastName :: String | t } -> String
fullName' record = record.name <> " " <> record.lastName
```

_Types_ vs _Values_? What's the relationship?

---

# Practical PureScript

#### Intro to the language

##### Declarative programming and pattern-matching

```haskell
data List a = End | Cons a (List a)

myList :: List Int
myList = Cons 1 (Cons 2 (Cons 3 End))

emptyList :: List Int
emptyList = End

find :: Int -> List Int -> Maybe Int
find x (Cons y rest) = if x == y
                          then Just x
                          else find x rest
find _ End = Nothing

main = do
    log (head myList)    -- Prints "Just 1"
    log (head emptyList) -- Prints "Nothing"

-- ^ Can that be abstracted?
```

---

# Practical PureScript

#### Intro to the language

##### Effects

So far we've seen functions that don't do "anything".red.bold[²] 🙄

What about functions that do:

- Console IO
- Throw Exceptions
- Perform DOM manipulation
- Perform XMLHttpRequest / AJAX calls
- Interact with a websocket
- Read/Write to/from some storage

We use the `Eff` _monad_ .red.bold[³].

.footnote[
.red.bold[²] Used very, very loosely 🤓 <br/>
.red.bold[³] We won't get into this today
]

---

# Practical PureScript

#### Intro to the language

##### Effects




---

# Practical PureScript

#### Produced output

PureScript's author's intention is to make the ouput *easy to read
and to debug*.

_Sidenote: CoffeeScript, anyone?_

- Basic functions.
- Higher-order function.
- Simple data types.
- `Maybe a` example.

---

# Practical PureScript

#### Interop

- Why would we need such a thing?

We don't want to rewrite the wheel!

- Foreign Function Interface (FFI)

It's as simple as placing a file of the same name next to the PureScript file
with a `.js` extension, and using `exports` accordingly. Let's see an example.

---

# Practical PureScript

## A working app

- Pux
- Webpack
- Bower

