"""
NAME: Zhiqiang Ren
Discussion Session 1
CS440 / CS640 Artificial Intelligence
"""

class Calculator(object):
    """A simple calculator for integers."""

    def __init__(self, x):
        self.x = x

    def add(self, x):
        ret = self.x + x
        self.x = x
        return ret

    def sub(self, x):
        ret = self.x - x
        self.x = x
        return ret

    def mul(self, x):
        ret = self.x * x
        self.x = x
        return ret

    def div(self, x):
        ret = self.x / x
        self.x = x
        return ret


