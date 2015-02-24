class Employee
  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  def initialize(name, title, salary, employees, boss = nil)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    sum = 0
    @employees.each do |employee|
      if employee.is_a? Manager
        sum += employee.salary + employee.bonus(1)
      else
        sum += employee.salary
      end
    end
    sum * multiplier
  end
end
