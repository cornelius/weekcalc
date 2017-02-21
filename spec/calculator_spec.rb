require_relative "spec_helper"

describe Calculator do
  it "calculates weeks for dates" do
    input = <<EOT
1969-12-01 Birth
1969-12-07 End of first week
1969-12-08 Start of second week
1969-12-24 First Christmas
1969-12-31 First new year's eve
1970-01-01 First new year
1970-12-01 First birthday
1980-11-30 Day before birthday
2017-02-21 Today
EOT
    expected_output = <<EOT
Year Week Event
---------------
00   01   Birth
00   01   End of first week
00   02   Start of second week
00   04   First Christmas
00   05   First new year's eve
00   05   First new year
01   01   First birthday
10   52   Day before birthday
47   11   Today
EOT

    expect(subject.process_text(input)).to eq(expected_output)
  end

  describe "#calculate_year_and_week" do
    before do
      subject.start_date = Date.parse("1969-12-01")
    end

    it "calculates start" do
      expect(subject.calculate_year_and_week(Date.parse("1969-12-01"))).to eq([0,1])
    end

    it "calculates new year" do
      expect(subject.calculate_year_and_week(Date.parse("1970-01-01"))).to eq([0,5])
    end

    it "caclulates day before birthday" do
      expect(subject.calculate_year_and_week(Date.parse("1980-11-30"))).to eq([10,52])
    end

    it "calculates today" do
      expect(subject.calculate_year_and_week(Date.parse("2017-02-21"))).to eq([47,11])
    end
  end
end
