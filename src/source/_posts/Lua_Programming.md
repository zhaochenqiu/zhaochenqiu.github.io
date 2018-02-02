title: Lua Programming
date: 2017-11-01
tags: Lua
abstract: The records of learning lua. All the sources code are captured from "Programming in Lua"
---

# First lua program
To keep with the tradition, the first program just prints "Hello World"
    print("Hello World");
You can input the code in th command line,
or save it into a file such as "hello.lua".
Then run 'th hello.lua'

# Factorial of a given number
The following program defines a function to compute the factorial of a given number,
asks the user for a number, and print its factorial:

    -- defines a factorial function
    function fact (n)
        if n == 0 then
            return 1
        else
            return n * fact(n - 1)
        end
    end

    print("enter a number:")
    a = io.read("*number")
    print(fact(a))

# Chunks
The piece of code that Lua executes is called a *chunk*.
Both the semicolons and line break play no role in Lua's syntax.
The following four chunks are all valid and equivalent:
    a = 1
    b = a*2
    
    a = 1;
    b = a*2;
    
    a = 1 ; b = a*2
    
    a = 1   b = a*2    -- ugly, but valid

# Call functions from files
Let's denote that there is a file lib1.lua
    -- file 'lib1.lua'
    function norm (x, y)
        local n2 = x^2 + y^2
        return math.sqrt(n2)
    end

    function twice (x)
        return 2 * x
    end
Then, in interactive mode, type following commands:
    > dofile("lib1.lua")   -- load your library
    > n = norm(3.4, 1.0)
    > print(twice(n))      --> 7.0880180586677

# Global Variables
All the variables in Lua re global variables, even the variables defined in a function.
Example, if we have a lua chunks named "lib2.lua" contains codes like following:
    function testfun (x)
        g_a = x
    end
Then, in the interactive mode,  type following:
    > dofile("lib2.lua")
    > testfun(20)
    > print(g_a)

