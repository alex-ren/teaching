Node = dict
Leaf = str

def isStringType(ty):
    if ty == None:
        return False
    if ty == "Void":
        return False
    for label in ty:
        if label == "String":
            return True
        else: # Arrow
            return False 

def tyExpr(env, e):
   if type(e) == Node:
        for label in e:
            children = e[label]

            if label == "String":
                return {"String": [{"Number": [len(children[0])]}]}

            elif label == 'Variable':
                x = children[0]
                return env[x]

            elif label == "Concat":
                (e1, e2) = children
                tyE1 = tyExpr(env, e1)
                tyE2 = tyExpr(env, e2)
                if isStringType(tyE1) and isStringType(tyE2):
                    index1 = tyE1["String"][0]
                    index2 = tyE2["String"][0]
                    index = {"Add": [index1, index2]}
                    return {"String": [index]}

            elif label == 'Apply':
                 [f, eArg] = children
                 f = f['Variable'][0] # Unpack.
                 tyArg = tyExpr(env, eArg)
                 tyPara = env[f]['Arrow'][0]

                 if tyArg == tyPara:
                     return env[f]['Arrow'][1]
                 else:
                     print("not match")
                     print("tyArg is", tyArg)
                     print("tyPara is", tyPara)

                 if isStringType(tyArg) == False:
                     return None

                 tv0 = evalIndex(tyArg["String"][0])
                 tv1 = evalIndex(tyPara["String"][0])

                 if tv0 == tv1:
                     print("tv0 == tv1 ==", tv0)
                     return env[f]['Arrow'][1]
                 else:
                     print("not match")
                     print("tyArg evaluates to", tv0)
                     print("tyPara evaluates to", tv1)

        
def tyProg(env, s):
   if type(s) == Leaf:
        if s == 'End':
            return 'Void'
   elif type(s) == Node:
        for label in s:
            if label == 'Assign':
                [x,e,p] = s[label]
                x = x['Variable'][0] # Unpack.
                tExpr = tyExpr(env, e)
                env[x] = tExpr  # add to environment
                tProg = tyProg(env, p)
                if isStringType(tExpr) and tProg == 'Void': # checking
                    return 'Void'
            if label == 'Function':
                [f, tyArg, x, e, p] = s[label]
                if not isStringType(tyArg): # checking
                    print("type error, tyAry is", tyAry)
                    return None
                name = f['Variable'][0]
                x = x['Variable'][0]
                envF = env.copy()
                envF[x] = tyArg
                tBody = tyExpr(envF, e)
                if not isStringType(tBody): # checking
                    print("type error, tBody is", tBody)
                    return None
                env[name] = {'Arrow':[tyArg,tBody]}
                tProg = tyProg(env, p)
                if tProg == 'Void':
                    return tProg

def evalIndex(ti):
    for label in ti:
        if label == "Number":
            return ti[label][0]
        elif label == "Add":
            ti0 = ti[label][0]
            ti1 = ti[label][1]
            return evalIndex(ti0) + evalIndex(ti1)

def main():
    # function foo(string[6] x) {
    #   return x + x;
    # }
    # x = "abc"
    # y = "def"
    # z = foo(x + y)

    program = {"Function": [ {"Variable": ["foo"]} \
                           , {"String": [{"Number": [6]}]} \
                           , {"Variable": ["x"]} \
                           , {"Concat": [ {"Variable": ["x"]} \
                                        , {"Variable": ["x"]}]} \
                           , {"Assign": [ {"Variable": ["x"]} \
                                        , {"String": ["abc"]} \
                                        , {"Assign": [ {"Variable": ["y"]} \
                                                     , {"String": ["def"]} \
                                                     , {"Assign": [ {"Variable": ["z"]} \
                                                                  , {"Apply": [ {"Variable": ["foo"]} \
                                                                              , {"Concat": [ {"Variable": ["x"]} \
                                                                                           , {"Variable": ["y"]} ]} ]} \
                                                                  , "End" ]} ]} ]} ]}
    print(program)
    print()
    tyProg({}, program)


if __name__ == "__main__":
    main()

        
