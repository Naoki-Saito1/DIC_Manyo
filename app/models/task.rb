class Task < ApplicationRecord
  belongs_to :user, optional: true
  validates :task_name, presence: true
  validates :content, presence: true
  enum status:{未着手:0,着手中:1,完了:2}
  enum priority:{高:0,中:1,低:2}
  validate :date_before_start
  scope :task_name, ->  (task_name){where('task_name LIKE ?', "%#{task_name}%")}
  scope :status, ->(status) {where(status: status)}
  # def self.task_name(search)
  #   if search
  #     task_name.where(["task_name LIKE ?", %#{keyword}%])
  
  def date_before_start
    unless limit == nil
    errors.add(:limit, "は今日以降のものを選択してください") if limit < Date.today
                                                       end
    end
  end