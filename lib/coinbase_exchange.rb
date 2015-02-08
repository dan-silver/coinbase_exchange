require 'unirest'
require "base64"
require 'openssl'
require 'json'

class CoinbaseExchangeSignatureMaker
  def initialize(key, secret, passphrase)
    @key = key
    @secret = secret
    @passphrase = passphrase
  end

  def signature(request_url='', body='', timestamp=nil, method='GET')
    body = body.to_json if body.is_a?(Hash)
    timestamp = Time.now.to_i if !timestamp

    what = "#{timestamp}#{method.upcase}#{request_url}#{body}";
    # create a sha256 hmac with the secret
    secret = Base64.decode64(@secret)
    hash  = OpenSSL::HMAC.digest('sha256', secret, what)
    Base64.strict_encode64(hash)
   end
end

class CoinbaseExchange
  API_URL = 'https://api.exchange.coinbase.com/'
  
  def initialize(key, secret, passphrase)
    @key = key
    @secret = secret
    @passphrase = passphrase
    @coinbaseExchange = CoinbaseExchangeSignatureMaker.new(key, secret, passphrase)
  end

  def request(method, uri, json=nil)
  	params = json.to_json if json
    headers = { 
          'CB-ACCESS-SIGN'=> @coinbaseExchange.signature('/'+uri, params, nil, method),
          'CB-ACCESS-TIMESTAMP'=> Time.now.to_i,
          'CB-ACCESS-KEY'=> @key,
          'CB-ACCESS-PASSPHRASE'=> @passphrase,
          'Content-Type' => 'application/json'
        }
    if method == :get
        r=Unirest.get(API_URL + uri, headers: headers)
    elsif method == :post
        r=Unirest.post(API_URL + uri, headers: headers, parameters: params)
    end
    yield r.body if block_given?
    return r.body
  end

  def get(uri, json=nil, &block)
      request(:get, uri, json, &block)
  end

  def post(uri, json=nil, &block)
      request(:post, uri, json, &block)
  end
end