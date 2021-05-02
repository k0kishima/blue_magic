class ApplicationJob < ActiveJob::Base
  attr_writer :attempt_number

  def attempt_number
    @attempt_number ||= 0
  end

  def serialize
    super.merge('attempt_number' => attempt_number + 1)
  end

  def deserialize(job_data)
    super
    self.attempt_number = job_data['attempt_number']
  end
end
