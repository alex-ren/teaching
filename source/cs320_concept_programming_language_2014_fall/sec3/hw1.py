import re

#question 1a
def tokenize(terminals, s):
    string = ""
    for terminal in terminals: #special cases
        if (terminal == "("):
            string += "\\" + terminal + "|"
        elif (terminal == ")"):
            string += "\\" + terminal + "|"
        elif (terminal == "+"):
            string += "\\" + terminal + "|"
        elif (terminal == "*"):
            string += "\\" + terminal + "|"
        else:
            string += terminal + "|"

    tokens = [t for t in re.split(r"(\s+|"+ string + ")", s)]
    
    # Throw out the spaces and return the result
    return [t for t in tokens if not t.isspace() and not t == ""]


#question 1B
def directions(tokens):
    if (tokens[0] == 'forward' and tokens[1]==';'):
        return ({'Forward': [directions(tokens[2:])] })

    if (tokens[0] == 'reverse' and tokens[1]==';'):
        return ({'Reverse': [directions(tokens[2:])] })
        
    if (tokens[0] == 'stop' and tokens[1]==';'):
        return ('Stop')

    if (tokens[0] == 'left' and tokens[1]=='turn' and tokens[2]==';'):
        return ({'LeftTurn': [directions(tokens[3:])] })

    if (tokens[0] == 'right' and tokens[1]=='turn' and tokens[2]==';'):
        return ({'RightTurn': [directions(tokens[3:])] })

#QUESTION 2
#question 2a
def number(tokens):
    if re.match(r"^-?[0-9]\d*(\.\d+)?$", tokens[0]):
        return ({"Number": [int(tokens[0])]}, tokens[1:])

def variable(tokens):
    if re.match(r"^([a-zA-Z]+)", tokens[0]):
        return ({"Variable":[str(tokens[0])]}, tokens[1:])

