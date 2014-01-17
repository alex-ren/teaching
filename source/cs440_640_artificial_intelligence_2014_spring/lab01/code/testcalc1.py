"""
NAME: Zhiqiang Ren
Discussion Session 1
CS440 / CS640 Artificial Intelligence
"""

from calc import Calculator

import unittest

class Calc0TestCaseAdd(unittest.TestCase):
    def runTest(self):
        calc = Calculator(0)
        assert calc.add(1) == 1, "addition is wrong"
    

class Calc0TestCaseSub(unittest.TestCase):
    def runTest(self):
        calc = Calculator(0)
        assert calc.sub(1) == -1, "substraction is wrong"


def getTestSuite():
    suite = unittest.TestSuite()
    suite.addTest(Calc0TestCaseAdd())
    suite.addTest(Calc0TestCaseSub())
    return suite


def main():
    runner = unittest.TextTestRunner()
    runner.run(getTestSuite())


if __name__ == '__main__':
    main()
    


