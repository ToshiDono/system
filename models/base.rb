class Base
  def address(_id)
    fail NotImplementedError, 'implement in child class'
  end
end
