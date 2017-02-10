class CreateMontageJob < ApplicationJob
  queue_as :default

  def perform(line)
    line.create_montage
  end
end
