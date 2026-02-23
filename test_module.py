import unittest
from mean_var_std import calculate


class UnitTests(unittest.TestCase):

    def test_calculate_with_list_of_nine(self):
        actual = calculate([0, 1, 2, 3, 4, 5, 6, 7, 8])
        expected = {
            'mean': [[3.0, 4.0, 5.0], [1.0, 4.0, 7.0], 4.0],
            'variance': [[6.0, 6.0, 6.0], [0.6666666666666666, 0.6666666666666666, 0.6666666666666666], 6.666666666666667],
            'standard deviation': [[2.449489742783178, 2.449489742783178, 2.449489742783178], [0.816496580927726, 0.816496580927726, 0.816496580927726], 2.581988897471611],
            'max': [[6, 7, 8], [2, 5, 8], 8],
            'min': [[0, 1, 2], [0, 3, 6], 0],
            'sum': [[9, 12, 15], [3, 12, 21], 36]
        }
        self.assertEqual(actual, expected, "Expected calculate() to return the correct dictionary for [0,1,2,3,4,5,6,7,8]")

    def test_calculate_with_few_digits(self):
        self.assertRaisesRegex(ValueError, "List must contain nine numbers.", calculate, [2, 6, 2, 8, 4, 0, 1])

    def test_calculate_mean(self):
        actual = calculate([2, 6, 2, 8, 4, 0, 1, 5, 7])
        expected_mean = [[3.6666666666666665, 5.0, 3.0], [3.3333333333333335, 4.0, 4.333333333333333], 3.888888888888889]
        self.assertEqual(actual['mean'], expected_mean, "Expected mean to be calculated correctly.")

    def test_calculate_variance(self):
        actual = calculate([9, 1, 5, 3, 3, 3, 2, 9, 0])
        expected_variance = [[8.666666666666666, 10.666666666666666, 4.222222222222222], [10.666666666666666, 0.0, 14.888888888888891], 9.209876543209875]
        self.assertEqual(actual['variance'], expected_variance, "Expected variance to be calculated correctly.")

    def test_calculate_standard_deviation(self):
        actual = calculate([9, 1, 5, 3, 3, 3, 2, 9, 0])
        expected_std = [[2.943920288775949, 3.265986323710904, 2.0548046676563256], [3.265986323710904, 0.0, 3.8586123009300755], 3.0347778408328137]
        self.assertEqual(actual['standard deviation'], expected_std, "Expected standard deviation to be calculated correctly.")

    def test_calculate_max(self):
        actual = calculate([9, 1, 5, 3, 3, 3, 2, 9, 0])
        expected_max = [[9, 9, 5], [9, 3, 9], 9]
        self.assertEqual(actual['max'], expected_max, "Expected max to be calculated correctly.")

    def test_calculate_min(self):
        actual = calculate([9, 1, 5, 3, 3, 3, 2, 9, 0])
        expected_min = [[2, 1, 0], [1, 3, 0], 0]
        self.assertEqual(actual['min'], expected_min, "Expected min to be calculated correctly.")

    def test_calculate_sum(self):
        actual = calculate([9, 1, 5, 3, 3, 3, 2, 9, 0])
        expected_sum = [[14, 13, 8], [15, 9, 11], 35]
        self.assertEqual(actual['sum'], expected_sum, "Expected sum to be calculated correctly.")


if __name__ == '__main__':
    unittest.main()