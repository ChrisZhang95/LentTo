class Transaction < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :end_date, presence: true
    validates :start_date, presence: true
    validate :end_date_after_start_date?
    validate :overlaps?
    PENDING = 1
    IN_PROGRESS = 2
    ACCEPTED = 3
    REJECTED = 4
    COMPLETED = 5
    CANCELLED = 6

    STATUSES = {
        PENDING => 'Pending',
        IN_PROGRESS => 'In Progress',
        ACCEPTED => 'Accepted',
        REJECTED => 'Rejected',
        COMPLETED => 'Completed',
        CANCELLED => 'Cancelled'
    }


    def end_date_after_start_date?
        if end_date && start_date
            if end_date < start_date
                errors.add :end_date, "must be after start date"
            end
        end
    end

    # just a helper method for the view
    def status_name
        STATUSES[status.to_i]
    end

    def dateRanges
        dates = Transaction.where(["(status = ? OR status = ?) AND (item_id = ?)", Transaction::IN_PROGRESS, Transaction::ACCEPTED, item_id]).select(:start_date, :end_date)
    end

    def overlaps?
        date_ranges = dateRanges
        for date in dateRanges
            if start_date <= date.end_date && date.start_date <= end_date
                next
            else
                errors.add :end_date, "date overlaps please select another date"
            end
        end
    end
end
