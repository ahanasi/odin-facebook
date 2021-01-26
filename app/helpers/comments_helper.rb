module CommentsHelper
end

def short_age_string(time)
  diff = Time.now - time # value is seconds (float)
  diff = diff.abs.to_i
  if diff >= 604_800 # seconds in a week
    weeks = diff / 604_800
    "#{weeks}#{'+' if weeks >= 999}w"
  elsif diff > 3600 # seconds in an hour
    "#{diff / 3600}h"
  else
    "#{diff / 60}m"
  end
end
