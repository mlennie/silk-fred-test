class CreateMontageJob < ApplicationJob
  queue_as :default

  def perform(line,total_lines)
    line.create_montage total_lines
  end
end
