require "date"

class Calculator
  attr_accessor :start_date

  def initialize
    @start_date = nil
  end

  def process_text(text)
    output = "Year Week Event\n"
    output += "---------------\n"
    text.each_line do |line|
      output += process_line(line)
    end
    output
  end

  def process_line(line)
    separator = line.index(" ")
    date_string = line[0..separator]
    event = line[separator..-1]
    date = Date.parse(date_string)
    @start_date ||= date
    year, week = calculate_year_and_week(date)
    sprintf("%02d   %02d  %s", year, week, event)
  end

  def calculate_year_and_week(date)
    year = date.year - @start_date.year
    week = (date.yday - @start_date.yday ) / 7 + 1
    return year, week
  end
end
