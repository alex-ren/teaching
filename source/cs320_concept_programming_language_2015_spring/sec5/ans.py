from machine import *

init1 = ["set 8 100"]

ans1 = ["set 3 8", \
        "set 4 1", \
        "copy", \
        "set 2 1", \
        "add", \
        "set 3 0", \
        "set 4 8", \
        "copy"]

def copy(src, dst):
    return ["set 3 " + str(src), \
            "set 4 " + str(dst), \
            "copy"]

ans1a = copy(8, 1) + \
        ["set 2 1", \
         "add" ] + \
         copy(0, 8)

def increment(addr):
    return copy(addr, 1) + \
        ["set 2 1", \
         "add" ] + \
         copy(0, addr)

def decrement(addr):
    return copy(addr, 1) + \
        ["set 2 -1", \
         "add" ] + \
         copy(0, addr)

def addto(src, dst):
    return copy(src, 1) + \
           copy(dst, 2) + \
           ["add"] + \
           copy(0, dst)

print simulate(init1 + ans1)
print simulate(init1 + ans1a)
print simulate(init1 + decrement(8))

ans2 = ["set 9 0"] + \
        copy(8, 10) + \
        ["label start", \
        "branch loop 10", \
        "goto end", \
        "label loop"] + \
        addto(10, 9) + \
        decrement(10) + \
        ["goto start", \
        "label end"]

init2 = ["set 8 100"]
print simulate(init2 + ans2)

init3 = ["set 7 -1", \
         "set 8 5"]

ans3 = [ "goto printx_end", \
         "label printx_start", \
         "branch printx_skip 8", \
         "goto printx_return", \
         "label printx_skip",
         "set 5 100"] + \
         decrement(8) + \
         decrement(7) + \
         ["set 3 6", \
          "set 4 1", \
          "copy", \
          "set 2 9", \
          "add"] + \
          copy(7, 4) + \
          ["set 3 0", \
           "copy"] + \
          ["goto printx_start"] + \
          increment(7) + \
          ["label printx_return"] + \
           copy(7, 3) + \
          ["set 4 4", \
           "copy", \
           "jump 4", \
           "label printx_end"] + \
          \
         decrement(7) + \
         ["set 3 6", \
          "set 4 1", \
          "copy", \
          "set 2 9", \
          "add"] + \
          copy(7, 4) + \
          ["set 3 0", \
           "copy"] + \
          ["goto printx_start"] + \
          increment(7)

print simulate(init3 + ans3)

def procedure(name, body):
    return [ "goto " + name + "_end", \
         "label " + name + "_start"] + \
         body + \
         copy(7, 3) + \
         ["set 4 4", \
          "copy", \
          "jump 4", \
          "label " + name + "_end"]

def call(name):
    return decrement(7) + \
         ["set 3 6", \
          "set 4 1", \
          "copy", \
          "set 2 9", \
          "add"] + \
          copy(7, 4) + \
          ["set 3 0", \
           "copy"] + \
          ["goto " + name + "_start"] + \
          increment(7)

body =  ["branch printx_skip 8", \
         "goto printx_return", \
         "label printx_skip",
         "set 5 100"] + \
         decrement(8) + \
         call("printx") + \
         ["label printx_return"]

init4 = ["set 7 -1", \
         "set 8 5"]
ans4 = procedure("printx", body) + call("printx")

print simulate(init4 + ans4)


         













