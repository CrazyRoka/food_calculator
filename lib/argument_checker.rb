module ArgumentChecker
  def self.check(arg_value, arg_name, opt = {})
    case
    when opt[:type] && !arg_value.is_a?(opt[:type])
      raise ArgumentError, "#{arg_name} must be a #{opt[:type]}"
    when opt[:not_empty] && arg_value.empty?
      raise ArgumentError, "#{arg_name} must not be empty"
    when opt[:positive] && arg_value <= 0
      raise ArgumentError, "#{arg_name} must be positive"
    when opt[:non_negative] && arg_value < 0
      raise ArgumentError, "#{arg_name} must not be negative"
    end
  end
end