# Eight basic typles in Lua
Lua is a dynamically typed language. Each value carries its own type.
There are eight basic types in Lua: nil, boolean, number, string, userdata, function, thread, and table
Type the codes shown following:

    print(type("Hello world"))  --> string
    print(type(10.4*3))         --> number
    print(type(print))          --> function
    print(type(type))           --> function
    print(type(true))           --> boolean
    print(type(nil))            --> nil
    print(type(type(X)))        --> string

    print(type(a))   --> nil   (`a' is not initialized)
    a = 10
    print(type(a))   --> number
    a = "a string!!"
    print(type(a))   --> string
    a = print        -- yes, this is valid!
    a(type(a))       --> function

# Tables
The table type implements associative arrays. An associative array is an array that can be indexed not only with numbers, but also with strings or any other value of the language,
except nil. Moreover, tables have no fixed size; you can add as many elements as you want to a table dynamically.
Tables in Lua are neither values nor variables; they are objects. **You create tables by means of a constructor expression, which in its simplest form is written as {}:**

    -- create a table in Lua
    a = {}
    k = "x"
    a[k] = 10
    a[20] = "great"
    print(a["x"])
    k = 20
    print(a[k])
    a["x"] = a["x"] + 1
    print(a["x"])

In my opinion, the table just like a mixture of dynamic array and hash array.

A table is anonymous, there is no fixed relationship between a variable that holds a table and the table itself:

    a = {}
    a["x"] = 10
    b = a      -- `b' refers to the same table as `a'
    print(b["x"])  --> 10
    b["x"] = 20
    print(a["x"])  --> 20
    a = nil    -- now only `b' still refers to the table
    b = nil    -- now there are no references left to the table

The Lua has garbage recollection, the Lua management will eventually delete the table, to which there is no references.
There are some tricks about using table:

    a.x = 10                    -- same as a["x"] = 10
    print(a.x)                  -- same as print(a["x"])
    print(a.y)                  -- same as print(a["y"])
    a = {}
    x = "y"
    a[x] = 10                 -- put 10 in field "y"
    print(a[x])   --> 10      -- value of field "y"
    print(a.x)    --> nil     -- value of field "x" (undefined)
    print(a.y)    --> 10      -- value of field "y"

# Operators
## Arithmetic Operators
Lua supports the usual arithmetic operators: the binary `+´ (addition), `-´ (subtraction), `*´ (multiplication), `/´ (division), and the unary `-´ (negation). All of them operate on real numbers. 
Lua provides the following relational operators:

    <   >   <=  >=  ==  ~=

All these operators always result in true or false. 
## Logical Operators
The logical operators are and, or, and not. Like control structures, all logical operators consider false and nil as false and anything else as true. The operator and returns its first argument if it is false; otherwise, it returns its second argument. The operator or returns its first argument if it is not false; otherwise, it returns its second argument:

    print(4 and 5)         --> 5
    print(nil and 13)      --> nil
    print(false and 13)    --> false
    print(4 or 5)          --> 4
    print(false or 5)      --> 5
## Concatenation
    print("Hello " .. "World")  --> Hello World
    print(0 .. 1)               --> 01
    a = "Hello"
    print(a .. " World")   --> Hello World
    print(a)               --> Hello

## Precedence
Operator precedence in Lua follows the table below, from the higher to the lower priority:

    ^
    not  - (unary)
    *   /
    +   -
    ..
    <   >   <=  >=  ~=  ==
    and
    or
    
Some examples of precedence

    a+i < b/2+1          <-->       (a+i) < ((b/2)+1)
    5+x^2*8              <-->       5+((x^2)*8)
    a < y and y <= z     <-->       (a < y) and (y <= z)
    -x^2                 <-->       -(x^2)
    x^y^z                <-->       x^(y^z)


# Statements
## Local Variables and Blocks
Besides global variables, Lua supports local variables. We create local variables with the local statement: 

    j = 10         -- global variable
    local i = 1    -- local variable
    x = 10
    local i = 1        -- local to the chunk
    
    while i<=x do
      local x = i*2    -- local to the while body
      print(x)         --> 2, 4, 6, 8, ...
      i = i + 1
    end
    
    if i > 20 then
      local x          -- local to the "then" body
      x = 20
      print(x + 2)
    else
      print(x)         --> 10  (the global one)
    end
    
    print(x)           --> 10  (the global one)

## if then else

    if a<0 then a = 0 end
    
    if a<b then return a else return b end
    
    if line > MAXLINES then
      showpage()
      line = 0
    end

When you write nested ifs, you can use elseif. It is similar to an else followed by an if, but it avoids the need for multiple ends:

    if op == "+" then
      r = a + b
    elseif op == "-" then
      r = a - b
    elseif op == "*" then
      r = a*b
    elseif op == "/" then
      r = a/b
    else
      error("invalid operation")
    end

## for

    for i = 1,10 do
        print(i)
    end

    for i = 1,10,0.5 do
        print(i)
    end

    a = {"a", "b", "c", "d", "e"}

    for i, v in ipairs(a) do
        a[v] = i
    end

## Functions
Run a Lua brunk, dofile("exp6.lua"), dofile 'exp6.lua'
In Lua, a function is a value with the same rights as conventional values like numbers and strings.

    a = {p = print}
    a.p("Hello World") --> Hello World
    print = math.sin  -- `print' now refers to the sine function
    a.p(print(1))     --> 0.841470
    sin = a.p         -- `sin' now refers to the print function
    sin(10, 20)       --> 10      20



# Common functions in Lua
## convert string to in
    print(tonumber("10"))       --> 10
    print(tonumber("+10"))      --> 10
    print(tonumber("-10"))      --> -10
    print(tonumber("sdfsdf"))   --> nil
    print(tonumber(fs))         --> nil

## find a substr in string
    s, e = string.find("hello Lua users", "Lua")
    
    print(s, e)   -->  7      9
