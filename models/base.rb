class Base

  def address(id)
    fail NotImplementedError, 'implement in child class'
  end
end