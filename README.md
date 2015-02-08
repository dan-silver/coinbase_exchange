[![Gem Version](https://badge.fury.io/rb/coinbase_exchange.svg)](http://badge.fury.io/rb/coinbase_exchange)
# Coinbase Exchange Ruby Client
The library wraps the http request and message signing.  I may add more features in the future.

Create an account at https://exchange.coinbase.com to get started.

### NOTE - As a launch promo, there are [no Coinbase Exchange trading fees](http://blog.coinbase.com/post/109202118547/coinbase-launches-first-regulated-bitcoin-exchange) through the end of March.

## Installation
```gem install coinbase_exchange```

Or, include this in your gemfile:
```gem 'coinbase_exchange', '~> 0.0.3'```

## Example
```ruby
require "coinbase_exchange"

cbe = CoinbaseExchange.new(API_KEY, API_SECRET, API_PASSPHRASE)


# Account balance
cbe.get('accounts')
# => [{"id"=>"000ea663...", "currency"=>"USD", "balance"=>"90.0000114750000000", "hold"=>"0.0000000000000000", "available"=>"0.9000114750000000", "profile_id"=>"4409df27..."}, {"id"=>"8bfe", "currency"=>"BTC", "balance"=>"9.4426882700000000", "hold"=>"0.0000000000000000", "available"=>"5.4426882700000000", "profile_id"=>"a8f2d8..."}] 

# Create an order
cbe.post 'orders', {
    "size" => 1.01,
    "price" => 1.100,
    "side" => "buy",
    "product_id" => "BTC-USD"
}

# Product tickers
cbe.get('products/BTC-USD/ticker')
# => {"trade_id"=>125681, "price"=>"226.20000000", "size"=>"0.01570000", "time"=>"2015-02-08T04:46:17.352746Z"}
```

Block syntax is fully supported

```ruby

cbe.get('accounts') do |response|
  puts response
end

cbe.post('orders', {
    "size" => 1.01,
    "price" => 1.100,
    "side" => "buy",
    "product_id" => "BTC-USD"
}) do |response|
  puts response
end

```

