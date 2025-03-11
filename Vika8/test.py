class Employee:
    company = "TechCorp" # Class variable
    def __init__(self, name, salary):
        self.name = name # Instance variable
        self.salary = salary # Instance variable
# Creating instances
emp1 = Employee("Alice", 50000)
emp2 = Employee("Bob", 60000)
# Modifying emp1's salary and company

emp1.salary = 55000
emp1.company = "InnovateX"
# Printing values
print(emp1.name, emp1.salary, emp1.company)
print(emp2.name, emp2.salary, emp2.company)
print(Employee.company)