# Author: Zhiqiang Ren
# Date: 02/18/2015

def reg_match(reg, exp):
    node = (exp, reg, [])
    return search([node])

def search(nodes):
    while (not nodes_is_empty(nodes)):
        node = nodes_get_node(nodes)
        # print "node is", node

        if (node_is_sol(node)):
            return True

        new_nodes = node_get_next(node)
        nodes = nodes_add(nodes[1:], new_nodes)

    return False
    

# implement nodes as a stack
def nodes_is_empty(nodes):
    return len(nodes) == 0

def nodes_get_node(nodes):
    return nodes[0]

def nodes_add(nodes, new_nodes):
    return nodes + new_nodes


# node: (exp, cur_reg, rest_regs)
def node_is_sol(node):
    (exp, cur_reg, rest_regs) = node
    if (exp == "" and cur_reg == None and rest_regs == []):
        return True
    else:
        return False

def node_get_next(node):
    (exp, cur_reg, rest_regs) = node
    if (cur_reg == None):
        return []

    if (type(cur_reg) == str):  # Terminal
        if ("Any" == cur_reg):
            if (len(exp) <= 0):
                return []
            else:
                if (len(rest_regs) > 0):
                    return [(exp[1:], rest_regs[0], rest_regs[1:])]
                else:
                    return [(exp[1:], None, [])]
        else:
            raise NotImplementedError(cur_reg + " is not supported")

    elif (type(cur_reg) == dict):
        [(label, children)] = cur_reg.items()
        if ("Char" == label):
            ch = children[0]
            if (len(exp) <= 0):
                return []
            else:
                if (exp[0] == ch):
                    if (len(rest_regs) > 0):
                        return [(exp[1:], rest_regs[0], rest_regs[1:])]
                    else:
                        return [(exp[1:], None, [])]
                else:
                    return []

        elif ("Cat" == label):
            reg1 = children[0]
            reg2 = children[1]
            return [(exp, reg1, [reg2] + rest_regs)]

        elif ("Alt" == label):
            reg1 = children[0]
            reg2 = children[1]

            return [(exp, reg1, rest_regs), (exp, reg2, rest_regs)]

        elif ("Opt" == label):
            reg = children[0]

            if (len(rest_regs) > 0):
                new_node = (exp, rest_regs[0], rest_regs[1:])
            else:
                new_node = (exp, None, rest_regs[1:])
            
            return [(exp, reg, rest_regs), new_node]

        elif ("Star" == label):
            reg = children[0]
            num = children[1]

            if (num == len(exp)):
                return []

            # empty
            if (len(rest_regs) > 0):
                node1 = (exp, rest_regs[0], rest_regs[1:])
            else:
                node1 = (exp, None, rest_regs[1:])

            new_star = {"Star": [reg, len(exp)]}
            node2 = (exp, reg, [new_star] + rest_regs)

            return [node1, node2]
        else:
            raise NotImplementedError(label + " is not supported")

    else:
        raise NotImplementedError(str(type(cur_reg)) + " is not supported")


if __name__ == "__main__":
    reg_a = {"Char": ["a"]}
    reg_b = {"Char": ["b"]}
    reg_c = {"Char": ["c"]}
    reg_ab = {"Cat": [reg_a, reg_b]}
    reg_a_b = {"Alt": [reg_a, reg_b]}
    reg_ao = {"Opt": [reg_a]}
    reg_any = "Any"

    reg_as = {"Star": [reg_a, -1]}
    reg_ass = {"Star": [reg_as, -1]}

    # ret = reg_match(reg_a, "a")
    # print "=== ret is ", ret
    # ret = reg_match(reg_b, "b")
    # print "=== ret is ", ret
    # ret = reg_match(reg_ab, "ab")
    # print "=== is ", ret
    # ret = reg_match(reg_a_b, "a")
    # print "=== is ", ret
    # ret = reg_match(reg_a_b, "b")
    # print "=== is ", ret
    # ret = reg_match(reg_any, "ba")
    # print "=== is ", ret
    # ret = reg_match(reg_ao, "a")
    # print "=== is ", ret
    # ret = reg_match(reg_as, "")
    # print "=== is ", ret
    # ret = reg_match(reg_ass, "aaaaa")
    # print "=== is ", ret

    # (a|b)*
    reg1 = {"Star": [reg_a_b, -1]}
    # (a|b)*c
    reg2 = {"Cat": [reg1, reg_c]}
    # ((a|b)*c)*
    reg3 = {"Star": [reg2, -1]}
    ret = reg_match(reg3, "aabaabaccccaaaaaaaabbccc")
    print "=== is ", ret





