import unittest

# some really important comment
class NumbersTest(unittest.TestCase):

    def test_equal(self):
        self.assertEqual(1 + 1, 1)

if __name__ == '__main__':
    unittest.main()
