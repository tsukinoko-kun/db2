from django.db import models


class Device(models.Model):
    make = models.CharField(max_length=200)
    model = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    inventory_id = models.CharField(max_length=200)
    purchased_at = models.DateField()

    def isRented(self):
        return self.rental_set.filter(returned_at__isnull=True).count() > 0


class User(models.Model):
    class Role(models.IntegerChoices):
        USER = 0
        ADMIN = 99
    name = models.CharField(max_length=200)
    role = models.IntegerField(choices=Role.choices, default=Role.USER)


class Rental(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    due_at = models.DateTimeField()
    returned_at = models.DateTimeField(null=True)
    device = models.ForeignKey(Device, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def isReturned(self):
        return self.returned_at is not None
