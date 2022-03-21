# Unity::DependencyContainer

Simple thread-safe dependency injection.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unity-dependency-container'
```

## Usage

```ruby
class CalculatorService
  def sum(a, b)
    a + b
  end
end

module Foo
  extend Unity::DependencyContainer

  dependency 'services.calculator' do
    CalculatorService.new
  end

  # you can also use Symbol as dependencies' names
  dependency :calculator do
    CalculatorService.new
  end
end

a = Foo.di('services.calculator').sum(1, 2)
b = Foo.with_dependency('services.calculator') do |dep|
  dep.sum(1, 2)
end
c = Foo.with_dependency(:calculator) { |dep| dep.sum(1, 2) }

puts a # => 3
puts b # => 3
puts c # => 3
```
