const String getStocksQuery = """
      query JittaRanking(\$filter: RankingInput) {
        jittaRanking(filter: \$filter) {
     count
    data {
      stockId
      jittaScore
      rank
      updatedAt
      id
      nativeName
      latestPriceDiff {
        id
        year
        month
        quarter
        day
        value
        type
        percent
      }
      exchange
      sector {
        id
        name
      }
      industry
      name
      symbol
      market
      latestPrice
      graphs {
        linePrice
        stockPrice
      }
      firstGraphqlPeriod
      status
      latestLossChance
      currency
      jittaRankScore
      title
    }
        }
        availableCountry {
    code
    name
    flag
  }
      }
    """;

const String getStocksDetailQuery = """
      query Stock(\$stockId: String) {
  stock(id: \$stockId) {
    
    isFollowing
    stockId
    title
    jittaRankScore
    
    adr
    company {
      ipo_date
      first_price_date
      incorporated_date
      officer {
        title
        firstName
        lastName
        age
        yearBorn
        prefix
        suffix
        emailAddress
      }
      link {
        _id
        url
        title
      }
      address {
        line1
        line2
        city
        state
        zipcode
        country
        contry_code
      }
      phone
      fax
      foreignBuy {
        buyVolume
        ownedPercentage
        availableRoom
        totalRoom
        tradableValue
        tradableVolume
      }
    }
    createDate
    currency
    exchange
    index_membership
    market
    name
    price_currency
    ric
    shortname
    symbol
    type
    updateDate
    updatedFinancial
    split_logs
    alias
    updatedFinancialComplete
    
    localName
    
    id
    
    updatedAt
    currency_sign
    last_complete_statement_enddate
    last_complete_statement_key
    capitalIqId
    
    summary
    bussiness_type
    industry
    industryGroup
    sector {
      id
      name
    }
    status
    fundamental {
      eps
      market_cap
      shares
      dividend_per_share
      pe
      dividend
      beta
      yield
    }
    price {
      latest {
        latest_price_timestamp
        timestamp
        open
        close
        high
        low
        volume
        market_cap
        datetime
      }
      yesterday {
        latest_price_timestamp
        timestamp
        open
        close
        high
        low
        volume
        market_cap
        datetime
      }
    }
    
    primary_stock
    
    industry_group
    class_conversion_factor
    reportingTemplate
    
    nativeName
    
    actual_exchange
    funFact
  }
}
    """;
