class InstrumentsSolverService
  def initialize(application:, answer_points: nil)
    @application = application
    @answer_points = answer_points
    @status = @application.status
  end

  def call
    return if @application.finished?

    start_application
    save_score if @answer_points.present?
  end

  private

  def start_application
    @application.in_progress!
  end

  def calculate_score
    @answer_points.values.map{|answer_point| answer_point.to_i}.sum
  end

  def save_score
    @application.update(score: calculate_score)
    end_application
  end

  def end_application
    @application.finished! 
  end
end