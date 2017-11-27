module Pagination
  def paginate(arr, p)
    if arr.length.zero?
      "no articles found"
    else
      if p == 1
        @display_start = 1
      else
        @display_start = p * 15 + 1
      end
      if arr.length > (@display_start + 15)
        @display_end = (p == 1 ? 15 : (p + 1)*15)
      else
        @display_end = arr.length.to_s
      end
      "article#{arr.length == 1 ? '' : 's'} #{@display_start} - #{@display_end} of #{arr.length} in total"
    end
  end
end
