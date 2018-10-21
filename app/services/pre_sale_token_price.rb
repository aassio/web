class PreSaleTokenPrice

  ETH_TO_USD = 200.0

  PRICE_TABLE = {
      Date.new(2018,11,1) => {
          price: 0.1,
          discount: 0.2
      },
      Date.new(2018,11,8) => {
          price: 0.1,
          discount: 0.1896
      },
      Date.new(2018,11,15) => {
          price: 0.1,
          discount: 0.1790
      },
      Date.new(2018,11,22) => {
          price: 0.1,
          discount: 0.1681
      },
      Date.new(2018,11,29) => {
          price: 0.1,
          discount: 0.1568
      },
      Date.new(2018,12,6) => {
          price: 0.1,
          discount: 0.1453
      },
      Date.new(2018,12,13) => {
          price: 0.1,
          discount: 0.1334
      },
      Date.new(2018,12,20) => {
          price: 0.1,
          discount: 0.1213
      },
      Date.new(2018,12,27) => {
          price: 0.1,
          discount: 0.1087
      },
      Date.new(2019,1,3) => {
          price: 0.1,
          discount: 0.0958
      },
      Date.new(2019,1,10) => {
          price: 0.1,
          discount: 0.0826
      },
      Date.new(2019,1,17) => {
          price: 0.1,
          discount: 0.0689
      },
      Date.new(2019,1,24) => {
          price: 0.1,
          discount: 0.0548
      },
      Date.new(2019,1,31) => {
          price: 0.1,
          discount: 0.0403
      },
      Date.new(2019,2,7) => {
          price: 0.1,
          discount: 0.0253
      },
      Date.new(2019,2,14) => {
          price: 0.1,
          discount: 0.0099
      },
      Date.new(2019,2,21) => {
          price: 0.1,
          discount: 0.0000
      },
  }

  # Returns price discount on specific date
  def price_on(date)
    dates = PRICE_TABLE.keys.sort
    if date <= dates.first
      date = dates.first
    elsif date >= dates.last
      date = dates.last
    else
      # Find correct interval start date
      dates.each_with_index do |_date, index|
        if date >= _date && dates[index + 1] > date
          date = _date
        end
      end
    end
    PRICE_TABLE[date]
  end

  # Return amount of AAS on specific date for sum of ETH
  # @param [Date] date
  # @param [Numeric] eth
  # @return AAS
  def aas_tokens_for_eth(date, eth)
    price_row = price_on(date)
    (eth * ETH_TO_USD / ( price_row[:price] * (1 - price_row[:discount]) )).ceil
  end

end
