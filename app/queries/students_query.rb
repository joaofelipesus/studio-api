# frozen_string_literal: true

class StudentsQuery < BaseQuery
  def base_relation
    Student.all
  end

  def call
    joins
    apply_filters
    order
    paginate
    {
      students: @relation,
      meta: {
        total_pages:,
        current_page:
      }
    }
  end

  private

  attr_reader :params

  def apply_filters
    filter_by_name
    filter_by_personal
  end

  def order
    @relation = @relation.order(name: :asc)
  end

  def filter_by_name
    return if params[:name].blank?

    @relation = @relation.where('students.name ILIKE ?', "%#{params[:name]}%")
  end
end
