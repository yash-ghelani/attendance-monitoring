Airbrake.configure do |config|
    config.api_key = '52d3b811aab9113d96c35fafe07716f0'
    config.host    = 'errbit.hut.shefcompsci.org.uk'
    config.port    = 443
    config.secure  = config.port == 443
  end