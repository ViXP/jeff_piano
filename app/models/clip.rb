require 'streamio-ffmpeg'

class Clip < ApplicationRecord
  # Attributes
  self.primary_key = :number

  # Associations
  has_many :recording_clips, dependent: :destroy
  has_many :recordings, -> { distinct }, through: :recording_clips

  # Validations
  validates :number, :url, presence: true, uniqueness: true
  validates :number, numericality: { only_integer: true, greater_than: 0 }
  validates :url,
            format: { with: %r{\A(http://|https://).*(.mp4|.avi|.mov)\z}i }

  # Callbacks
  after_validation :count_duration

  # Scopes
  default_scope { order(number: :asc) }

  private

  def count_duration
    return false if url.blank?
    count = (FFMPEG::Movie.new(url).duration * 1000).to_i
    self.duration = count.is_a?(Numeric) ? count : 0
  rescue Errno::ENOENT
    errors[:base] << 'Wrong url, or file format'
  end
end
