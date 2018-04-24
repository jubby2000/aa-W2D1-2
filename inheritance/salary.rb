require 'byebug'
class Employee
  def initialize(title, name, salary, boss)
    @title = title
    @name = name
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus_salary = salary * multiplier
  end

  def get_salary
    salary
  end

  def get_employee
    []
  end


  private
  attr_reader :title, :name, :salary, :boss
end

class Manager < Employee
  def initialize(title, name, salary, boss, employees=[])
    super(title, name, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)

    all_employees = get_employees
    sum = 0
    all_employees.each do |employee|
      if employee.is_a?(Manager)
        sum += employee.bonus(multiplier)
      end
      sum += employee.get_salary * multiplier
    end
    sum
  end

  def add_employees(subs)
    @employees.concat(subs)
  end

  def get_employees
    @employees
  end

  def inspect
    "#{name}"

  end

  private
  attr_reader :name
end


if __FILE__ == $0
  ned = Manager.new("Founder", "Ned", 1000000, nil)
  darren = Manager.new("Manager", "Darren", 78000, ned)
  shawna = Employee.new("TA", "Shawna", 12000, darren)
  david = Employee.new("TA", "David", 10000, darren)

  darren.add_employees([shawna, david])
  ned.add_employees([darren])

  p ned.bonus(5) # => 500_000
  p darren.bonus(4) # => 88_000
  p david.bonus(3) # => 30_000
end
