
class Vehicle:
    def __init__(self, make, model):
        self.make = make
        self.model = model

    def move(self):
        return "Move!"

    def __str__(self):
        return f"{self.make} {self.model}"

class Car(Vehicle):
    def move(self):
        return "Drive!"

class Boat(Vehicle):
    def move(self):
        return "Sail!"

class Plane(Vehicle):
    def move(self):
        return "Fly!"

    

# Main program starts here
if __name__ == "__main__":
    vehicle = Vehicle("Generic", "Vehicle")
    car = Car("Ford", "Mustang")
    boat = Boat("Ibiza", "Touring 20")
    plane = Plane("Boeing", "747")
    for v in [vehicle, car, boat, plane]:
        print(str(v), v.move())


# Úttak / Ouput:
# Generic Vehicle Move!
# Ford Mustang Drive!
# Ibiza Touring 20 Sail!
# Boeing 747 Fly!