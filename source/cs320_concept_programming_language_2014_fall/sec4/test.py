

import unittest

from parse import *

class NumberTestCase(unittest.TestCase):
    def test_1(self):
        self.assertEqual(123, number(["123"])[0])

    def test_negtive(self):
        self.assertEqual(-123, number(["-123"])[0])

    def test_zero(self):
        self.assertEqual(0, number(["0"])[0])

class VariableTestCase(unittest.TestCase):
    def test_1(self):
        s = "abc"
        self.assertEqual(s, variable([s])[0])

    def test_2(self):
        s = "aAdfe1"
        self.assertEqual(s, variable([s])[0])

    def test_3(self):
        s = "A"
        self.assertEqual(None, variable([s]))

class FormulaTestCase(unittest.TestCase):
    def test_left_asso(self):
        s = ["x", "xor", "true", "xor", "y"]
        t = {"XOR": [{"XOR": [{"Variable": ["x"]}, "True"]}, {"Variable": ["y"]}]}
        self.assertEqual(t, formula(s)[0])

    def test_invalid(self):
        s = ["x", "xor", "true", "xor", "y", "3"]
        t = {"XOR": [{"XOR": [{"Variable": ["x"]}, "True"]}, {"Variable": ["y"]}]}
        self.assertEqual(None, formula(s))

class FactorTestCase(unittest.TestCase):
    def test_left_asso(self):
        s = ["x", "*", "1", "*", "y"]
        t = {"Mult": [{"Mult": [{"Variable": ["x"]}, {"Number": [1]}]}, {"Variable": ["y"]}]}
        self.assertEqual(t, factor(s)[0])

    def test_invalid(self):
        s = ["x", "*", "1", "*", "y", "0"]
        t = {"Mult": [{"Mult": [{"Variable": ["x"]}, {"Number": [1]}]}, {"Variable": ["y"]}]}
        self.assertEqual(None, factor(s))

class TermTestCase(unittest.TestCase):
    def test_add(self):
        s = ["x", "+", "1"]
        t = {"Plus": [{"Variable": ["x"]}, {"Number": [1]}]}
        self.assertEqual(t, term(s)[0])

    def test_mul(self):
        s = ["x", "*", "1"]
        t = {"Mult": [{"Variable": ["x"]}, {"Number": [1]}]}
        self.assertEqual(t, term(s)[0])

    # def test_div(self):
    #     s = ["x", "/", "1"]
    #     t = {"Div": [{"Variable": ["x"]}, {"Number": [1]}]}
    #     self.assertEqual(t, term(s)[0])

    def test_eq(self):
        s = ["x", "==", "1"]
        t = {"Eq": [{"Variable": ["x"]}, {"Number": [1]}]}
        self.assertEqual(t, term(s)[0])

    def test_lessthan(self):
        s = ["x", "<", "1"]
        t = {"LessThan": [{"Variable": ["x"]}, {"Number": [1]}]}
        self.assertEqual(t, term(s)[0])

    def test_right_asso(self):
        s = ["x", "+", "1", "+", "y"]
        t = {"Plus": [{"Variable": ["x"]}, {"Plus": [{"Number": [1]}, {"Variable": ["y"]}]}]}
        self.assertEqual(t, term(s)[0])

    def test_invalid(self):
        s = ["x", "+", "1", "+", "y", "0"]
        t = {"Plus": [{"Variable": ["x"]}, {"Plus": [{"Number": [1]}, {"Variable": ["y"]}]}]}
        self.assertEqual(None, term(s))

class ProgramTestCase(unittest.TestCase):
    def test_if(self):
        s = ["if", "1", "<", "x", "{", \
                 "print", "x", "+", "y", ";", "print", "false", ";", \
             "}", \
             "print", "true", "xor", "false", ";", "print", "1", ";", \
             ]
        t = {"If": [ \
               {"LessThan": [ \
                   {"Number": [1]},  \
                   {"Variable": ["x"]} \
               ]}, \
               {"Print": [ \
                   {"Plus": [ \
                       {"Variable": ["x"]}, \
                       {"Variable": ["y"]} \
                   ]}, \
                   {"Print": [ \
                       "False", \
                       "End" \
                   ]} \
               ]}, \
               {"Print": [ \
                   {"XOR": ["True", "False"]}, \
                   {"Print": [ \
                       {"Number": [1]},
                       "End" \
                   ]} \
               ]} \
            ]}

        self.assertEqual(t, program(s)[0])

class TokenizeTestCase(unittest.TestCase):
    def test_1(self):
        x = "if 1 < x {" \
                "print x + y; print false;" \
            "}" \
            "print true xor false; print 1;"
        s = ["if", "1", "<", "x", "{", \
                 "print", "x", "+", "y", ";", "print", "false", ";", \
             "}", \
             "print", "true", "xor", "false", ";", "print", "1", ";", \
             ]
        self.assertEqual(s, tokenize(x))

# def getTestSuite():
#     tloader = unittest.TestLoader()
#     suite1 = tloader.loadTestsFromTestCase(NumberTestCase)
#     suite2 = tloader.loadTestsFromTestCase(VariableTestCase)
# 
#     suite = unittest.TestSuite()
#     suite.addTest(suite1)
#     suite.addTest(suite2)
#     return suite
# 
# def main():
#     runner = unittest.TextTestRunner()
#     runner.run(getTestSuite())
# 
# 
# if __name__ == '__main__':
#     main()


