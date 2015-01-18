


def both1(s1, s2, e):
    if (contains(s1, e) and contains(s2, e)):
        return True
    else:
        return False

def both2(s1, s2, e):
    if (s1.contains(e) and s2.contains(e)):
        return True
    else:
        return False

# ******************************************* #

def both(s1, s2, e):
    if (s1.get_type().contains(s1, e) and s2.get_type().contains(s2, e)):
        return True
    else:
        return False

class SetList(object):
    @staticmethod
    def empty():
        return SetList()

    @staticmethod
    def insert(s, e):
        if (s.m_lst == None):
            return SetList([e])
        else:
            return SetList([e] + s.m_lst)

    @staticmethod
    def contains(s, e):
        return e in s.m_lst

    def __init__(self, lst=None):
        self.m_lst = lst

    def get_type(self):
        return SetList

s1 = SetList.empty()
s2 = SetList.insert(s1, 1)
s3 = SetList.insert(s2, 2)

b = SetList.contains(s3, 2)
print b
b = SetList.contains(s3, 3)
print b

class SetTree(object):
    @staticmethod
    def empty():
        return SetTree()

    @staticmethod
    def insert(s, e):
        if (s.m_node == None):
            return SetTree((e, SetTree(), SetTree()))
        else:
            node = s.m_node
            if e < node[0]:
                sl = SetTree.insert(node[1], e)
                return SetTree((node[0], sl, node[2]))
            else:
                sr = SetTree.insert(node[2], e)
                return SetTree((node[0], node[1], sr))

    @staticmethod
    def contains(s, e):
        node = s.m_node
        if (node == None):
            return False
        elif e == node[0]:
            return True
        elif e < node[0]:
            return SetTree.contains(node[1], e)
        else:
            return SetTree.contains(node[2], e)

    def __init__(self, node=None):
        self.m_node = node

    def get_type(self):
        return SetTree

s21 = SetTree.empty()
s22 = SetTree.insert(s21, 1)
s23 = SetTree.insert(s22, 3)

b = SetTree.contains(s23, 3)
print b
b = SetTree.contains(s23, 4)
print b

b = both(s3, s23, 1)
print b
b = both(s3, s23, 2)
print b















