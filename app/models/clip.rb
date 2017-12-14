class Clip < ApplicationRecord
  self.primary_key = :number

  # Associations
  has_many :recording_clips, dependent: :destroy
  has_many :recordings, -> { distinct }, through: :recording_clips

  before_validation :find_duration

  private

  def find_duration
    
  end
end
