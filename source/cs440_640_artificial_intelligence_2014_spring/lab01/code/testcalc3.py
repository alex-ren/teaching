"""
NAME: Zhiqiang Ren
Discussion Session 1
CS440 / CS640 Artificial Intelligence
"""

from calc import Calculator

import unittest

class Calc0TestCase(unittest.TestCase):
    def setUp(self):
        self.calc = Calculator(0)
    def tearDown(self):
        self.calc = None

    def testAdd1(self):
        assert self.calc.add(1) == 1, "addition is wrong"
    
    def testAdd2(self):
        assert self.calc.add(2) == 2, "addition is wrong"

    def testSub(self):
        assert self.calc.sub(1) == -1, "substraction is wrong"

class Calc1TestCase(unittest.TestCase):
    def setUp(self):
        self.calc = Calculator(1)
    def tearDown(self):
        self.calc = None

    def testAdd1(self):
        assert self.calc.add(1) == 2, "addition is wrong"
    
    def testAdd2(self):
        assert self.calc.add(2) == 3, "addition is wrong"

    def testSub(self):
        assert self.calc.sub(1) == 0, "substraction is wrong"


def getTestSuite():
    suite1 = unittest.makeSuite(Calc0TestCase, "test")
    suite2 = unittest.makeSuite(Calc1TestCase, "test")

    suite = unittest.TestSuite()
    suite.addTest(suite1)
    suite.addTest(suite2)
    return suite


def main():
    runner = unittest.TextTestRunner()
    runner.run(getTestSuite())


if __name__ == '__main__':
    main()
    
