# Coinbase Exchange Ruby Client
Currently, the library just wraps the http request and message signing.  I may add more features in the future.

Check their documentation at https://docs.exchange.coinbase.com/ to get started.

## Example
```ruby
require "coinbase_exchange"

cbe = CoinbaseExchange.new(API_KEY, API_SECRET, API_PASSPHRASE)

puts cbe.get('accounts')

# Or, with block syntax
cbe.get('accounts') do |response|
  puts response
end


puts cbe.post 'orders', {
    "size" => 1.01,
    "price" => 1.100,
    "side" => "buy",
    "product_id" => "BTC-USD"
}
```
