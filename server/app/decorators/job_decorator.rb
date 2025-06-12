class JobDecorator < Draper::Decorator

  delegate_all

  def formatted_salary
    "Up to #{salary}"
  end

end
