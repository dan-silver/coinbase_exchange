[![Gem Version](https://badge.fury.io/rb/coinbase_exchange.svg)](http://badge.fury.io/rb/coinbase_exchange)
# Coinbase Exchange Ruby Client
Currently, the library just wraps the http request and message signing.  I may add more features in the future.

Check their documentation at https://docs.exchange.coinbase.com/ to get started.

## Example
```ruby
require "coinbase_exchange"

cbe = CoinbaseExchange.new(API_KEY, API_SECRET, API_PASSPHRASE)


# get your account balances
cbe.get('accounts')
# => [{"id"=>"000ea663...", "currency"=>"USD", "balance"=>"90.0000114750000000", "hold"=>"0.0000000000000000", "available"=>"0.9000114750000000", "profile_id"=>"4409df27..."}, {"id"=>"8bfe", "currency"=>"BTC", "balance"=>"9.4426882700000000", "hold"=>"0.0000000000000000", "available"=>"5.4426882700000000", "profile_id"=>"a8f2d8..."}] 

# Create an order
cbe.post 'orders', {
    "size" => 1.01,
    "price" => 1.100,
    "side" => "buy",
    "product_id" => "BTC-USD"
}

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