#question 2b
def term(tmp):
    tokens = tmp[0:]
    if tokens[0] == '@':
        return variable(tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == '#':
        return number(tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'log' and tokens[1] == '(':
        (e1, tokens) = term(tokens[2:])
        if (tokens[0] == ')'):
            return ({'Log':[e1]}, tokens[1:])   


    tokens = tmp[0:]
    if (tokens[0] == 'plus' and tokens[1] == '('):
        (e1, tokens) = term(tokens[2:])
        if(tokens[0] == ',' ):
            (e2, tokens) = term(tokens[1:])
            if (tokens[0] == ')'):
                return ({'Plus':[e1,e2]}, tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'mult' and tokens[1] == '(':
        (e1, tokens) = term(tokens[2:])
        if (tokens[0] == ','):
            (e2, tokens) = term(tokens[1:])
            if (tokens[0] == ')'):
                return ({'Mult':[e1,e2]}, tokens[1:])

#question 3 added on
#+case
    tokens = tmp[0:]
    if tokens[0]=='(':
        (e1, tokens) = term(tokens[1:])
        if(tokens[0]=='+'):
            (e2, tokens) = term(tokens[1:])
            if (tokens[0]==')'):
                return ({'Plus':[e1,e2]}, tokens[1:])
# * case
    tokens = tmp[0:]
    if tokens[0]=='(':
        (e1, tokens) = term(tokens[1:])
        if(tokens[0]=='*'):
            (e2, tokens) = term(tokens[1:])
            if (tokens[0]==')'):
                return ({'Mult':[e1,e2]}, tokens[1:])
       
        
# question 2c
def formula(tmp):
    tokens = tmp[0:]
    if tokens[0] == 'true':
        return ('True', tokens[1:])

    tokens = tmp[0:]    
    if tokens[0] == 'false':
        return ('False', tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'not' and tokens[1] == '(':
        (e1, tokens) = formula(tokens[2:])
        if (tokens[0] == ')'):
            return ({'Not':[e1]}, tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'or' and tokens[1] == '(':
        (e1, tokens) = formula(tokens[2:])
        if tokens[0] == ',':
            (e2, tokens) = formula(tokens[1:])
            if tokens[0] == ')':
                return ({'Or':[e1,e2]}, tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'and' and tokens[1] == '(':
        (e1, tokens) = formula(tokens[2:])
        if tokens[0] == ',':
            (e2, tokens) = formula(tokens[1:])
            if tokens[0] == ')':
                return ({'And':[e1,e2]}, tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'equal' and tokens[1] == '(':
        (e1, tokens) = term(tokens[2:])
        if tokens[0] == ',':
            (e2, tokens) = term(tokens[1:])
            if tokens[0] == ')':
                return ({'Equal':[e1,e2]}, tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'greater' and tokens[1] == 'than' and tokens[2] == '(':
        (e1, tokens) = term(tokens[3:])
        if tokens[0] == ',':
            (e2, tokens) = term(tokens[1:])
            if tokens[0] == ')':
                return ({'GreaterThan':[e1,e2]}, tokens[1:])

    tokens = tmp[0:]
    if tokens[0] == 'less' and tokens[1] == 'than' and tokens[2] == '(':
        (e1, tokens) = term(tokens[3:])
        if tokens[0] == ',':
            (e2, tokens) = term(tokens[1:])
            if tokens[0] == ')':
                return ({'LessThan':[e1,e2]}, tokens[1:])

 #question 3 added on
 #case for and
    tokens = tmp[0:]
    if tokens[0] =='(':
        r = formula(tokens[1:])
        if not r is None:
            (e1, tokens) = r
            if(tokens[0]=='&&'):
                (e2, tokens) = formula(tokens[1:])
                if(tokens[0]==')'):
                    return ({'And':[e1,e2]}, tokens[1:])

#case for ||
    tokens = tmp[0:]
    if tokens[0] =='(':
        r = formula(tokens[1:])
        if not r is None:
            (e1, tokens) = r
            if(tokens[0]=='||'):
                (e2, tokens) = formula(tokens[1:])
                if(tokens[0]==')'):
                    return ({'Or':[e1,e2]}, tokens[1:])

#case for ==
    tokens = tmp[0:]
    if tokens[0] =='(':
        r = term(tokens[1:])
        if not r is None:
            (e1, tokens) = r
            if(tokens[0]=='=='):
                (e2, tokens) = term(tokens[1:])

                if(tokens[0]==')'):
                    return ({'Equal':[e1,e2]}, tokens[1:])

#case for <
    tokens = tmp[0:]
    if tokens[0] =='(':
        r = term(tokens[1:])
        if not r is None:
            (e1, tokens) = r
            if(tokens[0]=='<'):
                (e2, tokens) = term(tokens[1:])
                if(tokens[0]==')'):
                    return ({'LessThan':[e1,e2]}, tokens[1:])

#case for >
    tokens = tmp[0:]
    if tokens[0] =='(':
        r = term(tokens[1:])
        if not r is None:
            (e1, tokens) = r
            if(tokens[0]=='>'):
                (e2, tokens) = term(tokens[1:])
                if(tokens[0]==')'):
                    return ({'GreaterThan':[e1,e2]}, tokens[1:])


#question 2d
def program(tmp):
    top = False
    #case for print formula
    tokens = tmp[0:]
    if tokens[0] == 'print':
        tokens = tokens[1:]
        if tokens[0] == 'true' or tokens[0] == 'false' or  tokens[0] == 'not' or tokens[0] == 'and' or tokens[0] == 'or' or tokens[0] == 'equal' or tokens[0] == 'less' or tokens[0] == 'greater' or tokens[0] == '(':
            r = formula(tokens)
            if not r is None:
                (e1, tokens) = r
                if tokens[0] == ';':
                    tokens = tokens[1:]
                    r = program (tokens)
                    if r is not None:
                        (e2, tokens) = r
                        if not top or len(tokens)==0:
                            return ({'Print':[e1,e2]}, [])
                            tokens = tmp[0:]

    #case for end
    tokens=tmp[0:]
    if tokens[0] == 'end' and tokens[1] == ';':
        tokens = tokens[2:]
        if not top or len(tokens)==0:
            return ('End',tokens)

    #case for print term
    token = tmp[0:]
    if tokens[0] == 'print':
        tokens = tokens[1:]
        r = term(tokens)
        if not r is None:
            (e1, tokens) = r
            if tokens[0] == ';':
                tokens = tokens[1:]
                r = program(tokens)
                if r is not None:
                    (e2, tokens) = r
                    if not top or len(tokens)==0:
                        return ({'Print':[e1,e2]}, tokens)

#case for assign
    tokens = tmp[0:]
    if tokens[0] == 'assign':
        if tokens[1] == '@':
            tokens = tokens[2:]
            r = variable(tokens)
            if not r is None:
                (e1, tokens) = r
                if tokens[0] == ':=':
                    tokens = tokens[1:]

                    r = term(tokens)
                    if not r is None:
                        (e2, tokens) = r 
                        if tokens[0] == ";":
                            tokens = tokens[1:]
                            r = program(tokens)
                            if r is not None:
                                (e3, tokens) = r
                                if not top or len(tokens)==0:
                                    return ({'Assign':[e1,e2,e3]}, tokens)

#question 2e
def complete(tokens):
    listOfTerminals = ['print', 'assign','@','end','#',';',':=','true','false','not','(',')',',','and','or','equal','less','than','greater','plus','mult','log','&&','||','+','*','==','<','>']
    return program(tokenize(listOfTerminals, tokens))

