from django.test import TestCase
from django.utils import dateparse
from .models import *

ALL_FIXTURES = [
    "devices.json",
    "rentals.json",
    "users.json"
]


class DeviceTests(TestCase):
    fixtures = ALL_FIXTURES

    def test_get(self):
        ipad = Device.objects.get(pk=1)
        self.assertEqual(ipad.make, "Apple")
        self.assertEqual(ipad.model, "iPad Pro")
        self.assertEqual(ipad.location, "E123")
        self.assertEqual(ipad.inventory_id, "apple_ipad_pro_1")
        self.assertEqual(ipad.purchased_at, dateparse.parse_date("2022-04-26"))

    def test_rented_status(self):
        ipad = Device.objects.get(pk=1)
        pixel = Device.objects.get(pk=2)

        self.assertTrue(ipad.isRented())
        self.assertFalse(pixel.isRented())


class UserTests(TestCase):
    fixtures = ALL_FIXTURES

    def test_get(self):
        alice = User.objects.get(pk=1)
        self.assertEqual(alice.name, "Alice")
        self.assertEqual(alice.role, User.Role.USER)


class RentalTests(TestCase):
    fixtures = ALL_FIXTURES

    def test_get(self):
        alice = User.objects.get(pk=1)
        ipad = Device.objects.get(pk=1)
        rental = Rental.objects.get(pk=1)

        # user associations
        self.assertEqual(rental.user, alice)
        self.assertEqual(alice.rental_set.first(), rental)

        # device associations
        self.assertEqual(rental.device, ipad)
        self.assertEqual(ipad.rental_set.first(), rental)

    def test_returend_status(self):
        rental = Rental.objects.get(pk=1)
        self.assertFalse(rental.isReturned())
