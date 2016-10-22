from django.test import TestCase

# Create your tests here.


class HomeTestCase(TestCase):
    def test_home_page(self):
        self.assertTrue("Faltu test case")
